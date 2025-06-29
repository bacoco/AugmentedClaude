# Testing Patterns

## Pattern Name & Overview

**Testing Patterns** encompass strategies, techniques, and best practices for ensuring software quality through systematic testing. These patterns cover unit testing, integration testing, end-to-end testing, and specialized testing approaches that help teams build reliable, maintainable software.

## Problem Context (When to Use)

Apply testing patterns when:
- Building mission-critical applications requiring high reliability
- Working in teams where code quality and maintainability are priorities
- Implementing continuous integration/deployment pipelines
- Refactoring legacy code safely
- Ensuring compliance with quality standards
- Preventing regression bugs
- Documenting expected behavior through tests

## Solution

Testing patterns are organized into several categories:

1. **Unit Testing Patterns**: Testing individual components in isolation
2. **Integration Testing Patterns**: Testing component interactions
3. **End-to-End Testing Patterns**: Testing complete user workflows
4. **Test Organization Patterns**: Structuring and managing test suites
5. **Mocking and Stubbing Patterns**: Isolating dependencies
6. **Property-Based Testing**: Testing with generated inputs
7. **Contract Testing**: Ensuring API compatibility

## Implementation Guidelines

### 1. Unit Testing Patterns

#### Arrange-Act-Assert (AAA) Pattern
```javascript
describe('Calculator', () => {
  it('should add two numbers correctly', () => {
    // Arrange
    const calculator = new Calculator();
    const a = 5;
    const b = 3;
    
    // Act
    const result = calculator.add(a, b);
    
    // Assert
    expect(result).toBe(8);
  });
});
```

#### Test Data Builder Pattern
```javascript
// Builder for creating test data
class UserBuilder {
  constructor() {
    this.user = {
      id: Math.random().toString(36),
      name: 'Test User',
      email: 'test@example.com',
      age: 25,
      isActive: true
    };
  }

  withName(name) {
    this.user.name = name;
    return this;
  }

  withEmail(email) {
    this.user.email = email;
    return this;
  }

  withAge(age) {
    this.user.age = age;
    return this;
  }

  inactive() {
    this.user.isActive = false;
    return this;
  }

  build() {
    return { ...this.user };
  }
}

// Usage in tests
describe('UserService', () => {
  it('should create inactive user', () => {
    const user = new UserBuilder()
      .withName('John Doe')
      .inactive()
      .build();
    
    const result = userService.create(user);
    expect(result.isActive).toBe(false);
  });
});
```

#### Parameterized Testing Pattern
```javascript
// Jest example with test.each
describe('ValidationService', () => {
  test.each([
    ['test@example.com', true],
    ['invalid-email', false],
    ['user@domain.co.uk', true],
    ['@example.com', false],
    ['user@', false]
  ])('validates email %s as %s', (email, expected) => {
    expect(ValidationService.isValidEmail(email)).toBe(expected);
  });

  // Table-driven tests
  test.each`
    input    | expected
    ${0}     | ${'zero'}
    ${1}     | ${'one'}
    ${-1}    | ${'negative'}
    ${100}   | ${'positive'}
  `('converts $input to $expected', ({ input, expected }) => {
    expect(numberToWord(input)).toBe(expected);
  });
});
```

### 2. Integration Testing Patterns

#### Database Testing Pattern
```javascript
// Test with real database using transactions
describe('UserRepository Integration Tests', () => {
  let db;
  let transaction;

  beforeEach(async () => {
    db = await createTestDatabase();
    transaction = await db.beginTransaction();
  });

  afterEach(async () => {
    await transaction.rollback();
    await db.close();
  });

  it('should create and retrieve user', async () => {
    // Use transaction for isolation
    const repository = new UserRepository(transaction);
    
    const user = await repository.create({
      name: 'Test User',
      email: 'test@example.com'
    });

    const retrieved = await repository.findById(user.id);
    expect(retrieved).toEqual(user);
  });
});

// In-memory database for faster tests
class InMemoryUserRepository {
  constructor() {
    this.users = new Map();
    this.nextId = 1;
  }

  async create(userData) {
    const user = { id: this.nextId++, ...userData };
    this.users.set(user.id, user);
    return user;
  }

  async findById(id) {
    return this.users.get(id) || null;
  }
}
```

#### API Integration Testing
```javascript
// Supertest for Express apps
const request = require('supertest');
const app = require('../app');

describe('API Integration Tests', () => {
  let server;
  let authToken;

  beforeAll(async () => {
    server = app.listen();
    // Setup test data and get auth token
    authToken = await getTestAuthToken();
  });

  afterAll(async () => {
    await server.close();
  });

  describe('POST /api/users', () => {
    it('should create user with valid data', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com'
      };

      const response = await request(server)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send(userData)
        .expect(201);

      expect(response.body).toMatchObject({
        id: expect.any(String),
        ...userData
      });
    });

    it('should return 400 for invalid data', async () => {
      const response = await request(server)
        .post('/api/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({ name: 'John' }) // Missing email
        .expect(400);

      expect(response.body).toMatchObject({
        error: 'Validation failed',
        details: expect.any(Array)
      });
    });
  });
});
```

### 3. End-to-End Testing Patterns

#### Page Object Pattern
```javascript
// Page Object for better maintainability
class LoginPage {
  constructor(page) {
    this.page = page;
    this.usernameInput = '#username';
    this.passwordInput = '#password';
    this.submitButton = '#login-button';
    this.errorMessage = '.error-message';
  }

  async navigate() {
    await this.page.goto('/login');
  }

  async login(username, password) {
    await this.page.fill(this.usernameInput, username);
    await this.page.fill(this.passwordInput, password);
    await this.page.click(this.submitButton);
  }

  async getErrorMessage() {
    return await this.page.textContent(this.errorMessage);
  }

  async isLoggedIn() {
    return await this.page.url().includes('/dashboard');
  }
}

// E2E test using Page Object
describe('Login Flow', () => {
  let page;
  let loginPage;

  beforeEach(async () => {
    page = await browser.newPage();
    loginPage = new LoginPage(page);
    await loginPage.navigate();
  });

  it('should login with valid credentials', async () => {
    await loginPage.login('user@example.com', 'password123');
    expect(await loginPage.isLoggedIn()).toBe(true);
  });

  it('should show error for invalid credentials', async () => {
    await loginPage.login('invalid@example.com', 'wrong');
    const error = await loginPage.getErrorMessage();
    expect(error).toBe('Invalid credentials');
  });
});
```

#### Screenplay Pattern
```javascript
// Actor-based testing for complex scenarios
class Actor {
  constructor(name, abilities = []) {
    this.name = name;
    this.abilities = abilities;
  }

  can(ability) {
    this.abilities.push(ability);
    return this;
  }

  attemptsTo(...tasks) {
    return tasks.reduce(
      (promise, task) => promise.then(() => task.performAs(this)),
      Promise.resolve()
    );
  }
}

// Tasks
class Login {
  constructor(username, password) {
    this.username = username;
    this.password = password;
  }

  async performAs(actor) {
    const browseTheWeb = actor.abilities.find(a => a instanceof BrowseTheWeb);
    await browseTheWeb.page.goto('/login');
    await browseTheWeb.page.fill('#username', this.username);
    await browseTheWeb.page.fill('#password', this.password);
    await browseTheWeb.page.click('#submit');
  }
}

// Usage
describe('User Journey', () => {
  it('should complete purchase flow', async () => {
    const john = new Actor('John')
      .can(new BrowseTheWeb(page));

    await john.attemptsTo(
      new Login('john@example.com', 'password'),
      new SearchForProduct('laptop'),
      new AddToCart(),
      new Checkout(),
      new VerifyOrderConfirmation()
    );
  });
});
```

### 4. Mocking and Stubbing Patterns

#### Dependency Injection for Testability
```javascript
// Service with injected dependencies
class EmailService {
  constructor(smtpClient, templateEngine, logger) {
    this.smtpClient = smtpClient;
    this.templateEngine = templateEngine;
    this.logger = logger;
  }

  async sendWelcomeEmail(user) {
    try {
      const html = await this.templateEngine.render('welcome', { user });
      
      await this.smtpClient.send({
        to: user.email,
        subject: 'Welcome!',
        html
      });

      this.logger.info(`Welcome email sent to ${user.email}`);
    } catch (error) {
      this.logger.error('Failed to send welcome email', error);
      throw error;
    }
  }
}

// Test with mocks
describe('EmailService', () => {
  let emailService;
  let mockSmtpClient;
  let mockTemplateEngine;
  let mockLogger;

  beforeEach(() => {
    mockSmtpClient = {
      send: jest.fn().mockResolvedValue(true)
    };
    mockTemplateEngine = {
      render: jest.fn().mockResolvedValue('<h1>Welcome!</h1>')
    };
    mockLogger = {
      info: jest.fn(),
      error: jest.fn()
    };

    emailService = new EmailService(
      mockSmtpClient,
      mockTemplateEngine,
      mockLogger
    );
  });

  it('should send welcome email successfully', async () => {
    const user = { email: 'test@example.com', name: 'Test User' };

    await emailService.sendWelcomeEmail(user);

    expect(mockTemplateEngine.render).toHaveBeenCalledWith('welcome', { user });
    expect(mockSmtpClient.send).toHaveBeenCalledWith({
      to: user.email,
      subject: 'Welcome!',
      html: '<h1>Welcome!</h1>'
    });
    expect(mockLogger.info).toHaveBeenCalledWith(
      `Welcome email sent to ${user.email}`
    );
  });

  it('should handle send failure', async () => {
    const error = new Error('SMTP connection failed');
    mockSmtpClient.send.mockRejectedValue(error);

    const user = { email: 'test@example.com' };

    await expect(emailService.sendWelcomeEmail(user))
      .rejects.toThrow('SMTP connection failed');

    expect(mockLogger.error).toHaveBeenCalledWith(
      'Failed to send welcome email',
      error
    );
  });
});
```

### 5. Property-Based Testing

```javascript
// Using fast-check for property-based testing
import fc from 'fast-check';

describe('Sorting Algorithm Properties', () => {
  it('should maintain array length', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        const sorted = quickSort([...arr]);
        return sorted.length === arr.length;
      })
    );
  });

  it('should produce ordered output', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        const sorted = quickSort([...arr]);
        for (let i = 1; i < sorted.length; i++) {
          if (sorted[i] < sorted[i - 1]) return false;
        }
        return true;
      })
    );
  });

  it('should be idempotent', () => {
    fc.assert(
      fc.property(fc.array(fc.integer()), (arr) => {
        const sorted1 = quickSort([...arr]);
        const sorted2 = quickSort([...sorted1]);
        return JSON.stringify(sorted1) === JSON.stringify(sorted2);
      })
    );
  });
});

// Domain-specific property testing
describe('User Registration Properties', () => {
  it('should always create valid users', () => {
    fc.assert(
      fc.property(
        fc.record({
          name: fc.string({ minLength: 1, maxLength: 100 }),
          email: fc.emailAddress(),
          age: fc.integer({ min: 0, max: 150 })
        }),
        async (userData) => {
          const user = await userService.register(userData);
          
          // Properties that should always hold
          expect(user.id).toBeDefined();
          expect(user.createdAt).toBeInstanceOf(Date);
          expect(user.name).toBe(userData.name);
          expect(user.email.toLowerCase()).toBe(userData.email.toLowerCase());
          expect(user.isActive).toBe(true);
        }
      )
    );
  });
});
```

### 6. Contract Testing

```javascript
// Consumer-driven contract testing with Pact
const { Pact } = require('@pact-foundation/pact');
const { UserApiClient } = require('./UserApiClient');

describe('User API Contract', () => {
  const provider = new Pact({
    consumer: 'Frontend',
    provider: 'UserService',
    port: 1234
  });

  beforeAll(() => provider.setup());
  afterAll(() => provider.finalize());

  describe('get user', () => {
    it('should return user details', async () => {
      // Define expected interaction
      await provider.addInteraction({
        state: 'user 123 exists',
        uponReceiving: 'a request for user 123',
        withRequest: {
          method: 'GET',
          path: '/users/123',
          headers: {
            'Accept': 'application/json'
          }
        },
        willRespondWith: {
          status: 200,
          headers: {
            'Content-Type': 'application/json'
          },
          body: {
            id: '123',
            name: 'John Doe',
            email: 'john@example.com'
          }
        }
      });

      // Test the client
      const client = new UserApiClient('http://localhost:1234');
      const user = await client.getUser('123');

      expect(user).toEqual({
        id: '123',
        name: 'John Doe',
        email: 'john@example.com'
      });
    });
  });
});
```

## Code Examples

### Complete Testing Strategy Implementation

```javascript
// Test utilities and helpers
// test/utils/testHelpers.js
export const testHelpers = {
  // Database helpers
  async createTestDatabase() {
    const db = new Database(':memory:');
    await db.migrate();
    return db;
  },

  // Authentication helpers
  async createAuthenticatedUser(overrides = {}) {
    const user = await User.create({
      email: 'test@example.com',
      password: 'password123',
      ...overrides
    });
    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET);
    return { user, token };
  },

  // Time manipulation
  freezeTime(date = new Date()) {
    jest.useFakeTimers();
    jest.setSystemTime(date);
    return {
      restore: () => jest.useRealTimers()
    };
  },

  // Random data generators
  generateUser(overrides = {}) {
    return {
      id: faker.datatype.uuid(),
      name: faker.name.fullName(),
      email: faker.internet.email(),
      ...overrides
    };
  }
};

// Custom matchers
expect.extend({
  toBeWithinRange(received, floor, ceiling) {
    const pass = received >= floor && received <= ceiling;
    return {
      pass,
      message: () =>
        `expected ${received} to be within range ${floor} - ${ceiling}`
    };
  },

  toMatchJsonSchema(received, schema) {
    const ajv = new Ajv();
    const valid = ajv.validate(schema, received);
    return {
      pass: valid,
      message: () =>
        valid
          ? `expected ${received} not to match schema`
          : `expected ${received} to match schema: ${ajv.errorsText()}`
    };
  }
});

// Test configuration
// jest.config.js
module.exports = {
  projects: [
    {
      displayName: 'unit',
      testMatch: ['<rootDir>/src/**/*.test.js'],
      testEnvironment: 'node',
      setupFilesAfterEnv: ['<rootDir>/test/setupUnit.js']
    },
    {
      displayName: 'integration',
      testMatch: ['<rootDir>/test/integration/**/*.test.js'],
      testEnvironment: 'node',
      setupFilesAfterEnv: ['<rootDir>/test/setupIntegration.js']
    },
    {
      displayName: 'e2e',
      testMatch: ['<rootDir>/test/e2e/**/*.test.js'],
      preset: 'jest-playwright-preset',
      setupFilesAfterEnv: ['<rootDir>/test/setupE2E.js']
    }
  ],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/**/*.test.js',
    '!src/test-utils/**'
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  }
};

// Example comprehensive test suite
describe('OrderService - Complete Test Suite', () => {
  describe('Unit Tests', () => {
    let orderService;
    let mockDependencies;

    beforeEach(() => {
      mockDependencies = {
        orderRepository: createMock('OrderRepository'),
        paymentService: createMock('PaymentService'),
        inventoryService: createMock('InventoryService'),
        notificationService: createMock('NotificationService')
      };
      orderService = new OrderService(mockDependencies);
    });

    it('should calculate order total correctly', () => {
      const items = [
        { price: 10.00, quantity: 2 },
        { price: 5.50, quantity: 3 }
      ];
      
      const total = orderService.calculateTotal(items);
      
      expect(total).toBe(36.50);
    });
  });

  describe('Integration Tests', () => {
    let orderService;
    let testDb;

    beforeEach(async () => {
      testDb = await createTestDatabase();
      orderService = createOrderServiceWithRealDependencies(testDb);
    });

    afterEach(async () => {
      await testDb.close();
    });

    it('should create order with inventory check', async () => {
      // Setup test data
      await testDb.seed('products', [
        { id: 1, name: 'Product 1', stock: 10 }
      ]);

      const order = await orderService.createOrder({
        customerId: 1,
        items: [{ productId: 1, quantity: 2 }]
      });

      expect(order.status).toBe('confirmed');
      
      // Verify inventory was updated
      const product = await testDb.findById('products', 1);
      expect(product.stock).toBe(8);
    });
  });

  describe('E2E Tests', () => {
    it('should complete full order flow', async () => {
      const customer = await createTestCustomer();
      
      await page.goto('/products');
      await page.click('[data-testid="product-1"]');
      await page.click('[data-testid="add-to-cart"]');
      await page.click('[data-testid="checkout"]');
      
      await page.fill('[data-testid="card-number"]', '4242424242424242');
      await page.click('[data-testid="place-order"]');
      
      await expect(page).toHaveURL('/order-confirmation');
      await expect(page.locator('[data-testid="order-number"]')).toBeVisible();
    });
  });
});
```

## Benefits & Trade-offs

### Benefits
- **Confidence**: Reliable software through comprehensive testing
- **Documentation**: Tests serve as living documentation
- **Refactoring Safety**: Change code without fear of breaking functionality
- **Early Bug Detection**: Catch issues before production
- **Design Improvement**: Testing drives better architecture
- **Regression Prevention**: Ensure fixes stay fixed

### Trade-offs
- **Time Investment**: Writing tests takes development time
- **Maintenance Overhead**: Tests need updates when code changes
- **False Confidence**: Poor tests may miss real issues
- **Complexity**: Testing infrastructure adds complexity
- **Performance**: Test suites can slow down development
- **Learning Curve**: Effective testing requires skill

## Common Pitfalls

1. **Testing Implementation Details**: Focus on behavior, not internals
2. **Brittle Tests**: Over-specific assertions that break easily
3. **Slow Tests**: Not isolating units or using real services unnecessarily
4. **Inadequate Test Data**: Not testing edge cases
5. **Ignoring Flaky Tests**: Allowing intermittent failures
6. **Poor Test Organization**: Difficult to find and maintain tests
7. **Missing Test Categories**: Only unit tests without integration/E2E

## Integration with AugmentedClaude Specialists

### Quality Assurance Engineer
- Designs comprehensive test strategies
- Implements automated test suites
- Performs exploratory testing

### Backend Developer
- Writes unit and integration tests
- Implements test fixtures and utilities
- Ensures API contract compliance

### Frontend Developer
- Creates component and UI tests
- Implements E2E test scenarios
- Tests cross-browser compatibility

### DevOps Engineer
- Sets up CI/CD test pipelines
- Manages test environments
- Monitors test metrics and coverage

## Related Patterns

- **Test-Driven Development (TDD)**: Write tests first
- **Behavior-Driven Development (BDD)**: Business-readable tests
- **Mutation Testing**: Test the tests
- **Chaos Engineering**: Testing system resilience
- **A/B Testing**: Testing in production
- **Continuous Testing**: Testing in CI/CD pipeline

## Best Practices

1. **Test Pyramid**
   - Many unit tests (fast, isolated)
   - Some integration tests (component interactions)
   - Few E2E tests (critical user journeys)

2. **Test Naming**
   ```javascript
   // Descriptive test names
   describe('PaymentProcessor', () => {
     describe('processPayment', () => {
       it('should successfully charge valid credit card', () => {});
       it('should decline expired credit card', () => {});
       it('should handle network timeout gracefully', () => {});
     });
   });
   ```

3. **Test Independence**
   ```javascript
   // Each test should be independent
   beforeEach(() => {
     // Fresh setup for each test
     database.clear();
     cache.flush();
   });
   ```

4. **Continuous Integration**
   ```yaml
   # CI pipeline configuration
   name: Test Suite
   on: [push, pull_request]
   
   jobs:
     test:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v2
         - name: Install dependencies
           run: npm ci
         - name: Run unit tests
           run: npm run test:unit
         - name: Run integration tests
           run: npm run test:integration
         - name: Run E2E tests
           run: npm run test:e2e
         - name: Upload coverage
           uses: codecov/codecov-action@v1
   ```

5. **Test Data Management**
   ```javascript
   // Factories for consistent test data
   const factories = {
     user: Factory.define('user')
       .sequence('id')
       .attr('email', () => faker.internet.email())
       .attr('name', () => faker.name.fullName()),
     
     order: Factory.define('order')
       .sequence('id')
       .attr('userId', () => factories.user.build().id)
       .attr('total', () => faker.commerce.price())
   };
   ```

These patterns ensure high-quality software through comprehensive, maintainable, and effective testing strategies.