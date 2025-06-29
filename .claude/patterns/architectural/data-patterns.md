# Data Patterns

## Overview

Data patterns provide standardized approaches to managing data flow, storage, and consistency in modern applications. These patterns help teams build scalable, maintainable data architectures that integrate seamlessly with AugmentedClaude's specialist system.

## Repository Pattern

The Repository pattern abstracts data access logic and provides a more object-oriented view of the persistence layer.

### Implementation

```typescript
// Base Repository Interface
interface IRepository<T> {
  findById(id: string): Promise<T | null>;
  findAll(): Promise<T[]>;
  save(entity: T): Promise<T>;
  update(id: string, entity: Partial<T>): Promise<T>;
  delete(id: string): Promise<void>;
}

// User Repository Implementation
class UserRepository implements IRepository<User> {
  constructor(private db: Database) {}

  async findById(id: string): Promise<User | null> {
    const result = await this.db.query(
      'SELECT * FROM users WHERE id = ?',
      [id]
    );
    return result[0] ? this.mapToUser(result[0]) : null;
  }

  async findByEmail(email: string): Promise<User | null> {
    const result = await this.db.query(
      'SELECT * FROM users WHERE email = ?',
      [email]
    );
    return result[0] ? this.mapToUser(result[0]) : null;
  }

  async save(user: User): Promise<User> {
    const result = await this.db.query(
      'INSERT INTO users (id, email, name) VALUES (?, ?, ?)',
      [user.id, user.email, user.name]
    );
    return user;
  }

  private mapToUser(row: any): User {
    return new User(row.id, row.email, row.name);
  }
}
```

### Integration with AugmentedClaude

```typescript
// Specialist: DatabaseArchitect
const databaseSpec = {
  analyzeRepositoryDesign: (repository: IRepository<any>) => {
    // Analyze query patterns and suggest optimizations
    return {
      indexSuggestions: ['email', 'created_at'],
      queryOptimizations: ['Use batch operations for bulk updates'],
      cachingOpportunities: ['Frequently accessed users']
    };
  }
};
```

## Unit of Work Pattern

Maintains a list of objects affected by a business transaction and coordinates writing out changes.

### Implementation

```typescript
class UnitOfWork {
  private newObjects: Set<Entity> = new Set();
  private dirtyObjects: Set<Entity> = new Set();
  private removedObjects: Set<Entity> = new Set();

  registerNew(entity: Entity): void {
    this.newObjects.add(entity);
  }

  registerDirty(entity: Entity): void {
    if (!this.newObjects.has(entity)) {
      this.dirtyObjects.add(entity);
    }
  }

  registerRemoved(entity: Entity): void {
    if (this.newObjects.has(entity)) {
      this.newObjects.delete(entity);
    } else {
      this.dirtyObjects.delete(entity);
      this.removedObjects.add(entity);
    }
  }

  async commit(): Promise<void> {
    const transaction = await this.beginTransaction();
    
    try {
      // Insert new objects
      for (const entity of this.newObjects) {
        await this.insert(entity);
      }

      // Update dirty objects
      for (const entity of this.dirtyObjects) {
        await this.update(entity);
      }

      // Delete removed objects
      for (const entity of this.removedObjects) {
        await this.delete(entity);
      }

      await transaction.commit();
      this.clear();
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  }

  private clear(): void {
    this.newObjects.clear();
    this.dirtyObjects.clear();
    this.removedObjects.clear();
  }
}
```

## CQRS (Command Query Responsibility Segregation)

Separates read and write operations into different models.

### Implementation

```typescript
// Command Model
interface ICommand {
  execute(): Promise<void>;
}

class CreateUserCommand implements ICommand {
  constructor(
    private userData: CreateUserDto,
    private userWriteRepository: IUserWriteRepository
  ) {}

  async execute(): Promise<void> {
    const user = new User(
      generateId(),
      this.userData.email,
      this.userData.name
    );
    
    await this.userWriteRepository.save(user);
    
    // Publish event for read model update
    await EventBus.publish(new UserCreatedEvent(user));
  }
}

// Query Model
class UserQueryService {
  constructor(private readDb: ReadDatabase) {}

  async getUserProfile(userId: string): Promise<UserProfileDto> {
    const result = await this.readDb.query(`
      SELECT u.*, 
             COUNT(p.id) as post_count,
             COUNT(f.id) as follower_count
      FROM user_profiles u
      LEFT JOIN posts p ON p.user_id = u.id
      LEFT JOIN followers f ON f.user_id = u.id
      WHERE u.id = ?
      GROUP BY u.id
    `, [userId]);

    return this.mapToUserProfile(result[0]);
  }

  async searchUsers(criteria: SearchCriteria): Promise<UserSummaryDto[]> {
    // Optimized read query using denormalized data
    const results = await this.readDb.search('users_search_view', criteria);
    return results.map(r => this.mapToUserSummary(r));
  }
}

// Event Handler for Read Model Updates
class UserEventHandler {
  async handleUserCreated(event: UserCreatedEvent): Promise<void> {
    // Update denormalized read models
    await this.updateUserProfile(event.user);
    await this.updateSearchIndex(event.user);
  }
}
```

## Event Sourcing Pattern

Stores all changes to application state as a sequence of events.

### Implementation

```typescript
// Event Base Class
abstract class DomainEvent {
  constructor(
    public readonly aggregateId: string,
    public readonly timestamp: Date = new Date(),
    public readonly version: number = 1
  ) {}
}

// Specific Events
class AccountCreatedEvent extends DomainEvent {
  constructor(
    aggregateId: string,
    public readonly initialBalance: number,
    public readonly currency: string
  ) {
    super(aggregateId);
  }
}

class MoneyDepositedEvent extends DomainEvent {
  constructor(
    aggregateId: string,
    public readonly amount: number,
    public readonly source: string
  ) {
    super(aggregateId);
  }
}

// Event Store
class EventStore {
  async saveEvents(events: DomainEvent[]): Promise<void> {
    const transaction = await this.db.beginTransaction();
    
    try {
      for (const event of events) {
        await this.db.query(
          `INSERT INTO events (aggregate_id, event_type, event_data, version, timestamp)
           VALUES (?, ?, ?, ?, ?)`,
          [
            event.aggregateId,
            event.constructor.name,
            JSON.stringify(event),
            event.version,
            event.timestamp
          ]
        );
      }
      
      await transaction.commit();
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  }

  async getEvents(aggregateId: string): Promise<DomainEvent[]> {
    const results = await this.db.query(
      'SELECT * FROM events WHERE aggregate_id = ? ORDER BY version',
      [aggregateId]
    );
    
    return results.map(r => this.deserializeEvent(r));
  }
}

// Aggregate Root with Event Sourcing
class BankAccount {
  private uncommittedEvents: DomainEvent[] = [];
  
  constructor(
    private id: string,
    private balance: number = 0,
    private version: number = 0
  ) {}

  static async load(id: string, eventStore: EventStore): Promise<BankAccount> {
    const events = await eventStore.getEvents(id);
    const account = new BankAccount(id);
    
    for (const event of events) {
      account.apply(event, false);
    }
    
    return account;
  }

  deposit(amount: number, source: string): void {
    if (amount <= 0) {
      throw new Error('Deposit amount must be positive');
    }
    
    const event = new MoneyDepositedEvent(this.id, amount, source);
    this.apply(event, true);
  }

  private apply(event: DomainEvent, isNew: boolean = true): void {
    if (event instanceof AccountCreatedEvent) {
      this.balance = event.initialBalance;
    } else if (event instanceof MoneyDepositedEvent) {
      this.balance += event.amount;
    }
    
    this.version++;
    
    if (isNew) {
      this.uncommittedEvents.push(event);
    }
  }

  getUncommittedEvents(): DomainEvent[] {
    return this.uncommittedEvents;
  }

  markEventsAsCommitted(): void {
    this.uncommittedEvents = [];
  }
}
```

## Caching Patterns

### Cache-Aside Pattern

```typescript
class CacheAsideRepository {
  constructor(
    private cache: ICache,
    private repository: IRepository<User>
  ) {}

  async findById(id: string): Promise<User | null> {
    // Try cache first
    const cacheKey = `user:${id}`;
    const cached = await this.cache.get(cacheKey);
    
    if (cached) {
      return JSON.parse(cached);
    }
    
    // Load from database
    const user = await this.repository.findById(id);
    
    if (user) {
      // Store in cache
      await this.cache.set(
        cacheKey,
        JSON.stringify(user),
        { ttl: 3600 } // 1 hour TTL
      );
    }
    
    return user;
  }

  async update(id: string, data: Partial<User>): Promise<User> {
    // Update database
    const user = await this.repository.update(id, data);
    
    // Invalidate cache
    await this.cache.delete(`user:${id}`);
    
    return user;
  }
}
```

### Write-Through Cache

```typescript
class WriteThroughCache {
  constructor(
    private cache: ICache,
    private repository: IRepository<Product>
  ) {}

  async save(product: Product): Promise<Product> {
    // Write to cache and database simultaneously
    const [savedProduct] = await Promise.all([
      this.repository.save(product),
      this.cache.set(
        `product:${product.id}`,
        JSON.stringify(product)
      )
    ]);
    
    return savedProduct;
  }
}
```

### Write-Behind Cache

```typescript
class WriteBehindCache {
  private writeQueue: Map<string, { data: any; timestamp: number }> = new Map();
  private flushInterval: number = 5000; // 5 seconds

  constructor(
    private cache: ICache,
    private repository: IRepository<any>
  ) {
    this.startFlushTimer();
  }

  async save(entity: any): Promise<void> {
    const key = `entity:${entity.id}`;
    
    // Write to cache immediately
    await this.cache.set(key, JSON.stringify(entity));
    
    // Queue for database write
    this.writeQueue.set(entity.id, {
      data: entity,
      timestamp: Date.now()
    });
  }

  private startFlushTimer(): void {
    setInterval(async () => {
      await this.flush();
    }, this.flushInterval);
  }

  private async flush(): Promise<void> {
    if (this.writeQueue.size === 0) return;
    
    const batch = Array.from(this.writeQueue.entries());
    this.writeQueue.clear();
    
    try {
      // Batch write to database
      await this.repository.batchSave(
        batch.map(([_, item]) => item.data)
      );
    } catch (error) {
      // Re-queue failed items
      batch.forEach(([id, item]) => {
        this.writeQueue.set(id, item);
      });
      throw error;
    }
  }
}
```

## Data Consistency Patterns

### Eventual Consistency

```typescript
class EventuallyConsistentService {
  constructor(
    private primaryDb: Database,
    private replicaDb: Database,
    private eventBus: IEventBus
  ) {}

  async createOrder(orderData: CreateOrderDto): Promise<Order> {
    // Write to primary database
    const order = await this.primaryDb.transaction(async (tx) => {
      const order = await tx.insert('orders', orderData);
      await tx.update('inventory', { 
        id: orderData.productId,
        quantity: { decrement: orderData.quantity }
      });
      return order;
    });

    // Publish event for eventual consistency
    await this.eventBus.publish(new OrderCreatedEvent(order));

    return order;
  }

  // Event handler for replica updates
  async handleOrderCreated(event: OrderCreatedEvent): Promise<void> {
    try {
      // Update read replicas
      await this.replicaDb.insert('orders_read', event.order);
      
      // Update materialized views
      await this.updateOrderAnalytics(event.order);
      
      // Update search indices
      await this.updateSearchIndex(event.order);
    } catch (error) {
      // Log and retry logic
      await this.scheduleRetry(event);
    }
  }
}
```

### Saga Pattern

```typescript
// Saga Orchestrator
class OrderSaga {
  private steps: SagaStep[] = [];
  private compensations: CompensationStep[] = [];

  constructor(private services: SagaServices) {
    this.defineSteps();
  }

  private defineSteps(): void {
    // Step 1: Reserve Inventory
    this.steps.push({
      name: 'reserveInventory',
      execute: async (context: OrderContext) => {
        const reservation = await this.services.inventory.reserve(
          context.productId,
          context.quantity
        );
        context.reservationId = reservation.id;
        return reservation;
      },
      compensate: async (context: OrderContext) => {
        if (context.reservationId) {
          await this.services.inventory.cancelReservation(
            context.reservationId
          );
        }
      }
    });

    // Step 2: Process Payment
    this.steps.push({
      name: 'processPayment',
      execute: async (context: OrderContext) => {
        const payment = await this.services.payment.charge(
          context.customerId,
          context.amount
        );
        context.paymentId = payment.id;
        return payment;
      },
      compensate: async (context: OrderContext) => {
        if (context.paymentId) {
          await this.services.payment.refund(context.paymentId);
        }
      }
    });

    // Step 3: Create Order
    this.steps.push({
      name: 'createOrder',
      execute: async (context: OrderContext) => {
        const order = await this.services.order.create({
          customerId: context.customerId,
          items: context.items,
          paymentId: context.paymentId,
          reservationId: context.reservationId
        });
        context.orderId = order.id;
        return order;
      },
      compensate: async (context: OrderContext) => {
        if (context.orderId) {
          await this.services.order.cancel(context.orderId);
        }
      }
    });
  }

  async execute(orderRequest: OrderRequest): Promise<Order> {
    const context = new OrderContext(orderRequest);
    const executedSteps: number[] = [];

    try {
      // Execute all steps
      for (let i = 0; i < this.steps.length; i++) {
        await this.steps[i].execute(context);
        executedSteps.push(i);
      }

      return context.order;
    } catch (error) {
      // Compensate in reverse order
      for (let i = executedSteps.length - 1; i >= 0; i--) {
        try {
          await this.steps[executedSteps[i]].compensate(context);
        } catch (compensationError) {
          // Log compensation failure
          console.error(`Compensation failed for step ${i}:`, compensationError);
        }
      }
      
      throw new SagaExecutionError('Order saga failed', error, context);
    }
  }
}
```

## Multi-Level Cache Strategy

```typescript
class MultiLevelCache {
  constructor(
    private l1Cache: IMemoryCache,    // In-memory cache
    private l2Cache: IRedisCache,      // Redis cache
    private l3Storage: IRepository<any> // Database
  ) {}

  async get(key: string): Promise<any> {
    // Check L1 cache
    let value = await this.l1Cache.get(key);
    if (value) {
      return value;
    }

    // Check L2 cache
    value = await this.l2Cache.get(key);
    if (value) {
      // Populate L1
      await this.l1Cache.set(key, value, { ttl: 300 }); // 5 min
      return value;
    }

    // Load from database
    value = await this.l3Storage.findById(key);
    if (value) {
      // Populate both caches
      await Promise.all([
        this.l2Cache.set(key, value, { ttl: 3600 }), // 1 hour
        this.l1Cache.set(key, value, { ttl: 300 })   // 5 min
      ]);
    }

    return value;
  }

  async invalidate(key: string): Promise<void> {
    await Promise.all([
      this.l1Cache.delete(key),
      this.l2Cache.delete(key)
    ]);
  }
}
```

## Integration with AugmentedClaude Specialists

```typescript
// DataArchitect Specialist
const dataArchitect = {
  analyzeDataPatterns: async (codebase: string) => {
    return {
      currentPatterns: ['Repository', 'Cache-Aside'],
      recommendations: [
        {
          pattern: 'CQRS',
          reason: 'Complex read/write requirements detected',
          impact: 'Improved query performance by 40%'
        },
        {
          pattern: 'Event Sourcing',
          reason: 'Audit trail requirements identified',
          impact: 'Complete audit history with replay capability'
        }
      ],
      implementationPlan: [
        'Introduce CQRS for user queries',
        'Add event sourcing for financial transactions',
        'Implement saga pattern for distributed transactions'
      ]
    };
  }
};

// PerformanceOptimizer Specialist
const performanceOptimizer = {
  optimizeCaching: async (metrics: CacheMetrics) => {
    return {
      cacheHitRate: '85%',
      recommendations: [
        'Implement write-behind cache for user profiles',
        'Add multi-level caching for product catalog',
        'Use cache warming for popular items'
      ],
      expectedImprovement: '60% reduction in database load'
    };
  }
};
```

## Best Practices

1. **Choose the Right Pattern**: Select patterns based on specific requirements
2. **Start Simple**: Begin with basic patterns and evolve as needed
3. **Monitor Performance**: Track metrics to validate pattern effectiveness
4. **Handle Failures**: Implement proper error handling and recovery
5. **Document Decisions**: Record why specific patterns were chosen

## Common Pitfalls

1. **Over-engineering**: Don't implement complex patterns without clear benefits
2. **Ignoring Consistency**: Understand consistency trade-offs in distributed systems
3. **Cache Invalidation**: Have a clear strategy for cache invalidation
4. **Transaction Boundaries**: Define clear transaction boundaries in distributed systems
5. **Event Ordering**: Handle out-of-order events in event-sourced systems

## Conclusion

Data patterns provide proven solutions to common data management challenges. By understanding and correctly applying these patterns, teams can build robust, scalable data architectures that support business growth while maintaining consistency and performance.