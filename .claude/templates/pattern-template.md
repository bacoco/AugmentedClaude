# Pattern Template

<!--
INSTRUCTIONS FOR USING THIS TEMPLATE:
1. Copy this template to the appropriate location in /patterns/
2. Replace all placeholder text wrapped in [brackets]
3. Remove any optional sections that aren't needed
4. Ensure all references use the @ notation
5. Follow the examples at the bottom for guidance
6. Patterns should be reusable, proven solutions to common problems
-->

# [Pattern Name] Pattern

## Pattern Overview
<!-- REQUIRED: Brief description of the pattern and its purpose -->
**Category**: [architectural/development/operational]
**Problem**: [What problem does this pattern solve?]
**Solution**: [High-level description of the solution]
**When to Use**: [Specific scenarios where this pattern applies]

## Context & Applicability
<!-- REQUIRED: Define when and where to use this pattern -->
- **Use Cases**: [List specific use cases]
- **Prerequisites**: [What needs to be in place before applying this pattern]
- **Constraints**: [Any limitations or restrictions]
- **Anti-patterns**: [What NOT to do / common mistakes]

## Implementation Details
<!-- REQUIRED: Detailed implementation guidance -->

### Core Components
1. **[Component 1]**
   - Purpose: [What this component does]
   - Implementation: [How to implement it]
   - Dependencies: [What it depends on]

2. **[Component 2]**
   - Purpose: [What this component does]
   - Implementation: [How to implement it]
   - Dependencies: [What it depends on]

### Implementation Steps
1. **[Step 1: Name]**
   ```
   [Code example or command]
   ```
   - [Explanation of what this step does]
   - [Any important considerations]

2. **[Step 2: Name]**
   ```
   [Code example or command]
   ```
   - [Explanation of what this step does]
   - [Expected outcome]

<!-- Add more steps as needed -->

## Integration Guidelines
<!-- REQUIRED: How this pattern integrates with the system -->

### Specialist Integration
- **Primary Specialist**: @claude/agents/[category]/[specialist].md
- **Supporting Specialists**: [List of specialists that use this pattern]

### Command Integration
- **Commands Using This Pattern**:
  - @commands/[category]/[command].md#[section]
  - @commands/[category]/[command].md#[section]

### Related Patterns
- **Complements**: @claude/patterns/[category]/[pattern].md
- **Alternatives**: @claude/patterns/[category]/[pattern].md
- **Extensions**: @claude/patterns/[category]/[pattern].md

## Examples & Variations

### Example 1: [Name]
<!-- REQUIRED: At least one concrete example -->
```
[Detailed code example showing the pattern in use]
```
**Context**: [When/why to use this variation]
**Benefits**: [What advantages this provides]

### Example 2: [Name]
<!-- OPTIONAL: Additional examples for different scenarios -->
```
[Another example showing a different use case]
```
**Context**: [When/why to use this variation]
**Trade-offs**: [Any compromises or considerations]

## Quality Attributes
<!-- REQUIRED: How this pattern affects system qualities -->
- **Performance Impact**: [How it affects performance]
- **Security Considerations**: [Security implications]
- **Maintainability**: [How it affects code maintenance]
- **Scalability**: [How well it scales]
- **Testability**: [How easy it is to test]

## Common Pitfalls
<!-- OPTIONAL but RECOMMENDED: What to watch out for -->
1. **[Pitfall Name]**: [Description and how to avoid]
2. **[Pitfall Name]**: [Description and how to avoid]
3. **[Pitfall Name]**: [Description and how to avoid]

## References & Resources
<!-- OPTIONAL: Additional learning resources -->
- **Documentation**: [Links to relevant docs]
- **Tools**: @claude/mcp-integration/[tool].md
- **Memory**: @claude/memory/knowledge/[relevant-knowledge].md

---

## EXAMPLE: Completed Pattern Template

# Circuit Breaker Pattern

## Pattern Overview
**Category**: architectural
**Problem**: Preventing cascading failures when downstream services fail
**Solution**: Implement a circuit breaker that trips when failures exceed threshold
**When to Use**: Microservices architectures with external dependencies

## Context & Applicability
- **Use Cases**: API integrations, microservice communication, database connections
- **Prerequisites**: Distributed system, external dependencies, retry logic in place
- **Constraints**: Adds complexity, requires monitoring, needs fallback strategies
- **Anti-patterns**: Using for internal method calls, over-aggressive thresholds

## Implementation Details

### Core Components
1. **Circuit Breaker State Machine**
   - Purpose: Manages circuit states (closed, open, half-open)
   - Implementation: State pattern with threshold tracking
   - Dependencies: Monitoring system, metrics collection

2. **Failure Detector**
   - Purpose: Tracks failures and determines when to trip
   - Implementation: Sliding window or token bucket algorithm
   - Dependencies: Time service, error classification

3. **Fallback Handler**
   - Purpose: Provides alternative responses when circuit is open
   - Implementation: Cached responses, default values, or degraded service
   - Dependencies: Cache service, default configuration

### Implementation Steps
1. **Define Failure Thresholds**
   ```javascript
   const circuitBreaker = new CircuitBreaker({
     failureThreshold: 5,
     resetTimeout: 60000,
     monitoringPeriod: 10000
   });
   ```
   - Set failure count threshold for opening circuit
   - Configure reset timeout for half-open attempts

2. **Implement State Transitions**
   ```javascript
   class CircuitBreaker {
     async call(request) {
       if (this.state === 'OPEN') {
         return this.fallback(request);
       }
       
       try {
         const response = await this.execute(request);
         this.onSuccess();
         return response;
       } catch (error) {
         this.onFailure();
         throw error;
       }
     }
   }
   ```
   - Handle state-based request routing
   - Track successes and failures

## Integration Guidelines

### Specialist Integration
- **Primary Specialist**: @claude/agents/cognitive/architect.md
- **Supporting Specialists**: 
  - @claude/agents/technical/backend-dev.md
  - @claude/agents/technical/devops.md

### Command Integration
- **Commands Using This Pattern**:
  - @commands/core/build.md#microservices
  - @commands/specialized/optimize.md#resilience

### Related Patterns
- **Complements**: @claude/patterns/architectural/retry-pattern.md
- **Alternatives**: @claude/patterns/architectural/bulkhead-pattern.md
- **Extensions**: @claude/patterns/operational/monitoring-patterns.md#circuit-breaker-metrics

## Examples & Variations

### Example 1: HTTP Service Circuit Breaker
```javascript
const apiCircuitBreaker = new CircuitBreaker({
  name: 'payment-api',
  failureThreshold: 5,
  resetTimeout: 30000,
  fallback: async (request) => {
    return { status: 'queued', message: 'Payment will be processed later' };
  }
});

async function processPayment(data) {
  return apiCircuitBreaker.call(async () => {
    return await paymentAPI.process(data);
  });
}
```
**Context**: Payment processing with graceful degradation
**Benefits**: Prevents payment system overload, maintains user experience

### Example 2: Database Circuit Breaker
```javascript
const dbCircuitBreaker = new CircuitBreaker({
  name: 'user-db',
  failureThreshold: 3,
  resetTimeout: 10000,
  fallback: async (query) => {
    return await cacheService.get(query.key);
  }
});
```
**Context**: Database protection with cache fallback
**Trade-offs**: May serve stale data, but maintains availability

## Quality Attributes
- **Performance Impact**: Minimal overhead, faster failure detection
- **Security Considerations**: Ensure fallbacks don't expose sensitive data
- **Maintainability**: Centralized failure handling, clear state management
- **Scalability**: Prevents cascade failures, maintains system stability
- **Testability**: Easy to unit test states and transitions

## Common Pitfalls
1. **Too Aggressive Thresholds**: Setting thresholds too low causes unnecessary trips
2. **Missing Fallbacks**: Not providing meaningful fallback responses
3. **Ignoring Half-Open State**: Not properly testing service recovery

## References & Resources
- **Documentation**: Martin Fowler's Circuit Breaker article
- **Tools**: @claude/mcp-integration/sequential.md#state-management
- **Memory**: @claude/memory/knowledge/resilience-patterns.md