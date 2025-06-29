# Validation Patterns Documentation

## Overview

This document provides comprehensive validation patterns used throughout the AugmentedClaude system. These patterns ensure data integrity, security, and consistent error handling across all components.

## Core Validation Principles

1. **Fail Fast** - Validate inputs as early as possible
2. **Clear Errors** - Provide descriptive error messages
3. **Type Safety** - Leverage TypeScript for compile-time checks
4. **Sanitization** - Clean inputs before validation
5. **Consistency** - Use standardized patterns across the codebase

## Parameter Validation

### Basic Type Validation

```javascript
// String validation
function validateString(value, fieldName, options = {}) {
  if (typeof value !== 'string') {
    throw new ValidationError(`${fieldName} must be a string`);
  }
  
  if (options.minLength && value.length < options.minLength) {
    throw new ValidationError(`${fieldName} must be at least ${options.minLength} characters`);
  }
  
  if (options.maxLength && value.length > options.maxLength) {
    throw new ValidationError(`${fieldName} must not exceed ${options.maxLength} characters`);
  }
  
  if (options.pattern && !options.pattern.test(value)) {
    throw new ValidationError(`${fieldName} has invalid format`);
  }
  
  return value.trim();
}

// Number validation
function validateNumber(value, fieldName, options = {}) {
  const num = Number(value);
  
  if (isNaN(num)) {
    throw new ValidationError(`${fieldName} must be a valid number`);
  }
  
  if (options.min !== undefined && num < options.min) {
    throw new ValidationError(`${fieldName} must be at least ${options.min}`);
  }
  
  if (options.max !== undefined && num > options.max) {
    throw new ValidationError(`${fieldName} must not exceed ${options.max}`);
  }
  
  if (options.integer && !Number.isInteger(num)) {
    throw new ValidationError(`${fieldName} must be an integer`);
  }
  
  return num;
}
```

### Complex Type Validation

```javascript
// Array validation
function validateArray(value, fieldName, options = {}) {
  if (!Array.isArray(value)) {
    throw new ValidationError(`${fieldName} must be an array`);
  }
  
  if (options.minItems && value.length < options.minItems) {
    throw new ValidationError(`${fieldName} must contain at least ${options.minItems} items`);
  }
  
  if (options.maxItems && value.length > options.maxItems) {
    throw new ValidationError(`${fieldName} must not exceed ${options.maxItems} items`);
  }
  
  if (options.itemValidator) {
    value.forEach((item, index) => {
      try {
        options.itemValidator(item);
      } catch (error) {
        throw new ValidationError(`${fieldName}[${index}]: ${error.message}`);
      }
    });
  }
  
  return value;
}

// Object validation
function validateObject(value, fieldName, schema) {
  if (typeof value !== 'object' || value === null) {
    throw new ValidationError(`${fieldName} must be an object`);
  }
  
  // Required fields
  for (const [key, validator] of Object.entries(schema.required || {})) {
    if (!(key in value)) {
      throw new ValidationError(`${fieldName}.${key} is required`);
    }
    validator(value[key], `${fieldName}.${key}`);
  }
  
  // Optional fields
  for (const [key, validator] of Object.entries(schema.optional || {})) {
    if (key in value) {
      validator(value[key], `${fieldName}.${key}`);
    }
  }
  
  // Strict mode - no extra fields
  if (schema.strict) {
    const allowedKeys = new Set([
      ...Object.keys(schema.required || {}),
      ...Object.keys(schema.optional || {})
    ]);
    
    for (const key of Object.keys(value)) {
      if (!allowedKeys.has(key)) {
        throw new ValidationError(`${fieldName}.${key} is not allowed`);
      }
    }
  }
  
  return value;
}
```

### Command Parameter Validation

```javascript
// Command validation pattern
class CommandValidator {
  constructor(commandName, schema) {
    this.commandName = commandName;
    this.schema = schema;
  }
  
  validate(params) {
    const errors = [];
    const validated = {};
    
    // Validate required parameters
    for (const [param, config] of Object.entries(this.schema.required || {})) {
      try {
        validated[param] = this.validateParam(params[param], param, config);
      } catch (error) {
        errors.push(error.message);
      }
    }
    
    // Validate optional parameters
    for (const [param, config] of Object.entries(this.schema.optional || {})) {
      if (param in params) {
        try {
          validated[param] = this.validateParam(params[param], param, config);
        } catch (error) {
          errors.push(error.message);
        }
      } else if (config.default !== undefined) {
        validated[param] = config.default;
      }
    }
    
    if (errors.length > 0) {
      throw new ValidationError(`Command ${this.commandName} validation failed:\n${errors.join('\n')}`);
    }
    
    return validated;
  }
  
  validateParam(value, name, config) {
    if (value === undefined && config.required) {
      throw new ValidationError(`Parameter '${name}' is required`);
    }
    
    if (value === undefined) {
      return config.default;
    }
    
    // Type validation
    switch (config.type) {
      case 'string':
        return validateString(value, name, config);
      case 'number':
        return validateNumber(value, name, config);
      case 'boolean':
        return Boolean(value);
      case 'array':
        return validateArray(value, name, config);
      case 'object':
        return validateObject(value, name, config.schema);
      default:
        if (config.validator) {
          return config.validator(value, name);
        }
        return value;
    }
  }
}
```

## Input Sanitization

### String Sanitization

```javascript
// Basic string sanitization
function sanitizeString(input, options = {}) {
  if (typeof input !== 'string') {
    return '';
  }
  
  let sanitized = input;
  
  // Trim whitespace
  if (options.trim !== false) {
    sanitized = sanitized.trim();
  }
  
  // Remove control characters
  if (options.removeControl !== false) {
    sanitized = sanitized.replace(/[\x00-\x1F\x7F]/g, '');
  }
  
  // Escape HTML
  if (options.escapeHtml) {
    sanitized = sanitized
      .replace(/&/g, '&amp;')
      .replace(/</g, '&lt;')
      .replace(/>/g, '&gt;')
      .replace(/"/g, '&quot;')
      .replace(/'/g, '&#x27;');
  }
  
  // Remove or escape special characters
  if (options.alphanumericOnly) {
    sanitized = sanitized.replace(/[^a-zA-Z0-9]/g, '');
  } else if (options.allowedChars) {
    const pattern = new RegExp(`[^${options.allowedChars}]`, 'g');
    sanitized = sanitized.replace(pattern, '');
  }
  
  // Length limits
  if (options.maxLength) {
    sanitized = sanitized.substring(0, options.maxLength);
  }
  
  return sanitized;
}

// SQL injection prevention
function sanitizeSQLIdentifier(identifier) {
  // Only allow alphanumeric and underscore
  const sanitized = identifier.replace(/[^a-zA-Z0-9_]/g, '');
  
  // Must start with letter or underscore
  if (!/^[a-zA-Z_]/.test(sanitized)) {
    throw new ValidationError('Invalid SQL identifier');
  }
  
  // Length check
  if (sanitized.length === 0 || sanitized.length > 64) {
    throw new ValidationError('SQL identifier length must be 1-64 characters');
  }
  
  return sanitized;
}

// Command injection prevention
function sanitizeShellArg(arg) {
  if (typeof arg !== 'string') {
    throw new ValidationError('Shell argument must be a string');
  }
  
  // Escape shell special characters
  return arg.replace(/(["\s'$`\\])/g, '\\$1');
}
```

### Array and Object Sanitization

```javascript
// Array sanitization
function sanitizeArray(input, itemSanitizer) {
  if (!Array.isArray(input)) {
    return [];
  }
  
  return input
    .filter(item => item !== null && item !== undefined)
    .map(item => itemSanitizer ? itemSanitizer(item) : item);
}

// Object sanitization
function sanitizeObject(input, schema) {
  if (typeof input !== 'object' || input === null) {
    return {};
  }
  
  const sanitized = {};
  
  for (const [key, sanitizer] of Object.entries(schema)) {
    if (key in input) {
      sanitized[key] = sanitizer(input[key]);
    }
  }
  
  return sanitized;
}

// Deep sanitization
function deepSanitize(input, options = {}) {
  if (input === null || input === undefined) {
    return input;
  }
  
  if (typeof input === 'string') {
    return sanitizeString(input, options.string || {});
  }
  
  if (Array.isArray(input)) {
    return input.map(item => deepSanitize(item, options));
  }
  
  if (typeof input === 'object') {
    const sanitized = {};
    for (const [key, value] of Object.entries(input)) {
      const sanitizedKey = sanitizeString(key, { alphanumericOnly: true });
      sanitized[sanitizedKey] = deepSanitize(value, options);
    }
    return sanitized;
  }
  
  return input;
}
```

## File Path Validation

### Path Security

```javascript
// Secure file path validation
function validateFilePath(path, options = {}) {
  if (typeof path !== 'string' || path.length === 0) {
    throw new ValidationError('Path must be a non-empty string');
  }
  
  // Normalize path
  const normalized = path.normalize(path);
  
  // Check for path traversal
  if (normalized.includes('..')) {
    throw new ValidationError('Path traversal detected');
  }
  
  // Check for absolute path when not allowed
  if (!options.allowAbsolute && path.isAbsolute(normalized)) {
    throw new ValidationError('Absolute paths not allowed');
  }
  
  // Check for required base path
  if (options.basePath) {
    const resolved = path.resolve(options.basePath, normalized);
    if (!resolved.startsWith(path.resolve(options.basePath))) {
      throw new ValidationError('Path escapes base directory');
    }
  }
  
  // Validate file extension
  if (options.allowedExtensions) {
    const ext = path.extname(normalized).toLowerCase();
    if (!options.allowedExtensions.includes(ext)) {
      throw new ValidationError(`File extension '${ext}' not allowed`);
    }
  }
  
  // Check path length
  if (normalized.length > (options.maxLength || 255)) {
    throw new ValidationError('Path too long');
  }
  
  // Check for invalid characters
  const invalidChars = options.invalidChars || /[\x00-\x1f<>:"|?*]/;
  if (invalidChars.test(normalized)) {
    throw new ValidationError('Path contains invalid characters');
  }
  
  return normalized;
}

// Safe path joining
function safeJoin(basePath, ...parts) {
  const joined = path.join(basePath, ...parts);
  const resolved = path.resolve(joined);
  const baseResolved = path.resolve(basePath);
  
  if (!resolved.startsWith(baseResolved)) {
    throw new ValidationError('Path traversal detected in join operation');
  }
  
  return resolved;
}

// Directory validation
function validateDirectory(dirPath, options = {}) {
  const validated = validateFilePath(dirPath, { ...options, allowAbsolute: true });
  
  if (options.mustExist) {
    if (!fs.existsSync(validated)) {
      throw new ValidationError(`Directory does not exist: ${validated}`);
    }
    
    const stats = fs.statSync(validated);
    if (!stats.isDirectory()) {
      throw new ValidationError(`Path is not a directory: ${validated}`);
    }
  }
  
  if (options.writable) {
    try {
      fs.accessSync(validated, fs.constants.W_OK);
    } catch {
      throw new ValidationError(`Directory is not writable: ${validated}`);
    }
  }
  
  return validated;
}
```

## Type Checking Patterns

### TypeScript Integration

```typescript
// Type guards
function isString(value: unknown): value is string {
  return typeof value === 'string';
}

function isNumber(value: unknown): value is number {
  return typeof value === 'number' && !isNaN(value);
}

function isArray<T>(value: unknown, itemGuard?: (item: unknown) => item is T): value is T[] {
  if (!Array.isArray(value)) return false;
  
  if (itemGuard) {
    return value.every(itemGuard);
  }
  
  return true;
}

// Generic validator type
type Validator<T> = (value: unknown) => T;

// Schema-based validation
interface Schema {
  [key: string]: Validator<any>;
}

function createValidator<T>(schema: Schema): Validator<T> {
  return (value: unknown): T => {
    if (typeof value !== 'object' || value === null) {
      throw new ValidationError('Value must be an object');
    }
    
    const result = {} as T;
    
    for (const [key, validator] of Object.entries(schema)) {
      result[key as keyof T] = validator((value as any)[key]);
    }
    
    return result;
  };
}

// Branded types for extra safety
type UserId = string & { __brand: 'UserId' };
type Email = string & { __brand: 'Email' };

function validateUserId(id: string): UserId {
  if (!/^[a-zA-Z0-9]{8,32}$/.test(id)) {
    throw new ValidationError('Invalid user ID format');
  }
  return id as UserId;
}

function validateEmail(email: string): Email {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    throw new ValidationError('Invalid email format');
  }
  return email.toLowerCase() as Email;
}
```

### Runtime Type Checking

```javascript
// Class-based validation
class ValidatedModel {
  constructor(data) {
    this.validate(data);
    Object.assign(this, data);
  }
  
  validate(data) {
    const schema = this.constructor.schema;
    if (!schema) {
      throw new Error('No validation schema defined');
    }
    
    for (const [field, rules] of Object.entries(schema)) {
      this.validateField(data[field], field, rules);
    }
  }
  
  validateField(value, field, rules) {
    // Required check
    if (rules.required && (value === undefined || value === null)) {
      throw new ValidationError(`${field} is required`);
    }
    
    // Type check
    if (value !== undefined && value !== null) {
      const actualType = Array.isArray(value) ? 'array' : typeof value;
      if (actualType !== rules.type) {
        throw new ValidationError(`${field} must be of type ${rules.type}`);
      }
      
      // Custom validator
      if (rules.validator && !rules.validator(value)) {
        throw new ValidationError(`${field} validation failed`);
      }
    }
  }
}

// Usage example
class User extends ValidatedModel {
  static schema = {
    id: { type: 'string', required: true },
    email: { type: 'string', required: true, validator: (v) => /^[^\s@]+@[^\s@]+$/.test(v) },
    age: { type: 'number', required: false, validator: (v) => v >= 0 && v <= 150 }
  };
}
```

## Error Message Formatting

### Consistent Error Messages

```javascript
// Error message builder
class ValidationErrorBuilder {
  constructor(context) {
    this.context = context;
    this.errors = [];
  }
  
  addError(field, message, code = null) {
    this.errors.push({
      field,
      message,
      code,
      context: this.context
    });
    return this;
  }
  
  hasErrors() {
    return this.errors.length > 0;
  }
  
  build() {
    if (!this.hasErrors()) {
      return null;
    }
    
    const error = new ValidationError(this.formatMessage());
    error.errors = this.errors;
    return error;
  }
  
  formatMessage() {
    if (this.errors.length === 1) {
      return this.errors[0].message;
    }
    
    return `Validation failed with ${this.errors.length} errors:\n` +
      this.errors.map(e => `  - ${e.field}: ${e.message}`).join('\n');
  }
}

// User-friendly error messages
const ERROR_MESSAGES = {
  REQUIRED: (field) => `${humanize(field)} is required`,
  MIN_LENGTH: (field, min) => `${humanize(field)} must be at least ${min} characters`,
  MAX_LENGTH: (field, max) => `${humanize(field)} must not exceed ${max} characters`,
  INVALID_FORMAT: (field) => `${humanize(field)} has invalid format`,
  OUT_OF_RANGE: (field, min, max) => `${humanize(field)} must be between ${min} and ${max}`,
  INVALID_TYPE: (field, expected) => `${humanize(field)} must be a ${expected}`,
  UNIQUE: (field) => `${humanize(field)} already exists`,
  INVALID_OPTION: (field, options) => `${humanize(field)} must be one of: ${options.join(', ')}`
};

function humanize(field) {
  return field
    .replace(/([A-Z])/g, ' $1')
    .replace(/_/g, ' ')
    .toLowerCase()
    .trim()
    .replace(/^\w/, c => c.toUpperCase());
}
```

### Structured Error Responses

```javascript
// API error response formatter
class APIErrorFormatter {
  static format(error, options = {}) {
    const response = {
      error: {
        type: error.constructor.name,
        message: error.message,
        timestamp: new Date().toISOString()
      }
    };
    
    // Add validation errors
    if (error.errors) {
      response.error.validation = error.errors.map(e => ({
        field: e.field,
        message: e.message,
        code: e.code
      }));
    }
    
    // Add debug info in development
    if (options.debug || process.env.NODE_ENV === 'development') {
      response.error.stack = error.stack;
      response.error.context = error.context;
    }
    
    // Add request ID for tracking
    if (options.requestId) {
      response.error.requestId = options.requestId;
    }
    
    return response;
  }
  
  static formatFieldErrors(errors) {
    const fieldErrors = {};
    
    for (const error of errors) {
      if (!fieldErrors[error.field]) {
        fieldErrors[error.field] = [];
      }
      fieldErrors[error.field].push(error.message);
    }
    
    return fieldErrors;
  }
}

// CLI error formatter
class CLIErrorFormatter {
  static format(error) {
    const lines = [];
    
    // Main error message
    lines.push(`❌ ${error.message}`);
    
    // Validation details
    if (error.errors && error.errors.length > 0) {
      lines.push('\nValidation errors:');
      for (const e of error.errors) {
        lines.push(`  • ${e.field}: ${e.message}`);
      }
    }
    
    // Suggestions
    if (error.suggestions) {
      lines.push('\n💡 Suggestions:');
      for (const suggestion of error.suggestions) {
        lines.push(`  • ${suggestion}`);
      }
    }
    
    // Help reference
    if (error.helpUrl) {
      lines.push(`\nFor more information: ${error.helpUrl}`);
    }
    
    return lines.join('\n');
  }
}
```

## Validation Middleware

### Express Middleware Pattern

```javascript
// Request validation middleware
function validateRequest(schema) {
  return async (req, res, next) => {
    try {
      // Validate different parts of request
      const validated = {};
      
      if (schema.params) {
        validated.params = await validateObject(req.params, 'params', schema.params);
      }
      
      if (schema.query) {
        validated.query = await validateObject(req.query, 'query', schema.query);
      }
      
      if (schema.body) {
        validated.body = await validateObject(req.body, 'body', schema.body);
      }
      
      if (schema.headers) {
        validated.headers = await validateObject(req.headers, 'headers', schema.headers);
      }
      
      // Attach validated data
      req.validated = validated;
      next();
    } catch (error) {
      if (error instanceof ValidationError) {
        res.status(400).json(APIErrorFormatter.format(error));
      } else {
        next(error);
      }
    }
  };
}

// Usage
router.post('/users',
  validateRequest({
    body: {
      required: {
        email: (v) => validateEmail(v),
        password: (v) => validateString(v, 'password', { minLength: 8 }),
        username: (v) => validateString(v, 'username', { pattern: /^[a-zA-Z0-9_]+$/ })
      },
      optional: {
        name: (v) => validateString(v, 'name', { maxLength: 100 }),
        age: (v) => validateNumber(v, 'age', { min: 0, max: 150 })
      }
    }
  }),
  async (req, res) => {
    // Use req.validated.body
  }
);
```

### Command Line Validation

```javascript
// CLI command validation
class CLIValidator {
  constructor(program) {
    this.program = program;
  }
  
  validateCommand(command, args, options) {
    const schema = this.getCommandSchema(command);
    if (!schema) {
      throw new ValidationError(`Unknown command: ${command}`);
    }
    
    const errors = new ValidationErrorBuilder(command);
    
    // Validate arguments
    if (schema.args) {
      for (let i = 0; i < schema.args.length; i++) {
        const argSchema = schema.args[i];
        const value = args[i];
        
        try {
          if (argSchema.required && value === undefined) {
            throw new ValidationError(`Argument is required`);
          }
          
          if (value !== undefined) {
            args[i] = argSchema.validator(value);
          }
        } catch (error) {
          errors.addError(`arg[${i}]`, error.message);
        }
      }
    }
    
    // Validate options
    if (schema.options) {
      for (const [name, optSchema] of Object.entries(schema.options)) {
        const value = options[name];
        
        try {
          if (optSchema.required && value === undefined) {
            throw new ValidationError(`Option is required`);
          }
          
          if (value !== undefined) {
            options[name] = optSchema.validator(value);
          } else if (optSchema.default !== undefined) {
            options[name] = optSchema.default;
          }
        } catch (error) {
          errors.addError(`--${name}`, error.message);
        }
      }
    }
    
    if (errors.hasErrors()) {
      throw errors.build();
    }
    
    return { args, options };
  }
}
```

## Advanced Patterns

### Async Validation

```javascript
// Async validator with caching
class AsyncValidator {
  constructor(options = {}) {
    this.cache = new Map();
    this.cacheTTL = options.cacheTTL || 60000; // 1 minute
  }
  
  async validateAsync(value, validators) {
    const results = await Promise.all(
      validators.map(validator => this.runValidator(value, validator))
    );
    
    const errors = results.filter(r => r.error);
    if (errors.length > 0) {
      throw new ValidationError(errors.map(e => e.error).join(', '));
    }
    
    return value;
  }
  
  async runValidator(value, validator) {
    // Check cache
    const cacheKey = `${validator.name}:${JSON.stringify(value)}`;
    const cached = this.cache.get(cacheKey);
    
    if (cached && Date.now() - cached.timestamp < this.cacheTTL) {
      return cached.result;
    }
    
    try {
      await validator.validate(value);
      const result = { error: null };
      this.cache.set(cacheKey, { result, timestamp: Date.now() });
      return result;
    } catch (error) {
      const result = { error: error.message };
      this.cache.set(cacheKey, { result, timestamp: Date.now() });
      return result;
    }
  }
}

// Database uniqueness validator
async function validateUnique(value, field, model) {
  const existing = await model.findOne({ [field]: value });
  if (existing) {
    throw new ValidationError(`${field} already exists`);
  }
  return value;
}

// External API validation
async function validateWithAPI(value, endpoint) {
  try {
    const response = await fetch(endpoint, {
      method: 'POST',
      body: JSON.stringify({ value }),
      headers: { 'Content-Type': 'application/json' }
    });
    
    const result = await response.json();
    
    if (!result.valid) {
      throw new ValidationError(result.message || 'External validation failed');
    }
    
    return value;
  } catch (error) {
    if (error instanceof ValidationError) {
      throw error;
    }
    throw new ValidationError('External validation service unavailable');
  }
}
```

### Conditional Validation

```javascript
// Conditional validation rules
class ConditionalValidator {
  constructor(rules) {
    this.rules = rules;
  }
  
  validate(data) {
    const errors = new ValidationErrorBuilder('conditional');
    
    for (const rule of this.rules) {
      if (this.evaluateCondition(rule.when, data)) {
        try {
          this.applyValidation(rule.then, data);
        } catch (error) {
          errors.addError(rule.field || 'conditional', error.message);
        }
      } else if (rule.else) {
        try {
          this.applyValidation(rule.else, data);
        } catch (error) {
          errors.addError(rule.field || 'conditional', error.message);
        }
      }
    }
    
    if (errors.hasErrors()) {
      throw errors.build();
    }
  }
  
  evaluateCondition(condition, data) {
    if (typeof condition === 'function') {
      return condition(data);
    }
    
    // Simple field equality check
    if (condition.field && condition.equals !== undefined) {
      return data[condition.field] === condition.equals;
    }
    
    // Field existence check
    if (condition.field && condition.exists !== undefined) {
      return (condition.field in data) === condition.exists;
    }
    
    return false;
  }
  
  applyValidation(validation, data) {
    if (typeof validation === 'function') {
      validation(data);
    } else if (validation.field && validation.validator) {
      validation.validator(data[validation.field], validation.field);
    }
  }
}

// Usage
const conditionalValidator = new ConditionalValidator([
  {
    when: { field: 'type', equals: 'business' },
    then: {
      field: 'taxId',
      validator: (v) => validateString(v, 'taxId', { pattern: /^\d{9}$/ })
    }
  },
  {
    when: (data) => data.age && data.age < 18,
    then: {
      field: 'parentConsent',
      validator: (v) => {
        if (!v) throw new ValidationError('Parent consent required for minors');
      }
    }
  }
]);
```

## Testing Validation

### Unit Testing Patterns

```javascript
// Validation test helpers
const ValidationTester = {
  // Test valid inputs
  async testValid(validator, inputs, description = '') {
    for (const input of inputs) {
      try {
        await validator(input.value);
      } catch (error) {
        throw new Error(`${description} failed for ${JSON.stringify(input)}: ${error.message}`);
      }
    }
  },
  
  // Test invalid inputs
  async testInvalid(validator, inputs, description = '') {
    for (const input of inputs) {
      try {
        await validator(input.value);
        throw new Error(`${description} should have failed for ${JSON.stringify(input)}`);
      } catch (error) {
        if (!(error instanceof ValidationError)) {
          throw error;
        }
        
        if (input.expectedError && !error.message.includes(input.expectedError)) {
          throw new Error(`Expected error containing "${input.expectedError}", got "${error.message}"`);
        }
      }
    }
  },
  
  // Test edge cases
  testEdgeCases(validator) {
    const edgeCases = [
      null,
      undefined,
      '',
      0,
      false,
      [],
      {},
      NaN,
      Infinity,
      -Infinity
    ];
    
    return this.testInvalid(validator, edgeCases.map(v => ({ value: v })), 'Edge case');
  }
};

// Example test suite
describe('Email Validation', () => {
  const validator = (v) => validateEmail(v);
  
  test('Valid emails', async () => {
    await ValidationTester.testValid(validator, [
      { value: 'user@example.com' },
      { value: 'test.user+tag@example.co.uk' },
      { value: 'admin@localhost' }
    ]);
  });
  
  test('Invalid emails', async () => {
    await ValidationTester.testInvalid(validator, [
      { value: 'invalid.email', expectedError: 'Invalid email format' },
      { value: '@example.com', expectedError: 'Invalid email format' },
      { value: 'user@', expectedError: 'Invalid email format' }
    ]);
  });
  
  test('Edge cases', async () => {
    await ValidationTester.testEdgeCases(validator);
  });
});
```

## Performance Considerations

### Validation Optimization

```javascript
// Memoized validator
function memoize(validator, options = {}) {
  const cache = new Map();
  const maxSize = options.maxSize || 1000;
  
  return function memoizedValidator(value, ...args) {
    const key = JSON.stringify([value, ...args]);
    
    if (cache.has(key)) {
      return cache.get(key);
    }
    
    try {
      const result = validator(value, ...args);
      
      // Limit cache size
      if (cache.size >= maxSize) {
        const firstKey = cache.keys().next().value;
        cache.delete(firstKey);
      }
      
      cache.set(key, result);
      return result;
    } catch (error) {
      // Don't cache errors
      throw error;
    }
  };
}

// Lazy validation for large objects
class LazyValidator {
  constructor(schema) {
    this.schema = schema;
    this.validated = new WeakMap();
  }
  
  validate(obj, fields = null) {
    // Return cached if fully validated
    if (!fields && this.validated.has(obj)) {
      return this.validated.get(obj);
    }
    
    const toValidate = fields || Object.keys(this.schema);
    const result = {};
    
    for (const field of toValidate) {
      if (field in this.schema) {
        result[field] = this.schema[field](obj[field], field);
      }
    }
    
    // Cache if full validation
    if (!fields) {
      this.validated.set(obj, result);
    }
    
    return result;
  }
}
```

## Summary

These validation patterns provide a comprehensive foundation for building robust, secure applications. Key principles:

1. **Validate Early** - Check inputs at system boundaries
2. **Fail Clearly** - Provide actionable error messages
3. **Sanitize Inputs** - Clean data before processing
4. **Type Safety** - Leverage TypeScript where possible
5. **Performance** - Cache validation results when appropriate
6. **Consistency** - Use standard patterns throughout the codebase

By following these patterns, you ensure data integrity, improve security, and create a better developer experience with clear, predictable validation behavior.