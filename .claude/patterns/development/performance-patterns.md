# Performance Patterns

## Overview

Performance patterns provide proven strategies for optimizing application speed, scalability, and resource utilization. These patterns address common performance bottlenecks and help teams build high-performance systems that deliver exceptional user experiences.

## Frontend Performance Patterns

### Code Splitting

Dynamic imports and lazy loading to reduce initial bundle size.

```typescript
// Route-based code splitting
const routes = [
  {
    path: '/',
    component: () => import('./pages/Home'),
  },
  {
    path: '/dashboard',
    component: () => import('./pages/Dashboard'),
    preload: true // Preload on hover/focus
  },
  {
    path: '/admin',
    component: () => import('./pages/Admin'),
    guard: requireAuth
  }
];

// Component-level code splitting
const HeavyComponent = lazy(() => 
  import(/* webpackChunkName: "heavy-component" */ './components/HeavyComponent')
);

function App() {
  const [showHeavy, setShowHeavy] = useState(false);

  return (
    <div>
      <button onClick={() => setShowHeavy(true)}>
        Load Heavy Component
      </button>
      
      {showHeavy && (
        <Suspense fallback={<LoadingSpinner />}>
          <HeavyComponent />
        </Suspense>
      )}
    </div>
  );
}

// Progressive enhancement with code splitting
class ProgressiveFeature {
  async enhance(element: HTMLElement): Promise<void> {
    // Only load enhancement code when needed
    const { EnhancedWidget } = await import('./EnhancedWidget');
    
    const widget = new EnhancedWidget(element);
    widget.initialize();
  }
}

// Webpack configuration for optimal splitting
module.exports = {
  optimization: {
    splitChunks: {
      chunks: 'all',
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: 'vendors',
          priority: 10,
          reuseExistingChunk: true
        },
        common: {
          minChunks: 2,
          priority: 5,
          reuseExistingChunk: true
        }
      }
    }
  }
};
```

### Lazy Loading Strategies

```typescript
// Intersection Observer for lazy loading
class LazyLoader {
  private observer: IntersectionObserver;
  private loadedElements = new WeakSet<Element>();

  constructor() {
    this.observer = new IntersectionObserver(
      (entries) => this.handleIntersection(entries),
      {
        rootMargin: '50px' // Start loading 50px before visible
      }
    );
  }

  observe(element: Element): void {
    if (!this.loadedElements.has(element)) {
      this.observer.observe(element);
    }
  }

  private handleIntersection(entries: IntersectionObserverEntry[]): void {
    entries.forEach(entry => {
      if (entry.isIntersecting && !this.loadedElements.has(entry.target)) {
        this.loadElement(entry.target);
        this.observer.unobserve(entry.target);
        this.loadedElements.add(entry.target);
      }
    });
  }

  private loadElement(element: Element): void {
    if (element.tagName === 'IMG') {
      const img = element as HTMLImageElement;
      const src = img.dataset.src;
      if (src) {
        // Preload image
        const tempImg = new Image();
        tempImg.onload = () => {
          img.src = src;
          img.classList.add('loaded');
        };
        tempImg.src = src;
      }
    } else if (element.hasAttribute('data-component')) {
      this.loadComponent(element);
    }
  }

  private async loadComponent(element: Element): Promise<void> {
    const componentName = element.getAttribute('data-component');
    const props = JSON.parse(element.getAttribute('data-props') || '{}');
    
    const module = await import(`./components/${componentName}`);
    const Component = module.default;
    
    // React example
    ReactDOM.render(<Component {...props} />, element);
  }
}

// Priority-based resource loading
class ResourceLoader {
  private queues = {
    critical: [] as Resource[],
    high: [] as Resource[],
    normal: [] as Resource[],
    low: [] as Resource[]
  };

  async loadResources(): Promise<void> {
    // Load critical resources first
    await Promise.all(this.queues.critical.map(r => this.load(r)));
    
    // Load high priority in parallel with normal
    await Promise.all([
      ...this.queues.high.map(r => this.load(r)),
      ...this.queues.normal.map(r => this.load(r))
    ]);
    
    // Load low priority resources in idle time
    if ('requestIdleCallback' in window) {
      requestIdleCallback(() => {
        this.queues.low.forEach(r => this.load(r));
      });
    } else {
      setTimeout(() => {
        this.queues.low.forEach(r => this.load(r));
      }, 1000);
    }
  }

  private async load(resource: Resource): Promise<void> {
    if (resource.type === 'script') {
      return this.loadScript(resource.url);
    } else if (resource.type === 'style') {
      return this.loadStyle(resource.url);
    }
  }
}
```

### Memoization and Caching

```typescript
// React component memoization
const ExpensiveComponent = React.memo(({ data, filter }) => {
  const processedData = useMemo(() => {
    return data
      .filter(item => item.category === filter)
      .map(item => ({
        ...item,
        computed: heavyComputation(item)
      }));
  }, [data, filter]);

  const handleClick = useCallback((id: string) => {
    console.log('Clicked:', id);
  }, []);

  return (
    <div>
      {processedData.map(item => (
        <Item key={item.id} {...item} onClick={handleClick} />
      ))}
    </div>
  );
}, (prevProps, nextProps) => {
  // Custom comparison for deeper optimization
  return prevProps.data === nextProps.data && 
         prevProps.filter === nextProps.filter;
});

// Generic memoization decorator
function memoize<T extends (...args: any[]) => any>(
  fn: T,
  options: MemoizeOptions = {}
): T {
  const cache = new Map<string, { value: any; timestamp: number }>();
  const maxAge = options.maxAge || Infinity;
  const maxSize = options.maxSize || Infinity;

  return ((...args: Parameters<T>) => {
    const key = options.keyFn ? options.keyFn(...args) : JSON.stringify(args);
    const cached = cache.get(key);

    if (cached) {
      const age = Date.now() - cached.timestamp;
      if (age < maxAge) {
        return cached.value;
      }
      cache.delete(key);
    }

    const result = fn(...args);
    
    // Implement LRU if cache is full
    if (cache.size >= maxSize) {
      const oldestKey = Array.from(cache.entries())
        .sort(([, a], [, b]) => a.timestamp - b.timestamp)[0][0];
      cache.delete(oldestKey);
    }

    cache.set(key, { value: result, timestamp: Date.now() });
    return result;
  }) as T;
}

// Computed property caching
class ComputedCache {
  private cache = new WeakMap<object, Map<string, any>>();
  
  compute<T>(
    target: object,
    key: string,
    computation: () => T,
    dependencies?: any[]
  ): T {
    let targetCache = this.cache.get(target);
    if (!targetCache) {
      targetCache = new Map();
      this.cache.set(target, targetCache);
    }

    const cacheKey = dependencies 
      ? `${key}:${JSON.stringify(dependencies)}`
      : key;

    if (targetCache.has(cacheKey)) {
      return targetCache.get(cacheKey);
    }

    const result = computation();
    targetCache.set(cacheKey, result);
    return result;
  }

  invalidate(target: object, key?: string): void {
    if (key) {
      const targetCache = this.cache.get(target);
      if (targetCache) {
        // Remove all entries that start with the key
        for (const [k] of targetCache) {
          if (k.startsWith(key)) {
            targetCache.delete(k);
          }
        }
      }
    } else {
      this.cache.delete(target);
    }
  }
}
```

### Virtual Scrolling

```typescript
// Virtual list implementation
class VirtualList<T> {
  private container: HTMLElement;
  private itemHeight: number;
  private items: T[] = [];
  private visibleRange = { start: 0, end: 0 };
  private scrollTop = 0;

  constructor(
    container: HTMLElement,
    options: VirtualListOptions<T>
  ) {
    this.container = container;
    this.itemHeight = options.itemHeight;
    this.setupScrollListener();
  }

  setItems(items: T[]): void {
    this.items = items;
    this.updateVirtualList();
  }

  private setupScrollListener(): void {
    this.container.addEventListener('scroll', 
      this.throttle(() => {
        this.scrollTop = this.container.scrollTop;
        this.updateVirtualList();
      }, 16) // 60fps
    );
  }

  private updateVirtualList(): void {
    const containerHeight = this.container.clientHeight;
    const totalHeight = this.items.length * this.itemHeight;

    // Calculate visible range
    const scrollTop = this.scrollTop;
    const start = Math.floor(scrollTop / this.itemHeight);
    const end = Math.ceil((scrollTop + containerHeight) / this.itemHeight);

    // Add buffer for smooth scrolling
    const buffer = 5;
    this.visibleRange = {
      start: Math.max(0, start - buffer),
      end: Math.min(this.items.length, end + buffer)
    };

    this.render();
  }

  private render(): void {
    const { start, end } = this.visibleRange;
    const visibleItems = this.items.slice(start, end);

    // Create spacer for items above
    const offsetY = start * this.itemHeight;

    // Update DOM
    this.container.innerHTML = `
      <div style="height: ${start * this.itemHeight}px"></div>
      ${visibleItems.map((item, index) => 
        this.renderItem(item, start + index)
      ).join('')}
      <div style="height: ${(this.items.length - end) * this.itemHeight}px"></div>
    `;
  }

  private throttle(fn: Function, delay: number): (...args: any[]) => void {
    let timeout: NodeJS.Timeout;
    let lastCall = 0;

    return (...args: any[]) => {
      const now = Date.now();
      const remaining = delay - (now - lastCall);

      if (remaining <= 0) {
        fn(...args);
        lastCall = now;
      } else {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
          fn(...args);
          lastCall = Date.now();
        }, remaining);
      }
    };
  }
}
```

## Backend Performance Patterns

### Connection Pooling

```typescript
// Database connection pool
class ConnectionPool {
  private available: Connection[] = [];
  private inUse = new Set<Connection>();
  private waiting: Array<(conn: Connection) => void> = [];
  private creating = 0;

  constructor(private config: PoolConfig) {}

  async getConnection(): Promise<Connection> {
    // Try to get available connection
    const connection = this.available.pop();
    if (connection && await this.isHealthy(connection)) {
      this.inUse.add(connection);
      return connection;
    }

    // Create new connection if under limit
    if (this.canCreateNew()) {
      return this.createConnection();
    }

    // Wait for available connection
    return new Promise((resolve) => {
      this.waiting.push(resolve);
    });
  }

  async releaseConnection(connection: Connection): Promise<void> {
    this.inUse.delete(connection);

    // Give to waiting request or return to pool
    const waiter = this.waiting.shift();
    if (waiter) {
      waiter(connection);
    } else if (await this.isHealthy(connection)) {
      this.available.push(connection);
    } else {
      await this.destroyConnection(connection);
    }
  }

  private canCreateNew(): boolean {
    const total = this.available.length + this.inUse.size + this.creating;
    return total < this.config.maxSize;
  }

  private async createConnection(): Promise<Connection> {
    this.creating++;
    try {
      const connection = await this.config.factory();
      
      // Set up connection lifecycle
      connection.on('error', () => this.handleConnectionError(connection));
      connection.on('timeout', () => this.handleConnectionTimeout(connection));
      
      this.inUse.add(connection);
      return connection;
    } finally {
      this.creating--;
    }
  }

  private async isHealthy(connection: Connection): Promise<boolean> {
    try {
      await connection.ping();
      return true;
    } catch {
      return false;
    }
  }

  async drain(): Promise<void> {
    // Stop accepting new connections
    this.waiting.forEach(waiter => waiter(null));
    this.waiting = [];

    // Close all connections
    const allConnections = [...this.available, ...this.inUse];
    await Promise.all(
      allConnections.map(conn => this.destroyConnection(conn))
    );
  }
}

// HTTP connection pooling with keep-alive
class HttpConnectionPool {
  private agents = new Map<string, http.Agent>();

  getAgent(url: string): http.Agent {
    const { protocol, hostname } = new URL(url);
    const key = `${protocol}//${hostname}`;

    if (!this.agents.has(key)) {
      const agent = new http.Agent({
        keepAlive: true,
        keepAliveMsecs: 1000,
        maxSockets: 50,
        maxFreeSockets: 10,
        timeout: 60000,
        freeSocketTimeout: 30000,
        scheduling: 'lifo' // Last-in-first-out for better connection reuse
      });

      this.agents.set(key, agent);
    }

    return this.agents.get(key)!;
  }

  async request(url: string, options: RequestOptions = {}): Promise<Response> {
    const agent = this.getAgent(url);
    
    return fetch(url, {
      ...options,
      agent,
      // Add compression
      headers: {
        ...options.headers,
        'Accept-Encoding': 'gzip, deflate, br'
      }
    });
  }

  destroy(): void {
    this.agents.forEach(agent => agent.destroy());
    this.agents.clear();
  }
}
```

### Query Optimization

```typescript
// Query optimization strategies
class QueryOptimizer {
  // Batch similar queries
  async batchQueries<T>(
    queries: Array<() => Promise<T>>
  ): Promise<T[]> {
    // Group by query signature
    const groups = this.groupQueries(queries);
    
    // Execute each group
    const results = await Promise.all(
      groups.map(group => this.executeBatch(group))
    );

    // Flatten and return in original order
    return this.restoreOrder(results, queries);
  }

  // N+1 query prevention
  async withIncludes<T>(
    baseQuery: string,
    includes: string[]
  ): Promise<T[]> {
    // Build optimized query with joins
    const optimizedQuery = this.buildJoinQuery(baseQuery, includes);
    
    // Execute single query instead of N+1
    const results = await this.db.query(optimizedQuery);
    
    // Transform flat results to nested structure
    return this.nestResults(results, includes);
  }

  // Query result caching
  private queryCache = new LRUCache<string, any>({
    max: 1000,
    ttl: 1000 * 60 * 5, // 5 minutes
    updateAgeOnGet: true
  });

  async cachedQuery<T>(
    query: string,
    params: any[],
    options: CacheOptions = {}
  ): Promise<T> {
    const key = this.getCacheKey(query, params);
    
    // Check cache
    const cached = this.queryCache.get(key);
    if (cached && !options.refresh) {
      return cached;
    }

    // Execute query
    const result = await this.db.query(query, params);
    
    // Cache result
    if (options.cache !== false) {
      this.queryCache.set(key, result);
    }

    return result;
  }

  // Prepared statement optimization
  private preparedStatements = new Map<string, PreparedStatement>();

  async preparedQuery<T>(
    query: string,
    params: any[]
  ): Promise<T> {
    let statement = this.preparedStatements.get(query);
    
    if (!statement) {
      statement = await this.db.prepare(query);
      this.preparedStatements.set(query, statement);
    }

    return statement.execute(params);
  }

  // Index usage analysis
  async analyzeQuery(query: string): Promise<QueryAnalysis> {
    const explainResult = await this.db.query(`EXPLAIN ${query}`);
    
    return {
      usesIndex: this.checkIndexUsage(explainResult),
      estimatedRows: this.getEstimatedRows(explainResult),
      suggestions: this.generateOptimizationSuggestions(explainResult)
    };
  }
}

// Query builder with optimization
class OptimizedQueryBuilder {
  private query: QueryParts = {
    select: [],
    from: '',
    joins: [],
    where: [],
    groupBy: [],
    having: [],
    orderBy: [],
    limit: null,
    offset: null
  };

  select(...columns: string[]): this {
    // Avoid SELECT * for better performance
    if (columns.length === 0) {
      console.warn('Avoid SELECT *, specify columns explicitly');
    }
    this.query.select.push(...columns);
    return this;
  }

  whereIndex(column: string, value: any): this {
    // Ensure indexed columns are used in WHERE
    if (!this.isIndexed(column)) {
      console.warn(`Column ${column} is not indexed, query may be slow`);
    }
    this.query.where.push({ column, value, useIndex: true });
    return this;
  }

  optimizeJoins(): this {
    // Reorder joins for optimal execution
    this.query.joins = this.query.joins.sort((a, b) => {
      // Smaller tables first
      return this.getTableSize(a.table) - this.getTableSize(b.table);
    });
    return this;
  }

  build(): string {
    this.optimizeJoins();
    
    // Build optimized query
    const parts = [
      `SELECT ${this.query.select.join(', ')}`,
      `FROM ${this.query.from}`,
      ...this.query.joins.map(j => `${j.type} JOIN ${j.table} ON ${j.condition}`),
      this.query.where.length ? `WHERE ${this.buildWhere()}` : '',
      this.query.groupBy.length ? `GROUP BY ${this.query.groupBy.join(', ')}` : '',
      this.query.having.length ? `HAVING ${this.query.having.join(' AND ')}` : '',
      this.query.orderBy.length ? `ORDER BY ${this.query.orderBy.join(', ')}` : '',
      this.query.limit ? `LIMIT ${this.query.limit}` : '',
      this.query.offset ? `OFFSET ${this.query.offset}` : ''
    ];

    return parts.filter(Boolean).join(' ');
  }
}
```

### Caching Strategies

```typescript
// Multi-layer caching system
class CacheManager {
  private layers: CacheLayer[] = [];

  constructor() {
    // L1: In-memory cache (fastest, smallest)
    this.layers.push(new MemoryCacheLayer({
      maxSize: 100 * 1024 * 1024, // 100MB
      ttl: 60 * 1000 // 1 minute
    }));

    // L2: Redis cache (fast, medium)
    this.layers.push(new RedisCacheLayer({
      ttl: 60 * 60 * 1000 // 1 hour
    }));

    // L3: CDN cache (slower, largest)
    this.layers.push(new CDNCacheLayer({
      ttl: 24 * 60 * 60 * 1000 // 24 hours
    }));
  }

  async get<T>(key: string): Promise<T | null> {
    for (let i = 0; i < this.layers.length; i++) {
      const value = await this.layers[i].get(key);
      
      if (value !== null) {
        // Populate higher layers
        await this.populateHigherLayers(key, value, i);
        return value;
      }
    }

    return null;
  }

  async set<T>(
    key: string, 
    value: T,
    options: CacheOptions = {}
  ): Promise<void> {
    // Set in all applicable layers
    await Promise.all(
      this.layers.map(layer => {
        if (this.shouldCacheInLayer(layer, options)) {
          return layer.set(key, value, options);
        }
      })
    );
  }

  private async populateHigherLayers<T>(
    key: string,
    value: T,
    foundAt: number
  ): Promise<void> {
    // Populate caches above where we found the value
    const promises = [];
    for (let i = 0; i < foundAt; i++) {
      promises.push(this.layers[i].set(key, value));
    }
    await Promise.all(promises);
  }

  // Cache warming
  async warm(keys: string[]): Promise<void> {
    const chunks = this.chunkArray(keys, 100);
    
    for (const chunk of chunks) {
      await Promise.all(
        chunk.map(key => this.warmKey(key))
      );
    }
  }

  private async warmKey(key: string): Promise<void> {
    const value = await this.computeValue(key);
    if (value !== null) {
      await this.set(key, value, { warm: true });
    }
  }

  // Cache invalidation patterns
  async invalidate(pattern: string): Promise<void> {
    await Promise.all(
      this.layers.map(layer => layer.invalidate(pattern))
    );
  }

  async invalidateTag(tag: string): Promise<void> {
    await Promise.all(
      this.layers.map(layer => layer.invalidateTag(tag))
    );
  }
}

// Smart cache key generation
class CacheKeyGenerator {
  generateKey(
    namespace: string,
    params: Record<string, any>,
    version: string = '1'
  ): string {
    // Sort params for consistent keys
    const sortedParams = Object.keys(params)
      .sort()
      .reduce((acc, key) => {
        acc[key] = params[key];
        return acc;
      }, {} as Record<string, any>);

    // Create hash for long keys
    const paramString = JSON.stringify(sortedParams);
    const hash = crypto
      .createHash('sha256')
      .update(paramString)
      .digest('hex')
      .substring(0, 16);

    return `${namespace}:${version}:${hash}`;
  }

  generateTaggedKey(
    key: string,
    tags: string[]
  ): TaggedCacheKey {
    return {
      key,
      tags: tags.map(tag => `tag:${tag}`),
      metadata: {
        created: Date.now(),
        hits: 0
      }
    };
  }
}
```

### Database Optimization

```typescript
// Database query optimization
class DatabaseOptimizer {
  // Automatic index creation based on query patterns
  async analyzeAndOptimize(): Promise<OptimizationReport> {
    const slowQueries = await this.getSlowQueries();
    const queryPatterns = this.analyzeQueryPatterns(slowQueries);
    
    const recommendations: IndexRecommendation[] = [];

    for (const pattern of queryPatterns) {
      if (pattern.frequency > 100 && pattern.avgDuration > 1000) {
        const index = this.recommendIndex(pattern);
        if (index) {
          recommendations.push(index);
        }
      }
    }

    // Apply high-impact indexes
    const applied = await this.applyIndexes(
      recommendations.filter(r => r.impact === 'high')
    );

    return {
      analyzed: slowQueries.length,
      recommendations,
      applied
    };
  }

  // Query plan caching
  private planCache = new Map<string, QueryPlan>();

  async executeWithPlanCache(query: string, params: any[]): Promise<any> {
    const planKey = this.getPlanKey(query);
    let plan = this.planCache.get(planKey);

    if (!plan || this.isPlanStale(plan)) {
      plan = await this.generateQueryPlan(query);
      this.planCache.set(planKey, plan);
    }

    return this.executePlan(plan, params);
  }

  // Partition management
  async optimizePartitions(table: string): Promise<void> {
    const tableStats = await this.getTableStatistics(table);
    
    if (tableStats.rowCount > 1_000_000) {
      // Recommend partitioning strategy
      const strategy = this.determinePartitionStrategy(tableStats);
      
      if (strategy.type === 'range') {
        await this.createRangePartitions(table, strategy);
      } else if (strategy.type === 'hash') {
        await this.createHashPartitions(table, strategy);
      }
    }
  }

  // Vacuum and analyze automation
  async performMaintenance(): Promise<void> {
    const tables = await this.getTables();
    
    for (const table of tables) {
      const stats = await this.getTableStatistics(table);
      
      // Vacuum if needed
      if (stats.deadTuples / stats.rowCount > 0.1) {
        await this.vacuum(table);
      }
      
      // Analyze if statistics are stale
      if (Date.now() - stats.lastAnalyze > 24 * 60 * 60 * 1000) {
        await this.analyze(table);
      }
    }
  }
}
```

## Scaling Patterns

### Horizontal Scaling

```typescript
// Load balancer with health checks
class LoadBalancer {
  private servers: Server[] = [];
  private algorithm: LoadBalancingAlgorithm;
  private healthChecker: HealthChecker;

  constructor(config: LoadBalancerConfig) {
    this.algorithm = this.createAlgorithm(config.algorithm);
    this.healthChecker = new HealthChecker(config.healthCheck);
    this.startHealthChecks();
  }

  async route(request: Request): Promise<Response> {
    const healthyServers = this.getHealthyServers();
    
    if (healthyServers.length === 0) {
      throw new Error('No healthy servers available');
    }

    const server = this.algorithm.selectServer(healthyServers, request);
    
    try {
      const response = await this.forwardRequest(server, request);
      this.recordSuccess(server);
      return response;
    } catch (error) {
      this.recordFailure(server);
      
      // Retry with different server
      return this.retryWithDifferentServer(request, server);
    }
  }

  private createAlgorithm(type: string): LoadBalancingAlgorithm {
    switch (type) {
      case 'round-robin':
        return new RoundRobinAlgorithm();
      case 'least-connections':
        return new LeastConnectionsAlgorithm();
      case 'weighted':
        return new WeightedAlgorithm();
      case 'ip-hash':
        return new IPHashAlgorithm();
      default:
        return new RoundRobinAlgorithm();
    }
  }

  private startHealthChecks(): void {
    setInterval(async () => {
      await Promise.all(
        this.servers.map(server => this.checkHealth(server))
      );
    }, this.healthChecker.interval);
  }

  private async checkHealth(server: Server): Promise<void> {
    const isHealthy = await this.healthChecker.check(server);
    server.healthy = isHealthy;
    
    if (!isHealthy) {
      console.error(`Server ${server.id} failed health check`);
      this.notifyOps(server);
    }
  }
}

// Auto-scaling manager
class AutoScaler {
  private metrics: MetricsCollector;
  private scaler: IScaler;

  constructor(config: AutoScalerConfig) {
    this.metrics = new MetricsCollector(config.metrics);
    this.scaler = this.createScaler(config.provider);
    this.startMonitoring();
  }

  private startMonitoring(): void {
    setInterval(async () => {
      const metrics = await this.metrics.collect();
      const decision = this.makeScalingDecision(metrics);
      
      if (decision.action !== 'none') {
        await this.executeScaling(decision);
      }
    }, 60000); // Check every minute
  }

  private makeScalingDecision(metrics: Metrics): ScalingDecision {
    // CPU-based scaling
    if (metrics.avgCpu > 80) {
      return { action: 'scale-up', amount: this.calculateScaleUpAmount(metrics) };
    }
    
    if (metrics.avgCpu < 20 && this.getCurrentInstances() > this.config.minInstances) {
      return { action: 'scale-down', amount: 1 };
    }

    // Request-based scaling
    if (metrics.requestsPerSecond > this.config.targetRPS) {
      const needed = Math.ceil(
        metrics.requestsPerSecond / this.config.targetRPS
      );
      return { action: 'scale-up', amount: needed - this.getCurrentInstances() };
    }

    // Response time based scaling
    if (metrics.avgResponseTime > this.config.targetResponseTime) {
      return { action: 'scale-up', amount: 1 };
    }

    return { action: 'none' };
  }

  private async executeScaling(decision: ScalingDecision): Promise<void> {
    if (decision.action === 'scale-up') {
      await this.scaler.addInstances(decision.amount);
    } else if (decision.action === 'scale-down') {
      await this.scaler.removeInstances(decision.amount);
    }

    // Log scaling event
    await this.logScalingEvent(decision);
  }
}
```

### Performance Monitoring

```typescript
// Application Performance Monitoring (APM)
class PerformanceMonitor {
  private metrics = new Map<string, Metric>();
  private traces = new Map<string, Trace>();

  // Request tracing
  traceRequest(req: Request, res: Response, next: NextFunction): void {
    const traceId = generateTraceId();
    const startTime = process.hrtime.bigint();

    // Attach trace context
    req.traceId = traceId;
    
    // Override res.end to capture completion
    const originalEnd = res.end;
    res.end = (...args: any[]): Response => {
      const duration = Number(process.hrtime.bigint() - startTime) / 1e6;
      
      this.recordRequestMetrics({
        traceId,
        method: req.method,
        path: req.path,
        statusCode: res.statusCode,
        duration,
        timestamp: Date.now()
      });

      return originalEnd.apply(res, args);
    };

    next();
  }

  // Database query monitoring
  monitorQuery(query: string, duration: number): void {
    const querySignature = this.getQuerySignature(query);
    
    let metric = this.metrics.get(querySignature);
    if (!metric) {
      metric = {
        count: 0,
        totalDuration: 0,
        minDuration: Infinity,
        maxDuration: 0,
        avgDuration: 0
      };
      this.metrics.set(querySignature, metric);
    }

    metric.count++;
    metric.totalDuration += duration;
    metric.minDuration = Math.min(metric.minDuration, duration);
    metric.maxDuration = Math.max(metric.maxDuration, duration);
    metric.avgDuration = metric.totalDuration / metric.count;

    // Alert on slow queries
    if (duration > 1000) {
      this.alertSlowQuery(query, duration);
    }
  }

  // Memory monitoring
  startMemoryMonitoring(): void {
    setInterval(() => {
      const usage = process.memoryUsage();
      
      this.recordMetric('memory.heapUsed', usage.heapUsed);
      this.recordMetric('memory.heapTotal', usage.heapTotal);
      this.recordMetric('memory.rss', usage.rss);
      this.recordMetric('memory.external', usage.external);

      // Check for memory leaks
      if (usage.heapUsed / usage.heapTotal > 0.9) {
        this.alertHighMemoryUsage(usage);
      }
    }, 30000); // Every 30 seconds
  }

  // Custom metrics
  recordMetric(name: string, value: number, tags?: Record<string, string>): void {
    const key = this.getMetricKey(name, tags);
    
    let metric = this.metrics.get(key);
    if (!metric) {
      metric = {
        name,
        tags,
        values: [],
        percentiles: {}
      };
      this.metrics.set(key, metric);
    }

    metric.values.push({ value, timestamp: Date.now() });
    
    // Keep only recent values (last hour)
    const cutoff = Date.now() - 60 * 60 * 1000;
    metric.values = metric.values.filter(v => v.timestamp > cutoff);
    
    // Calculate percentiles
    this.calculatePercentiles(metric);
  }

  private calculatePercentiles(metric: Metric): void {
    const values = metric.values.map(v => v.value).sort((a, b) => a - b);
    
    metric.percentiles = {
      p50: this.percentile(values, 50),
      p75: this.percentile(values, 75),
      p90: this.percentile(values, 90),
      p95: this.percentile(values, 95),
      p99: this.percentile(values, 99)
    };
  }

  // Performance budgets
  checkPerformanceBudgets(): BudgetReport {
    const violations: BudgetViolation[] = [];

    // Check response time budgets
    const responseTimeP95 = this.getMetric('response.time').percentiles.p95;
    if (responseTimeP95 > this.config.budgets.responseTime) {
      violations.push({
        metric: 'response.time.p95',
        budget: this.config.budgets.responseTime,
        actual: responseTimeP95,
        severity: 'high'
      });
    }

    // Check error rate budgets
    const errorRate = this.calculateErrorRate();
    if (errorRate > this.config.budgets.errorRate) {
      violations.push({
        metric: 'error.rate',
        budget: this.config.budgets.errorRate,
        actual: errorRate,
        severity: 'critical'
      });
    }

    return { violations, timestamp: Date.now() };
  }
}
```

## Integration with AugmentedClaude Specialists

```typescript
// PerformanceOptimizer Specialist
const performanceOptimizer = {
  analyzeFrontendPerformance: async (metrics: FrontendMetrics) => {
    return {
      issues: [
        {
          type: 'large-bundle',
          impact: 'high',
          details: 'Main bundle is 2.5MB, should be under 500KB',
          solution: 'Implement code splitting and lazy loading'
        },
        {
          type: 'render-blocking-resources',
          impact: 'medium',
          details: '5 render-blocking CSS files detected',
          solution: 'Inline critical CSS and defer non-critical'
        }
      ],
      optimizations: [
        'Enable brotli compression for 40% size reduction',
        'Implement service worker for offline caching',
        'Use resource hints (preconnect, prefetch) for faster loading'
      ],
      expectedImprovement: {
        firstContentfulPaint: '-45%',
        timeToInteractive: '-60%',
        lighthouseScore: '+25 points'
      }
    };
  }
};

// ScalabilityArchitect Specialist
const scalabilityArchitect = {
  designScalingStrategy: async (systemMetrics: SystemMetrics) => {
    return {
      currentBottlenecks: [
        'Database connection pool exhaustion',
        'Single point of failure in API gateway',
        'Memory pressure in cache layer'
      ],
      scalingPlan: {
        immediate: [
          'Increase connection pool size to 200',
          'Deploy redundant API gateway instances',
          'Add Redis cluster for distributed caching'
        ],
        shortTerm: [
          'Implement read replicas for database',
          'Add auto-scaling based on CPU and memory',
          'Deploy CDN for static assets'
        ],
        longTerm: [
          'Migrate to microservices architecture',
          'Implement CQRS for read/write separation',
          'Deploy globally distributed infrastructure'
        ]
      },
      estimatedCapacity: {
        current: '10K requests/second',
        afterOptimization: '100K requests/second'
      }
    };
  }
};
```

## Best Practices

1. **Measure First**: Always profile before optimizing
2. **Set Budgets**: Define performance budgets and monitor them
3. **Progressive Enhancement**: Start with a fast base experience
4. **Cache Wisely**: Use appropriate cache strategies for different data
5. **Monitor Continuously**: Track performance metrics in production

## Common Pitfalls

1. **Premature Optimization**: Optimizing without measurement
2. **Over-caching**: Caching data that changes frequently
3. **Ignoring Mobile**: Not testing on real mobile devices
4. **Memory Leaks**: Not properly cleaning up resources
5. **Blocking Operations**: Performing synchronous I/O on main thread

## Performance Testing

```typescript
// Performance test framework
class PerformanceTest {
  async runLoadTest(config: LoadTestConfig): Promise<LoadTestResult> {
    const results: RequestResult[] = [];
    const startTime = Date.now();

    // Ramp up users
    for (let users = 1; users <= config.maxUsers; users *= 2) {
      const userResults = await this.simulateUsers(users, config);
      results.push(...userResults);

      // Check if system is degrading
      const p95 = this.calculatePercentile(userResults, 95);
      if (p95 > config.maxResponseTime) {
        break;
      }
    }

    return {
      duration: Date.now() - startTime,
      totalRequests: results.length,
      successRate: this.calculateSuccessRate(results),
      responseTimePercentiles: {
        p50: this.calculatePercentile(results, 50),
        p95: this.calculatePercentile(results, 95),
        p99: this.calculatePercentile(results, 99)
      },
      throughput: results.length / ((Date.now() - startTime) / 1000),
      errors: this.analyzeErrors(results)
    };
  }
}
```

## Conclusion

Performance patterns are essential for building fast, scalable applications. By applying these patterns appropriately and continuously monitoring performance, teams can deliver exceptional user experiences while maintaining system efficiency and reliability.