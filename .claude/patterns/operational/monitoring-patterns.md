# Monitoring Patterns

## Overview

Monitoring patterns provide comprehensive strategies for observing, measuring, and understanding system behavior in production. These patterns enable teams to detect issues early, optimize performance, and ensure reliability through data-driven insights.

## Observability Patterns

### Metrics Collection

```typescript
// Metrics collector with multiple backends
class MetricsCollector {
  private backends: MetricsBackend[] = [];
  private buffer: MetricBuffer;
  private aggregator: MetricAggregator;

  constructor(config: MetricsConfig) {
    this.buffer = new MetricBuffer(config.bufferSize);
    this.aggregator = new MetricAggregator(config.aggregation);
    this.initializeBackends(config.backends);
    this.startFlushInterval(config.flushInterval);
  }

  // Counter metric
  increment(name: string, value: number = 1, tags?: Tags): void {
    const metric: CounterMetric = {
      type: 'counter',
      name,
      value,
      tags,
      timestamp: Date.now()
    };
    
    this.buffer.add(metric);
  }

  // Gauge metric
  gauge(name: string, value: number, tags?: Tags): void {
    const metric: GaugeMetric = {
      type: 'gauge',
      name,
      value,
      tags,
      timestamp: Date.now()
    };
    
    this.buffer.add(metric);
  }

  // Histogram metric
  histogram(name: string, value: number, tags?: Tags): void {
    const metric: HistogramMetric = {
      type: 'histogram',
      name,
      value,
      tags,
      timestamp: Date.now()
    };
    
    this.buffer.add(metric);
  }

  // Timer metric
  async time<T>(
    name: string,
    operation: () => Promise<T>,
    tags?: Tags
  ): Promise<T> {
    const start = process.hrtime.bigint();
    
    try {
      const result = await operation();
      const duration = Number(process.hrtime.bigint() - start) / 1e6; // ms
      
      this.histogram(`${name}.duration`, duration, tags);
      this.increment(`${name}.success`, 1, tags);
      
      return result;
    } catch (error) {
      const duration = Number(process.hrtime.bigint() - start) / 1e6;
      
      this.histogram(`${name}.duration`, duration, tags);
      this.increment(`${name}.error`, 1, { ...tags, error: error.name });
      
      throw error;
    }
  }

  private async flush(): Promise<void> {
    const metrics = this.buffer.drain();
    if (metrics.length === 0) return;

    // Aggregate metrics
    const aggregated = this.aggregator.aggregate(metrics);

    // Send to all backends
    await Promise.allSettled(
      this.backends.map(backend => backend.send(aggregated))
    );
  }
}

// Custom metrics with business context
class BusinessMetrics extends MetricsCollector {
  // Track user actions
  trackUserAction(action: string, userId: string, metadata?: any): void {
    this.increment('user.action', 1, {
      action,
      userId,
      ...metadata
    });
  }

  // Track revenue metrics
  trackRevenue(amount: number, currency: string, source: string): void {
    this.histogram('revenue.amount', amount, {
      currency,
      source
    });
    
    this.increment('revenue.transactions', 1, {
      currency,
      source
    });
  }

  // Track API performance
  async trackApiCall(
    endpoint: string,
    method: string,
    handler: () => Promise<any>
  ): Promise<any> {
    return this.time('api.request', handler, {
      endpoint,
      method
    });
  }

  // Track feature usage
  trackFeatureUsage(feature: string, variant?: string): void {
    this.increment('feature.usage', 1, {
      feature,
      variant: variant || 'default'
    });
  }
}
```

### Distributed Tracing

```typescript
// Distributed tracing implementation
class DistributedTracer {
  private spanStack: Span[] = [];
  private exporter: SpanExporter;

  constructor(config: TracerConfig) {
    this.exporter = this.createExporter(config);
  }

  // Create root span
  startSpan(name: string, attributes?: Attributes): Span {
    const span = new Span({
      traceId: this.generateTraceId(),
      spanId: this.generateSpanId(),
      name,
      attributes,
      startTime: Date.now()
    });

    this.spanStack.push(span);
    return span;
  }

  // Create child span
  startChildSpan(name: string, attributes?: Attributes): Span {
    const parent = this.getCurrentSpan();
    
    const span = new Span({
      traceId: parent?.traceId || this.generateTraceId(),
      spanId: this.generateSpanId(),
      parentSpanId: parent?.spanId,
      name,
      attributes,
      startTime: Date.now()
    });

    this.spanStack.push(span);
    return span;
  }

  // End span and export
  endSpan(span: Span): void {
    span.endTime = Date.now();
    span.duration = span.endTime - span.startTime;

    // Remove from stack
    const index = this.spanStack.indexOf(span);
    if (index > -1) {
      this.spanStack.splice(index, 1);
    }

    // Export span
    this.exporter.export(span);
  }

  // Add event to current span
  addEvent(name: string, attributes?: Attributes): void {
    const span = this.getCurrentSpan();
    if (span) {
      span.addEvent({
        name,
        attributes,
        timestamp: Date.now()
      });
    }
  }

  // Set span status
  setStatus(code: StatusCode, message?: string): void {
    const span = this.getCurrentSpan();
    if (span) {
      span.setStatus({ code, message });
    }
  }

  private getCurrentSpan(): Span | undefined {
    return this.spanStack[this.spanStack.length - 1];
  }
}

// HTTP instrumentation
class HttpInstrumentation {
  constructor(private tracer: DistributedTracer) {}

  instrumentRequest(req: Request, res: Response, next: NextFunction): void {
    const span = this.tracer.startSpan('http.request', {
      'http.method': req.method,
      'http.url': req.url,
      'http.target': req.path,
      'http.host': req.hostname,
      'http.scheme': req.protocol,
      'http.user_agent': req.headers['user-agent']
    });

    // Inject trace context into headers
    req.headers['x-trace-id'] = span.traceId;
    req.headers['x-span-id'] = span.spanId;

    // Override res.end to capture response
    const originalEnd = res.end;
    res.end = (...args: any[]): Response => {
      span.setAttribute('http.status_code', res.statusCode);
      span.setAttribute('http.response_size', res.get('content-length'));
      
      if (res.statusCode >= 400) {
        span.setStatus(StatusCode.ERROR, `HTTP ${res.statusCode}`);
      } else {
        span.setStatus(StatusCode.OK);
      }

      this.tracer.endSpan(span);
      return originalEnd.apply(res, args);
    };

    next();
  }
}

// Database instrumentation
class DatabaseInstrumentation {
  constructor(
    private tracer: DistributedTracer,
    private db: Database
  ) {
    this.instrumentDatabase();
  }

  private instrumentDatabase(): void {
    const originalQuery = this.db.query.bind(this.db);
    
    this.db.query = async (sql: string, params?: any[]): Promise<any> => {
      const span = this.tracer.startChildSpan('db.query', {
        'db.system': 'postgresql',
        'db.statement': this.sanitizeSql(sql),
        'db.operation': this.extractOperation(sql)
      });

      try {
        const result = await originalQuery(sql, params);
        span.setAttribute('db.rows_affected', result.rowCount);
        span.setStatus(StatusCode.OK);
        return result;
      } catch (error) {
        span.setStatus(StatusCode.ERROR, error.message);
        span.setAttribute('error', true);
        span.setAttribute('error.message', error.message);
        throw error;
      } finally {
        this.tracer.endSpan(span);
      }
    };
  }

  private sanitizeSql(sql: string): string {
    // Remove sensitive data from SQL
    return sql.replace(/\b\d{4,}\b/g, '?') // Replace numbers
              .replace(/'[^']*'/g, '?')     // Replace string literals
              .trim();
  }

  private extractOperation(sql: string): string {
    const operation = sql.trim().split(' ')[0].toUpperCase();
    return operation;
  }
}
```

### Structured Logging

```typescript
// Structured logger with context
class StructuredLogger {
  private context: LogContext = {};
  private outputs: LogOutput[] = [];
  private middleware: LogMiddleware[] = [];

  constructor(config: LoggerConfig) {
    this.initializeOutputs(config.outputs);
    this.initializeMiddleware(config.middleware);
  }

  // Log with level
  log(level: LogLevel, message: string, data?: any): void {
    const entry: LogEntry = {
      timestamp: new Date().toISOString(),
      level,
      message,
      data,
      context: { ...this.context },
      trace: this.getTraceContext()
    };

    // Apply middleware
    const processedEntry = this.applyMiddleware(entry);

    // Send to outputs
    this.outputs.forEach(output => {
      output.write(processedEntry);
    });
  }

  // Convenience methods
  debug(message: string, data?: any): void {
    this.log('debug', message, data);
  }

  info(message: string, data?: any): void {
    this.log('info', message, data);
  }

  warn(message: string, data?: any): void {
    this.log('warn', message, data);
  }

  error(message: string, error?: Error, data?: any): void {
    this.log('error', message, {
      ...data,
      error: {
        name: error?.name,
        message: error?.message,
        stack: error?.stack
      }
    });
  }

  // Create child logger with additional context
  child(context: LogContext): StructuredLogger {
    const childLogger = Object.create(this);
    childLogger.context = { ...this.context, ...context };
    return childLogger;
  }

  // Set context for all future logs
  setContext(context: LogContext): void {
    Object.assign(this.context, context);
  }

  // Correlation across services
  private getTraceContext(): TraceContext | undefined {
    // Get from async local storage or thread local
    const traceId = AsyncLocalStorage.getStore()?.traceId;
    const spanId = AsyncLocalStorage.getStore()?.spanId;
    
    if (traceId) {
      return { traceId, spanId };
    }
  }

  private applyMiddleware(entry: LogEntry): LogEntry {
    return this.middleware.reduce(
      (acc, middleware) => middleware.process(acc),
      entry
    );
  }
}

// Log middleware for sensitive data
class SensitiveDataMiddleware implements LogMiddleware {
  private patterns = [
    /\b\d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}\b/g, // Credit cards
    /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g, // Emails
    /\b\d{3}-\d{2}-\d{4}\b/g, // SSN
    /"password"\s*:\s*"[^"]+"/g, // Password fields
    /"token"\s*:\s*"[^"]+"/g, // Token fields
  ];

  process(entry: LogEntry): LogEntry {
    const sanitized = JSON.parse(JSON.stringify(entry));
    
    // Sanitize message
    sanitized.message = this.sanitize(sanitized.message);
    
    // Sanitize data recursively
    if (sanitized.data) {
      sanitized.data = this.sanitizeObject(sanitized.data);
    }
    
    return sanitized;
  }

  private sanitize(text: string): string {
    let sanitized = text;
    this.patterns.forEach(pattern => {
      sanitized = sanitized.replace(pattern, '[REDACTED]');
    });
    return sanitized;
  }

  private sanitizeObject(obj: any): any {
    if (typeof obj === 'string') {
      return this.sanitize(obj);
    }
    
    if (Array.isArray(obj)) {
      return obj.map(item => this.sanitizeObject(item));
    }
    
    if (obj && typeof obj === 'object') {
      const sanitized: any = {};
      for (const [key, value] of Object.entries(obj)) {
        if (this.isSensitiveKey(key)) {
          sanitized[key] = '[REDACTED]';
        } else {
          sanitized[key] = this.sanitizeObject(value);
        }
      }
      return sanitized;
    }
    
    return obj;
  }

  private isSensitiveKey(key: string): boolean {
    const sensitiveKeys = ['password', 'token', 'secret', 'api_key', 'private_key'];
    return sensitiveKeys.some(sensitive => 
      key.toLowerCase().includes(sensitive)
    );
  }
}
```

## Alert Patterns

### Threshold-Based Alerts

```typescript
// Alert manager with multiple strategies
class AlertManager {
  private rules: AlertRule[] = [];
  private channels: AlertChannel[] = [];
  private state: AlertState = new Map();

  constructor(config: AlertConfig) {
    this.initializeChannels(config.channels);
    this.loadRules(config.rules);
    this.startEvaluation(config.evaluationInterval);
  }

  // Define alert rule
  addRule(rule: AlertRule): void {
    this.rules.push(rule);
    this.state.set(rule.id, {
      status: 'inactive',
      lastEvaluation: null,
      lastChange: null
    });
  }

  // Evaluate all rules
  private async evaluateRules(): Promise<void> {
    for (const rule of this.rules) {
      await this.evaluateRule(rule);
    }
  }

  private async evaluateRule(rule: AlertRule): Promise<void> {
    try {
      const result = await rule.condition.evaluate();
      const currentState = this.state.get(rule.id)!;
      
      if (result.firing && currentState.status !== 'firing') {
        // Alert started firing
        await this.fireAlert(rule, result);
        currentState.status = 'firing';
        currentState.lastChange = Date.now();
      } else if (!result.firing && currentState.status === 'firing') {
        // Alert resolved
        await this.resolveAlert(rule);
        currentState.status = 'resolved';
        currentState.lastChange = Date.now();
      }
      
      currentState.lastEvaluation = Date.now();
    } catch (error) {
      console.error(`Error evaluating rule ${rule.id}:`, error);
    }
  }

  private async fireAlert(rule: AlertRule, result: EvaluationResult): Promise<void> {
    const alert: Alert = {
      id: generateId(),
      ruleId: rule.id,
      name: rule.name,
      severity: rule.severity,
      message: this.interpolateMessage(rule.message, result.values),
      labels: rule.labels,
      annotations: rule.annotations,
      startsAt: new Date(),
      values: result.values
    };

    // Send to all channels
    await Promise.allSettled(
      this.channels
        .filter(channel => this.shouldSendToChannel(alert, channel))
        .map(channel => channel.send(alert))
    );

    // Store alert history
    await this.storeAlert(alert);
  }
}

// Complex alert conditions
class AlertCondition {
  constructor(
    private metric: string,
    private operator: ComparisonOperator,
    private threshold: number,
    private duration?: string
  ) {}

  async evaluate(): Promise<EvaluationResult> {
    const values = await this.fetchMetricValues();
    
    if (this.duration) {
      // Check if condition is true for entire duration
      const durationMs = parseDuration(this.duration);
      const relevantValues = values.filter(v => 
        v.timestamp > Date.now() - durationMs
      );
      
      const allTrue = relevantValues.every(v => 
        this.compare(v.value, this.threshold)
      );
      
      return {
        firing: allTrue && relevantValues.length > 0,
        values: relevantValues
      };
    } else {
      // Check latest value only
      const latest = values[values.length - 1];
      return {
        firing: latest ? this.compare(latest.value, this.threshold) : false,
        values: latest ? [latest] : []
      };
    }
  }

  private compare(value: number, threshold: number): boolean {
    switch (this.operator) {
      case '>': return value > threshold;
      case '>=': return value >= threshold;
      case '<': return value < threshold;
      case '<=': return value <= threshold;
      case '==': return value === threshold;
      case '!=': return value !== threshold;
      default: return false;
    }
  }
}

// Alert routing and grouping
class AlertRouter {
  private routes: Route[] = [];

  addRoute(route: Route): void {
    this.routes.push(route);
  }

  route(alert: Alert): AlertChannel[] {
    const matchingRoutes = this.routes.filter(route => 
      this.matchesRoute(alert, route)
    );

    // Get unique channels from matching routes
    const channels = new Set<AlertChannel>();
    matchingRoutes.forEach(route => {
      route.channels.forEach(channel => channels.add(channel));
    });

    return Array.from(channels);
  }

  private matchesRoute(alert: Alert, route: Route): boolean {
    // Match by severity
    if (route.severities && !route.severities.includes(alert.severity)) {
      return false;
    }

    // Match by labels
    if (route.labelMatchers) {
      return route.labelMatchers.every(matcher => 
        this.matchesLabel(alert.labels, matcher)
      );
    }

    return true;
  }

  private matchesLabel(labels: Labels, matcher: LabelMatcher): boolean {
    const value = labels[matcher.name];
    
    switch (matcher.operator) {
      case '=': return value === matcher.value;
      case '!=': return value !== matcher.value;
      case '=~': return new RegExp(matcher.value).test(value);
      case '!~': return !new RegExp(matcher.value).test(value);
      default: return false;
    }
  }
}
```

### Anomaly Detection

```typescript
// Anomaly detection engine
class AnomalyDetector {
  private detectors: Map<string, Detector> = new Map();
  private history: MetricHistory;

  constructor(config: AnomalyConfig) {
    this.history = new MetricHistory(config.historySize);
    this.initializeDetectors(config.detectors);
  }

  // Statistical anomaly detection
  addStatisticalDetector(
    metric: string,
    options: StatisticalOptions = {}
  ): void {
    const detector = new StatisticalAnomalyDetector({
      sensitivity: options.sensitivity || 3, // 3 standard deviations
      minSamples: options.minSamples || 100,
      seasonality: options.seasonality
    });

    this.detectors.set(metric, detector);
  }

  // Machine learning based detection
  addMLDetector(
    metric: string,
    model: AnomalyModel
  ): void {
    const detector = new MLAnomalyDetector(model);
    this.detectors.set(metric, detector);
  }

  // Detect anomalies in metric
  async detectAnomalies(metric: string, value: number): Promise<AnomalyResult> {
    // Store value in history
    this.history.add(metric, value);

    const detector = this.detectors.get(metric);
    if (!detector) {
      return { isAnomaly: false };
    }

    const historicalData = this.history.get(metric);
    return detector.detect(value, historicalData);
  }
}

// Statistical anomaly detector
class StatisticalAnomalyDetector implements Detector {
  constructor(private options: StatisticalOptions) {}

  detect(value: number, history: DataPoint[]): AnomalyResult {
    if (history.length < this.options.minSamples) {
      return { isAnomaly: false, reason: 'Insufficient data' };
    }

    // Remove seasonal effects if configured
    const deseasonalized = this.options.seasonality
      ? this.removeSeasonality(history)
      : history;

    // Calculate statistics
    const values = deseasonalized.map(d => d.value);
    const mean = this.calculateMean(values);
    const stdDev = this.calculateStdDev(values, mean);

    // Check if value is outside bounds
    const zScore = Math.abs((value - mean) / stdDev);
    const isAnomaly = zScore > this.options.sensitivity;

    return {
      isAnomaly,
      score: zScore,
      expectedRange: {
        lower: mean - (this.options.sensitivity * stdDev),
        upper: mean + (this.options.sensitivity * stdDev)
      },
      reason: isAnomaly 
        ? `Value ${value} is ${zScore.toFixed(2)} standard deviations from mean`
        : undefined
    };
  }

  private removeSeasonality(data: DataPoint[]): DataPoint[] {
    const period = this.options.seasonality!.period;
    const decomposed = this.seasonalDecompose(data, period);
    
    return data.map((point, i) => ({
      ...point,
      value: point.value - decomposed.seasonal[i]
    }));
  }

  private seasonalDecompose(
    data: DataPoint[],
    period: number
  ): SeasonalDecomposition {
    // Simple moving average decomposition
    const trend = this.calculateMovingAverage(data, period);
    const detrended = data.map((d, i) => d.value - trend[i]);
    
    // Calculate seasonal component
    const seasonal = new Array(data.length).fill(0);
    for (let i = 0; i < data.length; i++) {
      const seasonIndex = i % period;
      const seasonValues = [];
      
      for (let j = seasonIndex; j < detrended.length; j += period) {
        seasonValues.push(detrended[j]);
      }
      
      seasonal[i] = this.calculateMean(seasonValues);
    }

    return { trend, seasonal };
  }
}

// Predictive alerting
class PredictiveAlerter {
  private forecaster: Forecaster;
  private alertManager: AlertManager;

  constructor(config: PredictiveAlertConfig) {
    this.forecaster = new Forecaster(config.model);
    this.alertManager = new AlertManager(config.alertConfig);
  }

  async evaluatePredictiveAlert(
    metric: string,
    rule: PredictiveRule
  ): Promise<void> {
    // Get historical data
    const history = await this.getMetricHistory(metric);
    
    // Forecast future values
    const forecast = await this.forecaster.forecast(
      history,
      rule.forecastHorizon
    );

    // Check if forecasted values will breach threshold
    const breachPoint = forecast.values.findIndex(v => 
      this.checkThreshold(v.value, rule.threshold, rule.operator)
    );

    if (breachPoint !== -1) {
      const timeUntilBreach = forecast.values[breachPoint].timestamp - Date.now();
      
      await this.alertManager.fireAlert({
        name: `Predictive: ${rule.name}`,
        message: `${metric} is predicted to ${rule.operator} ${rule.threshold} in ${this.formatDuration(timeUntilBreach)}`,
        severity: this.calculateSeverity(timeUntilBreach, rule),
        labels: {
          type: 'predictive',
          metric,
          forecast_confidence: forecast.confidence.toString()
        }
      });
    }
  }

  private calculateSeverity(
    timeUntilBreach: number,
    rule: PredictiveRule
  ): Severity {
    if (timeUntilBreach < 5 * 60 * 1000) return 'critical'; // < 5 min
    if (timeUntilBreach < 30 * 60 * 1000) return 'warning'; // < 30 min
    return 'info';
  }
}
```

## Dashboard Patterns

### Executive Dashboard

```typescript
// Executive dashboard builder
class ExecutiveDashboard {
  private widgets: Widget[] = [];
  private refreshInterval: number = 60000; // 1 minute
  private dataSource: DataSource;

  constructor(config: DashboardConfig) {
    this.dataSource = new DataSource(config.datasource);
    this.setupAutoRefresh();
  }

  // Add KPI widget
  addKPIWidget(config: KPIWidgetConfig): void {
    const widget = new KPIWidget({
      ...config,
      query: this.buildKPIQuery(config.metric, config.aggregation),
      formatter: this.createFormatter(config.format),
      sparkline: config.showSparkline
    });

    this.widgets.push(widget);
  }

  // Add trend widget
  addTrendWidget(config: TrendWidgetConfig): void {
    const widget = new TrendWidget({
      ...config,
      queries: config.metrics.map(m => ({
        metric: m,
        query: this.buildTrendQuery(m, config.period)
      })),
      comparison: config.compareWithPrevious
    });

    this.widgets.push(widget);
  }

  // Add summary widget
  addSummaryWidget(config: SummaryWidgetConfig): void {
    const widget = new SummaryWidget({
      ...config,
      sections: config.sections.map(section => ({
        title: section.title,
        metrics: section.metrics.map(m => ({
          label: m.label,
          query: this.buildSummaryQuery(m.metric),
          threshold: m.threshold,
          format: m.format
        }))
      }))
    });

    this.widgets.push(widget);
  }

  // Build complete dashboard
  async render(): Promise<DashboardData> {
    const widgetData = await Promise.all(
      this.widgets.map(w => w.getData())
    );

    return {
      title: 'Executive Dashboard',
      lastUpdated: new Date(),
      widgets: widgetData,
      summary: this.generateExecutiveSummary(widgetData)
    };
  }

  private generateExecutiveSummary(data: WidgetData[]): ExecutiveSummary {
    // Analyze all widget data
    const kpis = data.filter(d => d.type === 'kpi');
    const trends = data.filter(d => d.type === 'trend');

    // Generate insights
    const insights: Insight[] = [];

    // Check KPI thresholds
    kpis.forEach(kpi => {
      if (kpi.value < kpi.threshold * 0.9) {
        insights.push({
          type: 'warning',
          message: `${kpi.title} is below target`,
          metric: kpi.metric,
          current: kpi.value,
          target: kpi.threshold
        });
      }
    });

    // Analyze trends
    trends.forEach(trend => {
      const direction = this.analyzeTrend(trend.data);
      if (direction.significant) {
        insights.push({
          type: direction.direction === 'up' ? 'positive' : 'negative',
          message: `${trend.title} trending ${direction.direction} by ${direction.percentage}%`,
          metric: trend.metric
        });
      }
    });

    return {
      overallHealth: this.calculateOverallHealth(data),
      insights,
      recommendations: this.generateRecommendations(insights)
    };
  }
}

// Real-time operational dashboard
class OperationalDashboard {
  private websocket: WebSocket;
  private metrics: Map<string, RealtimeMetric> = new Map();
  private alerts: Alert[] = [];

  constructor(config: OperationalConfig) {
    this.connectWebSocket(config.websocketUrl);
    this.setupMetrics(config.metrics);
    this.setupAlertStream(config.alertStream);
  }

  private connectWebSocket(url: string): void {
    this.websocket = new WebSocket(url);
    
    this.websocket.on('message', (data: string) => {
      const message = JSON.parse(data);
      
      switch (message.type) {
        case 'metric':
          this.updateMetric(message.metric, message.value);
          break;
        case 'alert':
          this.handleAlert(message.alert);
          break;
        case 'event':
          this.handleEvent(message.event);
          break;
      }
    });
  }

  // System health overview
  getSystemHealth(): SystemHealth {
    const services = this.getServiceStatuses();
    const metrics = this.getKeyMetrics();
    const activeAlerts = this.alerts.filter(a => a.status === 'firing');

    return {
      status: this.calculateSystemStatus(services, activeAlerts),
      services,
      metrics,
      alerts: activeAlerts,
      lastCheck: new Date()
    };
  }

  // Service status grid
  private getServiceStatuses(): ServiceStatus[] {
    return Array.from(this.metrics.entries())
      .filter(([key]) => key.startsWith('service.'))
      .map(([key, metric]) => ({
        name: key.replace('service.', ''),
        status: this.getServiceStatus(metric),
        uptime: metric.uptime,
        responseTime: metric.responseTime,
        errorRate: metric.errorRate,
        throughput: metric.throughput
      }));
  }

  private getServiceStatus(metric: RealtimeMetric): Status {
    if (!metric.healthy) return 'critical';
    if (metric.errorRate > 5) return 'warning';
    if (metric.responseTime > metric.sla) return 'degraded';
    return 'healthy';
  }
}

// Technical dashboard with drill-down
class TechnicalDashboard {
  private panels: Panel[] = [];
  private drillDownHandlers: Map<string, DrillDownHandler> = new Map();

  // Infrastructure panel
  addInfrastructurePanel(): void {
    const panel = new InfrastructurePanel({
      title: 'Infrastructure Overview',
      sections: [
        {
          name: 'Compute',
          metrics: ['cpu.usage', 'memory.usage', 'disk.io', 'network.io']
        },
        {
          name: 'Database',
          metrics: ['db.connections', 'db.query_time', 'db.locks', 'db.replication_lag']
        },
        {
          name: 'Cache',
          metrics: ['cache.hit_rate', 'cache.evictions', 'cache.memory', 'cache.connections']
        }
      ]
    });

    this.panels.push(panel);
  }

  // Application performance panel
  addPerformancePanel(): void {
    const panel = new PerformancePanel({
      title: 'Application Performance',
      metrics: {
        latency: {
          percentiles: [50, 75, 90, 95, 99],
          breakdown: ['database', 'cache', 'external_api', 'processing']
        },
        throughput: {
          interval: '1m',
          groupBy: 'endpoint'
        },
        errors: {
          groupBy: 'type',
          includeStackTrace: true
        }
      }
    });

    // Add drill-down capability
    this.drillDownHandlers.set('performance', async (metric, timeRange) => {
      const details = await this.getPerformanceDetails(metric, timeRange);
      return new PerformanceDetailView(details);
    });

    this.panels.push(panel);
  }

  // Enable drill-down navigation
  async drillDown(panelId: string, metric: string, context: any): Promise<View> {
    const handler = this.drillDownHandlers.get(panelId);
    if (!handler) {
      throw new Error(`No drill-down handler for panel ${panelId}`);
    }

    return handler(metric, context);
  }
}
```

## Health Check Patterns

### Health Check Implementation

```typescript
// Comprehensive health check system
class HealthCheckSystem {
  private checks: Map<string, HealthCheck> = new Map();
  private dependencies: Map<string, string[]> = new Map();
  private cache: HealthCache;

  constructor(config: HealthCheckConfig) {
    this.cache = new HealthCache(config.cacheTimeout);
    this.registerDefaultChecks();
  }

  // Register health check
  register(name: string, check: HealthCheck, dependencies?: string[]): void {
    this.checks.set(name, check);
    if (dependencies) {
      this.dependencies.set(name, dependencies);
    }
  }

  // Liveness probe - is the application running?
  async checkLiveness(): Promise<HealthStatus> {
    const checks = ['process', 'memory'];
    const results = await this.runChecks(checks);
    
    return {
      status: this.aggregateStatus(results),
      checks: results,
      timestamp: new Date()
    };
  }

  // Readiness probe - is the application ready to serve traffic?
  async checkReadiness(): Promise<HealthStatus> {
    const checks = ['database', 'cache', 'dependencies'];
    const results = await this.runChecks(checks);
    
    return {
      status: this.aggregateStatus(results),
      checks: results,
      timestamp: new Date()
    };
  }

  // Startup probe - for slow starting applications
  async checkStartup(): Promise<HealthStatus> {
    const checks = ['initialization', 'migrations', 'warmup'];
    const results = await this.runChecks(checks);
    
    return {
      status: this.aggregateStatus(results),
      checks: results,
      timestamp: new Date()
    };
  }

  // Deep health check with all dependencies
  async checkDeep(): Promise<DeepHealthStatus> {
    const allChecks = Array.from(this.checks.keys());
    const results = await this.runChecks(allChecks, { 
      parallel: false, 
      includeDetails: true 
    });

    // Build dependency tree
    const dependencyTree = this.buildDependencyTree(results);

    return {
      status: this.aggregateStatus(results),
      checks: results,
      dependencies: dependencyTree,
      timestamp: new Date(),
      version: process.env.APP_VERSION,
      uptime: process.uptime()
    };
  }

  private async runChecks(
    checkNames: string[],
    options: RunOptions = {}
  ): Promise<CheckResult[]> {
    const { parallel = true, includeDetails = false } = options;

    if (parallel) {
      return Promise.all(
        checkNames.map(name => this.runCheck(name, includeDetails))
      );
    } else {
      const results: CheckResult[] = [];
      for (const name of checkNames) {
        results.push(await this.runCheck(name, includeDetails));
      }
      return results;
    }
  }

  private async runCheck(
    name: string,
    includeDetails: boolean
  ): Promise<CheckResult> {
    // Check cache first
    const cached = this.cache.get(name);
    if (cached && !includeDetails) {
      return cached;
    }

    const check = this.checks.get(name);
    if (!check) {
      return {
        name,
        status: 'unknown',
        message: 'Check not found'
      };
    }

    const startTime = Date.now();
    
    try {
      const result = await check.execute();
      const duration = Date.now() - startTime;

      const checkResult: CheckResult = {
        name,
        status: result.healthy ? 'healthy' : 'unhealthy',
        message: result.message,
        duration,
        details: includeDetails ? result.details : undefined
      };

      // Cache successful results
      if (result.healthy) {
        this.cache.set(name, checkResult);
      }

      return checkResult;
    } catch (error) {
      return {
        name,
        status: 'unhealthy',
        message: error.message,
        duration: Date.now() - startTime,
        error: error.stack
      };
    }
  }
}

// Specific health checks
class DatabaseHealthCheck implements HealthCheck {
  constructor(private db: Database) {}

  async execute(): Promise<HealthCheckResult> {
    try {
      // Check connection
      const start = Date.now();
      await this.db.query('SELECT 1');
      const queryTime = Date.now() - start;

      // Check connection pool
      const poolStats = await this.db.getPoolStats();
      
      // Check replication lag (if applicable)
      const replicationLag = await this.checkReplicationLag();

      const healthy = queryTime < 100 && 
                     poolStats.available > 0 &&
                     (!replicationLag || replicationLag < 1000);

      return {
        healthy,
        message: healthy ? 'Database is healthy' : 'Database issues detected',
        details: {
          queryTime,
          poolStats,
          replicationLag
        }
      };
    } catch (error) {
      return {
        healthy: false,
        message: `Database connection failed: ${error.message}`
      };
    }
  }

  private async checkReplicationLag(): Promise<number | null> {
    try {
      const result = await this.db.query(`
        SELECT EXTRACT(EPOCH FROM (now() - pg_last_xact_replay_timestamp())) * 1000 as lag_ms
      `);
      return result.rows[0]?.lag_ms || null;
    } catch {
      return null;
    }
  }
}

// Dependency health check
class DependencyHealthCheck implements HealthCheck {
  constructor(
    private dependencies: ServiceDependency[]
  ) {}

  async execute(): Promise<HealthCheckResult> {
    const results = await Promise.allSettled(
      this.dependencies.map(dep => this.checkDependency(dep))
    );

    const unhealthy = results.filter(r => 
      r.status === 'rejected' || !r.value.healthy
    );

    return {
      healthy: unhealthy.length === 0,
      message: unhealthy.length === 0 
        ? 'All dependencies are healthy'
        : `${unhealthy.length} dependencies are unhealthy`,
      details: {
        dependencies: results.map((r, i) => ({
          name: this.dependencies[i].name,
          healthy: r.status === 'fulfilled' && r.value.healthy,
          message: r.status === 'fulfilled' 
            ? r.value.message 
            : r.reason.message
        }))
      }
    };
  }

  private async checkDependency(
    dependency: ServiceDependency
  ): Promise<HealthCheckResult> {
    try {
      const response = await fetch(`${dependency.url}/health`, {
        timeout: dependency.timeout || 5000
      });

      return {
        healthy: response.status === 200,
        message: `${dependency.name} returned ${response.status}`
      };
    } catch (error) {
      return {
        healthy: false,
        message: `Failed to reach ${dependency.name}: ${error.message}`
      };
    }
  }
}
```

## Integration with AugmentedClaude Specialists

```typescript
// MonitoringArchitect Specialist
const monitoringArchitect = {
  designMonitoringStrategy: async (systemArchitecture: SystemArchitecture) => {
    return {
      observabilityStack: {
        metrics: 'Prometheus + Grafana',
        logs: 'ELK Stack (Elasticsearch, Logstash, Kibana)',
        traces: 'Jaeger for distributed tracing',
        events: 'Apache Kafka for event streaming'
      },
      keyMetrics: [
        {
          name: 'Golden Signals',
          metrics: ['latency', 'traffic', 'errors', 'saturation'],
          dashboards: ['service-overview', 'sli-slo-tracking']
        },
        {
          name: 'Business KPIs',
          metrics: ['conversion_rate', 'revenue', 'user_engagement'],
          dashboards: ['executive-dashboard', 'business-metrics']
        }
      ],
      alertingStrategy: {
        channels: ['PagerDuty for critical', 'Slack for warnings', 'Email for info'],
        escalation: {
          critical: 'Page on-call immediately',
          warning: 'Notify team channel',
          info: 'Log to tracking system'
        }
      },
      implementation: [
        'Deploy monitoring infrastructure',
        'Instrument application code',
        'Create dashboards and alerts',
        'Train team on tools'
      ]
    };
  }
};

// ReliabilityEngineer Specialist
const reliabilityEngineer = {
  implementSLIs: async (service: Service) => {
    return {
      slis: [
        {
          name: 'availability',
          definition: 'Percentage of successful requests',
          query: 'sum(rate(http_requests_total{status!~"5.."}[5m])) / sum(rate(http_requests_total[5m]))',
          target: 0.999
        },
        {
          name: 'latency',
          definition: '95th percentile response time < 200ms',
          query: 'histogram_quantile(0.95, http_request_duration_seconds_bucket)',
          target: 0.95
        }
      ],
      slos: [
        {
          name: 'Monthly uptime',
          sli: 'availability',
          target: 0.999,
          errorBudget: '43.2 minutes'
        }
      ],
      monitoring: {
        dashboards: ['sli-overview', 'error-budget-tracking'],
        alerts: ['error-budget-burn-rate', 'slo-violation']
      }
    };
  }
};
```

## Best Practices

1. **Monitor What Matters**: Focus on user-facing metrics and business KPIs
2. **Use SLIs/SLOs**: Define clear service level indicators and objectives
3. **Avoid Alert Fatigue**: Only alert on actionable issues
4. **Correlate Data**: Connect metrics, logs, and traces for full visibility
5. **Automate Response**: Build runbooks and automated remediation

## Common Pitfalls

1. **Too Many Metrics**: Collecting data without clear purpose
2. **Missing Context**: Alerts without enough information to act
3. **Static Thresholds**: Not adapting to changing baselines
4. **Siloed Monitoring**: Separate tools without correlation
5. **No Documentation**: Missing runbooks for incident response

## Conclusion

Effective monitoring patterns enable teams to maintain high system reliability and performance. By implementing comprehensive observability, intelligent alerting, and actionable dashboards, organizations can detect and resolve issues quickly while continuously improving their systems.