# Event-Driven Architecture Pattern

## Pattern Name & Overview

**Event-Driven Architecture (EDA)** is a software architecture pattern where system components communicate through the production and consumption of events. Components are loosely coupled, reacting to events asynchronously, enabling scalable and flexible systems that can evolve independently.

## Problem Context (When to Use)

Consider event-driven architecture when:
- Multiple systems need to react to the same business events
- You need real-time or near-real-time processing
- Systems require high scalability and loose coupling
- You want to decouple producers from consumers
- Business processes span multiple bounded contexts
- You need audit trails of all system activities
- Integration with external systems is required

## Solution

Event-driven architecture consists of:

1. **Event Producers**: Components that detect and publish events
2. **Event Router/Broker**: Infrastructure that manages event distribution
3. **Event Consumers**: Components that subscribe to and process events
4. **Event Store**: Optional persistent storage of events
5. **Event Schema Registry**: Manages event contracts and versions

### Architecture Overview

```
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   Producer  │─────▶│Event Broker │─────▶│  Consumer   │
│   Service   │      │  (Kafka)    │      │  Service A  │
└─────────────┘      └──────┬──────┘      └─────────────┘
                            │                     
                            ├─────────────▶┌─────────────┐
                            │              │  Consumer   │
                            │              │  Service B  │
                            │              └─────────────┘
                            │                     
                            └─────────────▶┌─────────────┐
                                          │ Event Store │
                                          └─────────────┘
```

## Implementation Guidelines

### 1. Define Event Types and Schema

```javascript
// Event schema definition
const UserCreatedEvent = {
  eventType: 'user.created',
  version: '1.0',
  schema: {
    eventId: 'string',
    timestamp: 'ISO 8601',
    data: {
      userId: 'string',
      email: 'string',
      name: 'string',
      registrationSource: 'string'
    },
    metadata: {
      correlationId: 'string',
      causationId: 'string',
      actor: 'string'
    }
  }
};
```

### 2. Implement Event Producer

```javascript
// Event producer with Kafka
const { Kafka } = require('kafkajs');

class EventProducer {
  constructor() {
    this.kafka = new Kafka({
      clientId: 'user-service',
      brokers: ['localhost:9092']
    });
    this.producer = this.kafka.producer();
  }

  async connect() {
    await this.producer.connect();
  }

  async publishEvent(event) {
    const message = {
      key: event.aggregateId,
      value: JSON.stringify(event),
      headers: {
        'event-type': event.eventType,
        'version': event.version,
        'correlation-id': event.metadata.correlationId
      }
    };

    await this.producer.send({
      topic: this.getTopicForEvent(event.eventType),
      messages: [message]
    });
  }

  getTopicForEvent(eventType) {
    // user.created -> user-events
    const [domain] = eventType.split('.');
    return `${domain}-events`;
  }
}
```

### 3. Implement Event Consumer

```javascript
// Event consumer with error handling and retries
class EventConsumer {
  constructor(topics, handler) {
    this.kafka = new Kafka({
      clientId: 'notification-service',
      brokers: ['localhost:9092']
    });
    this.consumer = this.kafka.consumer({ 
      groupId: 'notification-group' 
    });
    this.topics = topics;
    this.handler = handler;
  }

  async start() {
    await this.consumer.connect();
    await this.consumer.subscribe({ 
      topics: this.topics,
      fromBeginning: false 
    });

    await this.consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        try {
          const event = JSON.parse(message.value.toString());
          await this.handler(event);
          
          // Acknowledge successful processing
          await this.consumer.commitOffsets([{
            topic,
            partition,
            offset: (parseInt(message.offset) + 1).toString()
          }]);
        } catch (error) {
          console.error('Error processing event:', error);
          // Implement retry logic or dead letter queue
          await this.handleError(message, error);
        }
      }
    });
  }

  async handleError(message, error) {
    // Send to dead letter queue after max retries
    const retryCount = parseInt(message.headers['retry-count'] || '0');
    if (retryCount < 3) {
      // Republish with incremented retry count
      await this.republishWithRetry(message, retryCount + 1);
    } else {
      await this.sendToDeadLetterQueue(message, error);
    }
  }
}
```

### 4. Event Sourcing Implementation

```javascript
// Event store for event sourcing
class EventStore {
  constructor(database) {
    this.db = database;
  }

  async appendEvents(streamId, events, expectedVersion) {
    const transaction = await this.db.transaction();
    
    try {
      // Check for concurrency conflicts
      const currentVersion = await this.getStreamVersion(streamId);
      if (currentVersion !== expectedVersion) {
        throw new ConcurrencyError('Stream version conflict');
      }

      // Append events
      for (const event of events) {
        await transaction.insert('events', {
          stream_id: streamId,
          event_type: event.type,
          event_data: JSON.stringify(event.data),
          event_metadata: JSON.stringify(event.metadata),
          version: ++currentVersion,
          timestamp: new Date()
        });
      }

      await transaction.commit();
      
      // Publish to event bus
      await this.publishEvents(events);
    } catch (error) {
      await transaction.rollback();
      throw error;
    }
  }

  async getEvents(streamId, fromVersion = 0) {
    const events = await this.db.query(
      'SELECT * FROM events WHERE stream_id = ? AND version > ? ORDER BY version',
      [streamId, fromVersion]
    );
    
    return events.map(e => ({
      type: e.event_type,
      data: JSON.parse(e.event_data),
      metadata: JSON.parse(e.event_metadata),
      version: e.version,
      timestamp: e.timestamp
    }));
  }
}
```

## Code Examples

### Complete Event-Driven System Example

```javascript
// Domain event definitions
class DomainEvent {
  constructor(aggregateId, eventType, data) {
    this.eventId = crypto.randomUUID();
    this.aggregateId = aggregateId;
    this.eventType = eventType;
    this.timestamp = new Date().toISOString();
    this.data = data;
    this.metadata = {
      correlationId: context.correlationId || crypto.randomUUID(),
      causationId: context.causationId || this.eventId,
      actor: context.actor || 'system'
    };
  }
}

// Order service (Producer)
class OrderService {
  constructor(eventBus) {
    this.eventBus = eventBus;
  }

  async createOrder(orderData) {
    // Business logic
    const order = {
      id: crypto.randomUUID(),
      ...orderData,
      status: 'pending',
      createdAt: new Date()
    };

    // Save to database
    await this.orderRepository.save(order);

    // Publish event
    const event = new DomainEvent(
      order.id,
      'order.created',
      {
        orderId: order.id,
        customerId: order.customerId,
        items: order.items,
        totalAmount: order.totalAmount
      }
    );

    await this.eventBus.publish(event);
    return order;
  }
}

// Inventory service (Consumer)
class InventoryService {
  constructor(eventBus) {
    this.eventBus = eventBus;
    this.subscribeToEvents();
  }

  subscribeToEvents() {
    this.eventBus.subscribe('order.created', async (event) => {
      await this.handleOrderCreated(event);
    });
  }

  async handleOrderCreated(event) {
    const { items } = event.data;
    
    try {
      // Reserve inventory
      for (const item of items) {
        await this.reserveInventory(item.productId, item.quantity);
      }

      // Publish success event
      await this.eventBus.publish(new DomainEvent(
        event.aggregateId,
        'inventory.reserved',
        { orderId: event.data.orderId, items }
      ));
    } catch (error) {
      // Publish failure event
      await this.eventBus.publish(new DomainEvent(
        event.aggregateId,
        'inventory.reservation.failed',
        { orderId: event.data.orderId, reason: error.message }
      ));
    }
  }
}

// Saga orchestrator for complex workflows
class OrderSaga {
  constructor(eventBus) {
    this.eventBus = eventBus;
    this.state = new Map();
    this.subscribeToEvents();
  }

  subscribeToEvents() {
    this.eventBus.subscribe('order.created', this.handleOrderCreated.bind(this));
    this.eventBus.subscribe('inventory.reserved', this.handleInventoryReserved.bind(this));
    this.eventBus.subscribe('payment.processed', this.handlePaymentProcessed.bind(this));
    this.eventBus.subscribe('*.failed', this.handleFailure.bind(this));
  }

  async handleOrderCreated(event) {
    this.state.set(event.aggregateId, {
      status: 'started',
      orderId: event.data.orderId
    });
  }

  async handleInventoryReserved(event) {
    const state = this.state.get(event.aggregateId);
    state.inventoryReserved = true;

    // Trigger payment
    await this.eventBus.publish(new DomainEvent(
      event.aggregateId,
      'payment.requested',
      { orderId: state.orderId, amount: event.data.totalAmount }
    ));
  }

  async handlePaymentProcessed(event) {
    const state = this.state.get(event.aggregateId);
    state.paymentProcessed = true;

    // Complete order
    await this.eventBus.publish(new DomainEvent(
      event.aggregateId,
      'order.completed',
      { orderId: state.orderId }
    ));

    this.state.delete(event.aggregateId);
  }

  async handleFailure(event) {
    // Compensate by reversing completed steps
    const state = this.state.get(event.aggregateId);
    
    if (state.inventoryReserved) {
      await this.eventBus.publish(new DomainEvent(
        event.aggregateId,
        'inventory.release.requested',
        { orderId: state.orderId }
      ));
    }

    await this.eventBus.publish(new DomainEvent(
      event.aggregateId,
      'order.cancelled',
      { orderId: state.orderId, reason: event.data.reason }
    ));
  }
}
```

## Benefits & Trade-offs

### Benefits
- **Loose Coupling**: Services don't need to know about each other
- **Scalability**: Easy to scale individual components
- **Flexibility**: Add new consumers without changing producers
- **Resilience**: System continues operating if some components fail
- **Real-time Processing**: Events processed as they occur
- **Audit Trail**: Natural audit log of all system activities

### Trade-offs
- **Complexity**: Debugging distributed flows is challenging
- **Eventual Consistency**: No immediate consistency guarantees
- **Message Ordering**: Difficult to maintain strict ordering at scale
- **Duplicate Events**: Must handle idempotency
- **Error Handling**: Complex retry and compensation logic
- **Testing**: Integration testing is more complex

## Common Pitfalls

1. **Missing Idempotency**: Not handling duplicate events properly
2. **Tight Coupling via Events**: Creating dependencies through event payloads
3. **Event Payload Size**: Including too much data in events
4. **Missing Event Versioning**: Not planning for schema evolution
5. **Synchronous Event Processing**: Blocking on event processing
6. **No Dead Letter Queue**: Missing error handling strategy
7. **Ignoring Message Ordering**: Assuming events arrive in order

## Integration with AugmentedClaude Specialists

### System Architect
- Designs event flow and boundaries
- Defines event schemas and contracts
- Selects appropriate messaging infrastructure

### Backend Developer
- Implements event producers and consumers
- Handles event serialization/deserialization
- Manages event versioning

### DevOps Engineer
- Deploys and manages message brokers
- Monitors event flow and latency
- Implements disaster recovery

### Data Engineer
- Designs event storage strategies
- Implements event analytics
- Manages event archival

## Related Patterns

- **CQRS**: Separating command and query responsibilities
- **Event Sourcing**: Storing state as sequence of events
- **Saga Pattern**: Managing distributed transactions
- **Publish-Subscribe**: Event distribution pattern
- **Message Queue**: Point-to-point messaging
- **Circuit Breaker**: Handling consumer failures

## Best Practices

1. **Event Design**
   - Keep events small and focused
   - Include only necessary data
   - Use clear, business-oriented names
   - Version events from the start

2. **Infrastructure**
   - Choose appropriate message broker (Kafka, RabbitMQ, AWS EventBridge)
   - Implement monitoring and alerting
   - Plan for message retention
   - Set up dead letter queues

3. **Implementation**
   ```javascript
   // Event naming convention
   const eventNaming = {
     pattern: '<noun>.<past-tense-verb>',
     examples: [
       'order.created',
       'payment.processed',
       'inventory.updated',
       'user.registered'
     ]
   };

   // Idempotency implementation
   class IdempotentEventHandler {
     async handle(event) {
       const processed = await this.checkIfProcessed(event.eventId);
       if (processed) return;

       await this.processEvent(event);
       await this.markAsProcessed(event.eventId);
     }
   }
   ```

4. **Error Handling**
   - Implement retry mechanisms with exponential backoff
   - Use circuit breakers for failing consumers
   - Log all errors with context
   - Monitor consumer lag

5. **Testing Strategy**
   ```javascript
   // Integration test example
   describe('Order Processing Flow', () => {
     it('should complete order when all services respond', async () => {
       const testEventBus = new TestEventBus();
       const orderService = new OrderService(testEventBus);
       
       const order = await orderService.createOrder({
         customerId: 'test-customer',
         items: [{ productId: 'test-product', quantity: 1 }]
       });

       // Verify events published
       expect(testEventBus.publishedEvents).toContainEqual(
         expect.objectContaining({
           eventType: 'order.created',
           data: expect.objectContaining({
             orderId: order.id
           })
         })
       );
     });
   });
   ```

This pattern enables building highly scalable, flexible systems that can evolve independently while maintaining loose coupling between components.