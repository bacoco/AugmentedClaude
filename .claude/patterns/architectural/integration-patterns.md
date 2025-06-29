# Integration Patterns

## Overview

Integration patterns provide proven solutions for connecting distributed systems, services, and applications. These patterns ensure reliable communication, data consistency, and loose coupling between components while maintaining system resilience and scalability.

## API Gateway Pattern

The API Gateway acts as a single entry point for all client requests, providing routing, composition, and protocol translation.

### Implementation

```typescript
// API Gateway Core
class ApiGateway {
  private services: Map<string, ServiceConfig> = new Map();
  private rateLimiter: RateLimiter;
  private authService: AuthenticationService;
  private circuitBreaker: CircuitBreaker;

  constructor(config: GatewayConfig) {
    this.rateLimiter = new RateLimiter(config.rateLimit);
    this.authService = new AuthenticationService(config.auth);
    this.circuitBreaker = new CircuitBreaker(config.circuitBreaker);
  }

  async handleRequest(req: Request): Promise<Response> {
    try {
      // Rate limiting
      await this.rateLimiter.checkLimit(req.clientId);

      // Authentication
      const authContext = await this.authService.authenticate(req);

      // Request routing
      const service = this.resolveService(req.path);
      if (!service) {
        return new Response(404, { error: 'Service not found' });
      }

      // Circuit breaker protection
      return await this.circuitBreaker.execute(
        service.name,
        async () => {
          // Request transformation
          const transformedReq = this.transformRequest(req, service);

          // Service call
          const response = await this.callService(service, transformedReq);

          // Response transformation
          return this.transformResponse(response, service);
        }
      );
    } catch (error) {
      return this.handleError(error);
    }
  }

  private async callService(
    service: ServiceConfig,
    request: TransformedRequest
  ): Promise<ServiceResponse> {
    // Add correlation ID for tracing
    request.headers['X-Correlation-ID'] = generateCorrelationId();

    // Add timeout
    const timeoutPromise = new Promise((_, reject) =>
      setTimeout(() => reject(new Error('Service timeout')), service.timeout)
    );

    return Promise.race([
      httpClient.request(service.url, request),
      timeoutPromise
    ]) as Promise<ServiceResponse>;
  }

  // Request aggregation for mobile/web clients
  async handleAggregatedRequest(req: AggregatedRequest): Promise<AggregatedResponse> {
    const requests = req.operations.map(op => ({
      service: this.resolveService(op.path),
      operation: op
    }));

    // Parallel execution where possible
    const results = await Promise.allSettled(
      requests.map(r => this.executeOperation(r))
    );

    return {
      results: results.map((result, index) => ({
        operation: req.operations[index].id,
        status: result.status,
        data: result.status === 'fulfilled' ? result.value : null,
        error: result.status === 'rejected' ? result.reason : null
      }))
    };
  }
}

// Service Discovery Integration
class ServiceRegistry {
  private services: Map<string, ServiceInstance[]> = new Map();
  private healthChecker: HealthChecker;

  async register(service: ServiceInstance): Promise<void> {
    const instances = this.services.get(service.name) || [];
    instances.push(service);
    this.services.set(service.name, instances);

    // Start health monitoring
    this.healthChecker.monitor(service);
  }

  async discover(serviceName: string): Promise<ServiceInstance[]> {
    const instances = this.services.get(serviceName) || [];
    return instances.filter(instance => instance.healthy);
  }

  // Load balancing
  async getHealthyInstance(serviceName: string): Promise<ServiceInstance> {
    const instances = await this.discover(serviceName);
    if (instances.length === 0) {
      throw new Error(`No healthy instances for service: ${serviceName}`);
    }

    // Round-robin selection
    const index = Math.floor(Math.random() * instances.length);
    return instances[index];
  }
}
```

## Backend for Frontend (BFF) Pattern

Create specialized backends for different frontend applications.

```typescript
// Mobile BFF
class MobileBFF {
  constructor(
    private userService: UserService,
    private productService: ProductService,
    private orderService: OrderService
  ) {}

  // Optimized for mobile data usage
  async getMobileHomepage(userId: string): Promise<MobileHomepageData> {
    // Parallel data fetching
    const [user, recommendations, activeOrders] = await Promise.all([
      this.userService.getBasicProfile(userId),
      this.productService.getRecommendations(userId, { limit: 10 }),
      this.orderService.getActiveOrders(userId, { limit: 3 })
    ]);

    // Transform and minimize data for mobile
    return {
      user: {
        name: user.name,
        avatar: this.getOptimizedImageUrl(user.avatar, 'small')
      },
      recommendations: recommendations.map(p => ({
        id: p.id,
        name: p.name,
        price: p.price,
        image: this.getOptimizedImageUrl(p.image, 'mobile')
      })),
      activeOrders: activeOrders.map(o => ({
        id: o.id,
        status: o.status,
        estimatedDelivery: o.estimatedDelivery
      }))
    };
  }

  private getOptimizedImageUrl(url: string, size: string): string {
    // Return CDN URL with appropriate size/format for mobile
    return `${CDN_URL}/optimize?url=${url}&size=${size}&format=webp`;
  }
}

// Web BFF
class WebBFF {
  // Rich data for web application
  async getWebDashboard(userId: string): Promise<WebDashboardData> {
    const [
      profile,
      orders,
      recommendations,
      analytics,
      notifications
    ] = await Promise.all([
      this.userService.getFullProfile(userId),
      this.orderService.getOrderHistory(userId, { limit: 20 }),
      this.productService.getPersonalizedRecommendations(userId),
      this.analyticsService.getUserAnalytics(userId),
      this.notificationService.getUnread(userId)
    ]);

    return {
      profile,
      orders: this.enrichOrderData(orders),
      recommendations: this.enrichProductData(recommendations),
      analytics,
      notifications
    };
  }
}
```

## Message-Based Integration Patterns

### Publish-Subscribe Pattern

```typescript
// Event Bus Implementation
class EventBus {
  private subscribers: Map<string, Set<EventHandler>> = new Map();
  private messageQueue: IMessageQueue;

  constructor(queueConfig: QueueConfig) {
    this.messageQueue = new MessageQueue(queueConfig);
  }

  subscribe(eventType: string, handler: EventHandler): Subscription {
    const handlers = this.subscribers.get(eventType) || new Set();
    handlers.add(handler);
    this.subscribers.set(eventType, handlers);

    return {
      unsubscribe: () => {
        handlers.delete(handler);
      }
    };
  }

  async publish(event: DomainEvent): Promise<void> {
    // Store event for reliability
    await this.messageQueue.send(event.type, event);

    // Notify local subscribers
    const handlers = this.subscribers.get(event.type) || new Set();
    
    // Execute handlers in parallel
    await Promise.allSettled(
      Array.from(handlers).map(handler => 
        this.executeHandler(handler, event)
      )
    );
  }

  private async executeHandler(handler: EventHandler, event: DomainEvent): Promise<void> {
    try {
      await handler(event);
    } catch (error) {
      // Log error and potentially retry
      console.error(`Handler failed for event ${event.type}:`, error);
      await this.scheduleRetry(handler, event);
    }
  }
}

// Domain Event Publishers
class OrderService {
  constructor(private eventBus: EventBus) {}

  async createOrder(orderData: CreateOrderDto): Promise<Order> {
    const order = await this.processOrder(orderData);

    // Publish events for other services
    await this.eventBus.publish(new OrderCreatedEvent(order));

    return order;
  }

  async updateOrderStatus(orderId: string, status: OrderStatus): Promise<void> {
    await this.updateStatus(orderId, status);

    // Different events for different status changes
    switch (status) {
      case OrderStatus.CONFIRMED:
        await this.eventBus.publish(new OrderConfirmedEvent(orderId));
        break;
      case OrderStatus.SHIPPED:
        await this.eventBus.publish(new OrderShippedEvent(orderId));
        break;
      case OrderStatus.DELIVERED:
        await this.eventBus.publish(new OrderDeliveredEvent(orderId));
        break;
    }
  }
}

// Event Subscribers
class InventoryService {
  constructor(private eventBus: EventBus) {
    this.subscribeToEvents();
  }

  private subscribeToEvents(): void {
    this.eventBus.subscribe('OrderCreated', async (event: OrderCreatedEvent) => {
      await this.reserveInventory(event.order.items);
    });

    this.eventBus.subscribe('OrderCancelled', async (event: OrderCancelledEvent) => {
      await this.releaseInventory(event.orderId);
    });
  }
}
```

### Request-Reply Pattern

```typescript
// Request-Reply Implementation
class RequestReplyBus {
  private pendingRequests: Map<string, PendingRequest> = new Map();
  private requestQueue: IMessageQueue;
  private replyQueue: IMessageQueue;

  async request<TRequest, TReply>(
    service: string,
    request: TRequest,
    timeout: number = 30000
  ): Promise<TReply> {
    const correlationId = generateUUID();
    
    // Create promise for reply
    const replyPromise = new Promise<TReply>((resolve, reject) => {
      this.pendingRequests.set(correlationId, {
        resolve,
        reject,
        timestamp: Date.now()
      });

      // Timeout handling
      setTimeout(() => {
        if (this.pendingRequests.has(correlationId)) {
          this.pendingRequests.delete(correlationId);
          reject(new Error('Request timeout'));
        }
      }, timeout);
    });

    // Send request
    await this.requestQueue.send(service, {
      correlationId,
      replyTo: this.replyQueue.name,
      payload: request
    });

    return replyPromise;
  }

  // Process replies
  private async processReplies(): Promise<void> {
    await this.replyQueue.subscribe(async (message) => {
      const { correlationId, payload, error } = message;
      
      const pendingRequest = this.pendingRequests.get(correlationId);
      if (pendingRequest) {
        this.pendingRequests.delete(correlationId);
        
        if (error) {
          pendingRequest.reject(new Error(error));
        } else {
          pendingRequest.resolve(payload);
        }
      }
    });
  }
}

// Service implementation
class PricingService {
  constructor(private requestReplyBus: RequestReplyBus) {
    this.listenForRequests();
  }

  private async listenForRequests(): Promise<void> {
    await this.requestQueue.subscribe(async (message) => {
      const { correlationId, replyTo, payload } = message;
      
      try {
        const result = await this.calculatePrice(payload);
        
        await this.replyQueue.send(replyTo, {
          correlationId,
          payload: result
        });
      } catch (error) {
        await this.replyQueue.send(replyTo, {
          correlationId,
          error: error.message
        });
      }
    });
  }
}
```

### Message Router Pattern

```typescript
// Content-Based Router
class MessageRouter {
  private routes: Route[] = [];

  addRoute(predicate: RoutePredicate, destination: Destination): void {
    this.routes.push({ predicate, destination });
  }

  async route(message: Message): Promise<void> {
    const matchingRoutes = this.routes.filter(route => 
      route.predicate(message)
    );

    if (matchingRoutes.length === 0) {
      // Send to dead letter queue
      await this.deadLetterQueue.send(message);
      return;
    }

    // Route to all matching destinations
    await Promise.all(
      matchingRoutes.map(route => 
        route.destination.send(message)
      )
    );
  }
}

// Dynamic Router with Rules Engine
class DynamicRouter {
  private rulesEngine: RulesEngine;

  async route(message: Message): Promise<void> {
    // Evaluate routing rules
    const routingDecision = await this.rulesEngine.evaluate(message, {
      messageType: message.type,
      priority: message.priority,
      content: message.content,
      metadata: message.metadata
    });

    // Apply transformations if needed
    const transformedMessage = routingDecision.transform
      ? await this.transform(message, routingDecision.transformations)
      : message;

    // Route to destinations
    await Promise.all(
      routingDecision.destinations.map(dest =>
        this.sendToDestination(transformedMessage, dest)
      )
    );
  }
}
```

## ETL Patterns

### Extract-Transform-Load Implementation

```typescript
// ETL Pipeline
class ETLPipeline<TSource, TTarget> {
  constructor(
    private extractor: IExtractor<TSource>,
    private transformer: ITransformer<TSource, TTarget>,
    private loader: ILoader<TTarget>
  ) {}

  async execute(config: ETLConfig): Promise<ETLResult> {
    const startTime = Date.now();
    const errors: ETLError[] = [];
    let processedCount = 0;

    try {
      // Extract phase
      const extractStream = await this.extractor.extract(config.source);

      // Process in batches for efficiency
      const batchProcessor = new BatchProcessor<TSource, TTarget>(
        config.batchSize || 1000
      );

      await batchProcessor.process(
        extractStream,
        async (batch) => {
          try {
            // Transform phase
            const transformedBatch = await Promise.all(
              batch.map(item => this.transformWithErrorHandling(item))
            );

            // Filter out failed transformations
            const validItems = transformedBatch
              .filter(result => result.success)
              .map(result => result.data!);

            // Collect errors
            transformedBatch
              .filter(result => !result.success)
              .forEach(result => errors.push(result.error!));

            // Load phase
            if (validItems.length > 0) {
              await this.loader.load(validItems, config.target);
              processedCount += validItems.length;
            }
          } catch (error) {
            errors.push({
              phase: 'load',
              error: error.message,
              batch: batch.map(item => item.id)
            });
          }
        }
      );

      return {
        success: errors.length === 0,
        processedCount,
        errorCount: errors.length,
        errors,
        duration: Date.now() - startTime
      };
    } catch (error) {
      return {
        success: false,
        processedCount,
        errorCount: errors.length + 1,
        errors: [...errors, { phase: 'pipeline', error: error.message }],
        duration: Date.now() - startTime
      };
    }
  }

  private async transformWithErrorHandling(
    item: TSource
  ): Promise<TransformResult<TTarget>> {
    try {
      const transformed = await this.transformer.transform(item);
      return { success: true, data: transformed };
    } catch (error) {
      return {
        success: false,
        error: {
          phase: 'transform',
          error: error.message,
          item: item
        }
      };
    }
  }
}

// Incremental ETL with Change Detection
class IncrementalETL {
  private checkpointStore: ICheckpointStore;

  async executeIncremental(config: IncrementalETLConfig): Promise<ETLResult> {
    // Get last checkpoint
    const lastCheckpoint = await this.checkpointStore.get(config.pipelineId);

    // Extract only changed data
    const changedData = await this.extractor.extractChanges(
      config.source,
      lastCheckpoint
    );

    // Process changes
    const result = await this.pipeline.execute({
      ...config,
      source: changedData
    });

    // Update checkpoint if successful
    if (result.success) {
      await this.checkpointStore.update(
        config.pipelineId,
        changedData.newCheckpoint
      );
    }

    return result;
  }
}
```

### Change Data Capture (CDC)

```typescript
// CDC Implementation
class ChangeDataCapture {
  private binlogReader: BinlogReader;
  private changeHandlers: Map<string, ChangeHandler> = new Map();

  async start(config: CDCConfig): Promise<void> {
    // Connect to source database binlog
    await this.binlogReader.connect(config.source);

    // Start processing changes
    this.binlogReader.on('change', async (event: ChangeEvent) => {
      await this.processChange(event);
    });

    // Handle different event types
    this.binlogReader.on('insert', async (event: InsertEvent) => {
      await this.handleInsert(event);
    });

    this.binlogReader.on('update', async (event: UpdateEvent) => {
      await this.handleUpdate(event);
    });

    this.binlogReader.on('delete', async (event: DeleteEvent) => {
      await this.handleDelete(event);
    });
  }

  registerHandler(table: string, handler: ChangeHandler): void {
    this.changeHandlers.set(table, handler);
  }

  private async handleInsert(event: InsertEvent): Promise<void> {
    const handler = this.changeHandlers.get(event.table);
    if (handler) {
      await handler.onInsert(event.data);
    }

    // Publish to event stream
    await this.eventStream.publish({
      type: 'entity.created',
      entity: event.table,
      data: event.data,
      timestamp: event.timestamp
    });
  }

  private async handleUpdate(event: UpdateEvent): Promise<void> {
    const handler = this.changeHandlers.get(event.table);
    if (handler) {
      await handler.onUpdate(event.before, event.after);
    }

    // Publish change event
    await this.eventStream.publish({
      type: 'entity.updated',
      entity: event.table,
      before: event.before,
      after: event.after,
      changedFields: this.getChangedFields(event.before, event.after),
      timestamp: event.timestamp
    });
  }
}

// CDC Consumer for Real-time Analytics
class AnalyticsCDCConsumer {
  async processCDCStream(stream: CDCStream): Promise<void> {
    await stream.subscribe(async (change: CDCEvent) => {
      switch (change.operation) {
        case 'INSERT':
          await this.updateMetrics(change.table, 'create', change.after);
          break;
        case 'UPDATE':
          await this.updateMetrics(change.table, 'update', change.after);
          await this.trackFieldChanges(change.table, change.before, change.after);
          break;
        case 'DELETE':
          await this.updateMetrics(change.table, 'delete', change.before);
          break;
      }

      // Update real-time dashboards
      await this.pushToRealTimeDashboard(change);
    });
  }
}
```

## Service Integration Patterns

### Circuit Breaker Pattern

```typescript
// Circuit Breaker Implementation
class CircuitBreaker {
  private state: CircuitState = CircuitState.CLOSED;
  private failureCount: number = 0;
  private lastFailureTime: number = 0;
  private successCount: number = 0;

  constructor(private config: CircuitBreakerConfig) {}

  async execute<T>(
    operation: () => Promise<T>,
    fallback?: () => Promise<T>
  ): Promise<T> {
    // Check if circuit should be opened
    if (this.state === CircuitState.OPEN) {
      if (this.shouldAttemptReset()) {
        this.state = CircuitState.HALF_OPEN;
      } else {
        if (fallback) {
          return fallback();
        }
        throw new CircuitOpenError('Circuit breaker is open');
      }
    }

    try {
      const result = await operation();
      this.onSuccess();
      return result;
    } catch (error) {
      this.onFailure();
      
      if (this.state === CircuitState.OPEN && fallback) {
        return fallback();
      }
      
      throw error;
    }
  }

  private onSuccess(): void {
    this.failureCount = 0;
    
    if (this.state === CircuitState.HALF_OPEN) {
      this.successCount++;
      if (this.successCount >= this.config.successThreshold) {
        this.state = CircuitState.CLOSED;
        this.successCount = 0;
      }
    }
  }

  private onFailure(): void {
    this.failureCount++;
    this.lastFailureTime = Date.now();
    
    if (this.failureCount >= this.config.failureThreshold) {
      this.state = CircuitState.OPEN;
      this.successCount = 0;
    }
  }

  private shouldAttemptReset(): boolean {
    return Date.now() - this.lastFailureTime >= this.config.timeout;
  }
}

// Usage with service calls
class ResilientServiceClient {
  private circuitBreaker: CircuitBreaker;

  constructor(private httpClient: HttpClient) {
    this.circuitBreaker = new CircuitBreaker({
      failureThreshold: 5,
      successThreshold: 3,
      timeout: 60000 // 1 minute
    });
  }

  async getUser(userId: string): Promise<User> {
    return this.circuitBreaker.execute(
      async () => {
        const response = await this.httpClient.get(`/users/${userId}`);
        return response.data;
      },
      async () => {
        // Fallback: return cached data or default
        return this.getCachedUser(userId) || this.getDefaultUser();
      }
    );
  }
}
```

### Retry Pattern with Exponential Backoff

```typescript
// Retry Policy
class RetryPolicy {
  constructor(
    private maxRetries: number = 3,
    private initialDelay: number = 1000,
    private maxDelay: number = 60000,
    private backoffMultiplier: number = 2
  ) {}

  async execute<T>(
    operation: () => Promise<T>,
    isRetryable: (error: Error) => boolean = () => true
  ): Promise<T> {
    let lastError: Error;
    let delay = this.initialDelay;

    for (let attempt = 0; attempt <= this.maxRetries; attempt++) {
      try {
        return await operation();
      } catch (error) {
        lastError = error;
        
        // Check if error is retryable
        if (!isRetryable(error) || attempt === this.maxRetries) {
          throw error;
        }

        // Wait with exponential backoff
        await this.sleep(delay);
        
        // Calculate next delay with jitter
        delay = Math.min(
          delay * this.backoffMultiplier + Math.random() * 1000,
          this.maxDelay
        );
      }
    }

    throw lastError!;
  }

  private sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}

// Advanced retry with circuit breaker integration
class ResilientClient {
  private retryPolicy: RetryPolicy;
  private circuitBreaker: CircuitBreaker;

  async callService<T>(request: ServiceRequest): Promise<T> {
    return this.circuitBreaker.execute(async () => {
      return this.retryPolicy.execute(
        async () => {
          const response = await this.httpClient.request(request);
          
          // Check for retryable status codes
          if (response.status >= 500) {
            throw new RetryableError(`Server error: ${response.status}`);
          }
          
          return response.data;
        },
        (error) => {
          // Retry on network errors and 5xx responses
          return error instanceof NetworkError || 
                 error instanceof RetryableError;
        }
      );
    });
  }
}
```

### Timeout Pattern

```typescript
// Timeout Wrapper
class TimeoutWrapper {
  static async withTimeout<T>(
    operation: Promise<T>,
    timeout: number,
    errorMessage: string = 'Operation timed out'
  ): Promise<T> {
    const timeoutPromise = new Promise<never>((_, reject) => {
      setTimeout(() => reject(new TimeoutError(errorMessage)), timeout);
    });

    return Promise.race([operation, timeoutPromise]);
  }

  // Cascading timeouts for distributed calls
  static async withCascadingTimeout<T>(
    operations: Array<() => Promise<any>>,
    totalTimeout: number
  ): Promise<T[]> {
    const startTime = Date.now();
    const results: T[] = [];

    for (const operation of operations) {
      const elapsed = Date.now() - startTime;
      const remainingTime = totalTimeout - elapsed;
      
      if (remainingTime <= 0) {
        throw new TimeoutError('Total timeout exceeded');
      }

      const result = await this.withTimeout(
        operation(),
        remainingTime,
        `Operation timed out after ${remainingTime}ms`
      );
      
      results.push(result);
    }

    return results;
  }
}

// Adaptive timeout based on response times
class AdaptiveTimeout {
  private responseTimeHistory: number[] = [];
  private historySize: number = 100;

  calculateTimeout(percentile: number = 99): number {
    if (this.responseTimeHistory.length === 0) {
      return 5000; // Default 5 seconds
    }

    const sorted = [...this.responseTimeHistory].sort((a, b) => a - b);
    const index = Math.ceil((percentile / 100) * sorted.length) - 1;
    
    // Add buffer (e.g., 20%)
    return Math.ceil(sorted[index] * 1.2);
  }

  recordResponseTime(duration: number): void {
    this.responseTimeHistory.push(duration);
    
    // Keep only recent history
    if (this.responseTimeHistory.length > this.historySize) {
      this.responseTimeHistory.shift();
    }
  }
}
```

## Integration with AugmentedClaude Specialists

```typescript
// IntegrationArchitect Specialist
const integrationArchitect = {
  analyzeIntegrationNeeds: async (systemArchitecture: SystemArchitecture) => {
    return {
      recommendedPatterns: [
        {
          pattern: 'API Gateway',
          reason: 'Multiple client types detected (web, mobile, API)',
          benefits: ['Centralized auth', 'Rate limiting', 'Request routing']
        },
        {
          pattern: 'Event-Driven Integration',
          reason: 'Loose coupling requirement between services',
          benefits: ['Async processing', 'Scalability', 'Resilience']
        }
      ],
      integrationMap: {
        frontend: ['API Gateway', 'BFF Pattern'],
        services: ['Pub/Sub', 'Request-Reply'],
        data: ['CDC', 'ETL Pipeline'],
        external: ['Circuit Breaker', 'Retry Pattern']
      }
    };
  }
};

// ReliabilityEngineer Specialist
const reliabilityEngineer = {
  implementResilience: async (service: ServiceConfig) => {
    return {
      patterns: [
        {
          name: 'Circuit Breaker',
          config: {
            failureThreshold: 5,
            timeout: 60000,
            monitoringEndpoint: '/health'
          }
        },
        {
          name: 'Retry Policy',
          config: {
            maxRetries: 3,
            backoffStrategy: 'exponential',
            retryableErrors: ['NetworkError', 'TimeoutError']
          }
        },
        {
          name: 'Timeout',
          config: {
            default: 5000,
            adaptive: true,
            percentile: 99
          }
        }
      ],
      monitoring: {
        metrics: ['success_rate', 'latency', 'error_rate'],
        alerts: ['circuit_open', 'high_retry_rate', 'timeout_exceeded']
      }
    };
  }
};
```

## Best Practices

1. **Design for Failure**: Assume services will fail and plan accordingly
2. **Async When Possible**: Use asynchronous patterns for better scalability
3. **Monitor Everything**: Track metrics for all integration points
4. **Version APIs**: Support multiple API versions for smooth transitions
5. **Document Contracts**: Clearly define service contracts and schemas

## Common Pitfalls

1. **Tight Coupling**: Avoid direct database access between services
2. **Synchronous Chains**: Long chains of synchronous calls create brittleness
3. **Missing Timeouts**: Always set timeouts for external calls
4. **Inadequate Error Handling**: Handle partial failures gracefully
5. **Chatty Interfaces**: Minimize round trips with proper API design

## Conclusion

Integration patterns are essential for building robust distributed systems. By applying these patterns appropriately, teams can create systems that are resilient, scalable, and maintainable while providing reliable communication between components.