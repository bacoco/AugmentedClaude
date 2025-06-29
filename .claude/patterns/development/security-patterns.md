# Security Patterns

## Pattern Name & Overview

**Security Patterns** are proven design solutions that address common security challenges in software development. These patterns help protect applications from threats, ensure data confidentiality, maintain system integrity, and implement proper authentication and authorization mechanisms.

## Problem Context (When to Use)

Apply security patterns when:
- Building applications that handle sensitive data
- Implementing user authentication and authorization
- Protecting against common vulnerabilities (OWASP Top 10)
- Ensuring compliance with security standards (PCI-DSS, GDPR, HIPAA)
- Preventing data breaches and unauthorized access
- Implementing secure communication channels
- Building multi-tenant applications

## Solution

Security patterns are organized into several categories:

1. **Authentication Patterns**: Verifying user identity
2. **Authorization Patterns**: Controlling access to resources
3. **Data Protection Patterns**: Encrypting and securing data
4. **Input Validation Patterns**: Preventing injection attacks
5. **Session Management Patterns**: Secure session handling
6. **API Security Patterns**: Protecting API endpoints
7. **Infrastructure Security Patterns**: Securing the deployment environment

## Implementation Guidelines

### 1. Authentication Patterns

#### Multi-Factor Authentication (MFA)
```javascript
// MFA implementation with TOTP
const speakeasy = require('speakeasy');
const QRCode = require('qrcode');

class MFAService {
  // Generate secret for user
  async setupMFA(userId) {
    const secret = speakeasy.generateSecret({
      name: `MyApp (${userId})`,
      length: 32
    });

    // Store encrypted secret
    await this.userRepository.update(userId, {
      mfaSecret: this.encrypt(secret.base32),
      mfaEnabled: false
    });

    // Generate QR code
    const qrCodeUrl = await QRCode.toDataURL(secret.otpauth_url);
    
    return {
      secret: secret.base32,
      qrCode: qrCodeUrl,
      backupCodes: await this.generateBackupCodes(userId)
    };
  }

  // Verify TOTP token
  async verifyToken(userId, token) {
    const user = await this.userRepository.findById(userId);
    const secret = this.decrypt(user.mfaSecret);

    const verified = speakeasy.totp.verify({
      secret,
      encoding: 'base32',
      token,
      window: 2 // Allow 2 intervals before/after
    });

    if (!verified) {
      // Check backup codes
      return await this.verifyBackupCode(userId, token);
    }

    return verified;
  }

  // Backup codes for account recovery
  async generateBackupCodes(userId) {
    const codes = [];
    for (let i = 0; i < 10; i++) {
      codes.push(crypto.randomBytes(4).toString('hex'));
    }

    await this.userRepository.update(userId, {
      backupCodes: codes.map(code => this.hashPassword(code))
    });

    return codes;
  }
}
```

#### JWT Authentication with Refresh Tokens
```javascript
// Secure JWT implementation
const jwt = require('jsonwebtoken');
const crypto = require('crypto');

class AuthService {
  constructor() {
    this.accessTokenSecret = process.env.JWT_ACCESS_SECRET;
    this.refreshTokenSecret = process.env.JWT_REFRESH_SECRET;
    this.accessTokenExpiry = '15m';
    this.refreshTokenExpiry = '7d';
  }

  async login(email, password) {
    const user = await this.userRepository.findByEmail(email);
    
    if (!user || !await this.verifyPassword(password, user.passwordHash)) {
      // Prevent timing attacks
      await this.simulateHashDelay();
      throw new UnauthorizedError('Invalid credentials');
    }

    // Check account status
    if (user.lockedUntil && user.lockedUntil > new Date()) {
      throw new UnauthorizedError('Account temporarily locked');
    }

    // Generate tokens
    const { accessToken, refreshToken } = await this.generateTokenPair(user);

    // Store refresh token
    await this.storeRefreshToken(user.id, refreshToken);

    // Reset failed attempts
    await this.resetFailedAttempts(user.id);

    return {
      accessToken,
      refreshToken,
      expiresIn: 900 // 15 minutes
    };
  }

  async generateTokenPair(user) {
    const tokenId = crypto.randomUUID();
    
    const payload = {
      sub: user.id,
      email: user.email,
      roles: user.roles,
      jti: tokenId
    };

    const accessToken = jwt.sign(
      payload,
      this.accessTokenSecret,
      { 
        expiresIn: this.accessTokenExpiry,
        issuer: 'myapp.com',
        audience: 'myapp.com'
      }
    );

    const refreshToken = jwt.sign(
      { sub: user.id, jti: tokenId },
      this.refreshTokenSecret,
      { expiresIn: this.refreshTokenExpiry }
    );

    return { accessToken, refreshToken };
  }

  async refreshAccessToken(refreshToken) {
    try {
      const decoded = jwt.verify(refreshToken, this.refreshTokenSecret);
      
      // Check if refresh token is in database and not revoked
      const storedToken = await this.refreshTokenRepository.findByToken(
        this.hashToken(refreshToken)
      );

      if (!storedToken || storedToken.revoked) {
        throw new UnauthorizedError('Invalid refresh token');
      }

      // Check if token belongs to user
      const user = await this.userRepository.findById(decoded.sub);
      if (!user) {
        throw new UnauthorizedError('User not found');
      }

      // Generate new access token
      const newTokens = await this.generateTokenPair(user);

      // Rotate refresh token
      await this.revokeRefreshToken(refreshToken);
      await this.storeRefreshToken(user.id, newTokens.refreshToken);

      return newTokens;
    } catch (error) {
      if (error.name === 'TokenExpiredError') {
        throw new UnauthorizedError('Refresh token expired');
      }
      throw error;
    }
  }

  // Middleware for protecting routes
  authenticate(options = {}) {
    return async (req, res, next) => {
      try {
        const token = this.extractToken(req);
        if (!token) {
          throw new UnauthorizedError('No token provided');
        }

        const decoded = jwt.verify(token, this.accessTokenSecret);

        // Check token blacklist (for logout)
        if (await this.isTokenBlacklisted(decoded.jti)) {
          throw new UnauthorizedError('Token revoked');
        }

        // Attach user to request
        req.user = {
          id: decoded.sub,
          email: decoded.email,
          roles: decoded.roles
        };

        next();
      } catch (error) {
        next(new UnauthorizedError('Invalid token'));
      }
    };
  }
}
```

### 2. Authorization Patterns

#### Role-Based Access Control (RBAC)
```javascript
// RBAC implementation
class RBACService {
  constructor() {
    this.permissions = new Map();
    this.roleHierarchy = new Map();
  }

  // Define permissions
  definePermissions() {
    // Resource-based permissions
    this.addPermission('user:read', 'Read user data');
    this.addPermission('user:write', 'Modify user data');
    this.addPermission('user:delete', 'Delete users');
    this.addPermission('admin:panel', 'Access admin panel');
    
    // Define roles
    this.defineRole('guest', []);
    this.defineRole('user', ['user:read']);
    this.defineRole('moderator', ['user:read', 'user:write']);
    this.defineRole('admin', ['user:read', 'user:write', 'user:delete', 'admin:panel']);
    
    // Role hierarchy
    this.setRoleHierarchy('admin', ['moderator', 'user']);
    this.setRoleHierarchy('moderator', ['user']);
  }

  // Check permission
  async hasPermission(userId, permission) {
    const user = await this.userRepository.findById(userId);
    const userRoles = user.roles || [];
    
    // Check direct permissions
    for (const role of userRoles) {
      if (await this.roleHasPermission(role, permission)) {
        return true;
      }
    }

    return false;
  }

  // Middleware for route protection
  requirePermission(permission) {
    return async (req, res, next) => {
      if (!req.user) {
        return res.status(401).json({ error: 'Unauthorized' });
      }

      const hasPermission = await this.hasPermission(req.user.id, permission);
      
      if (!hasPermission) {
        return res.status(403).json({ 
          error: 'Forbidden',
          message: `Missing required permission: ${permission}`
        });
      }

      next();
    };
  }

  // Dynamic permission check
  async canAccessResource(userId, resourceType, resourceId, action) {
    // Check ownership
    if (resourceType === 'user' && resourceId === userId && action === 'read') {
      return true; // Users can read their own data
    }

    // Check role-based permissions
    const permission = `${resourceType}:${action}`;
    return await this.hasPermission(userId, permission);
  }
}

// Usage in routes
router.get('/users', 
  auth.authenticate(),
  rbac.requirePermission('user:read'),
  async (req, res) => {
    const users = await userService.getAllUsers();
    res.json(users);
  }
);

router.delete('/users/:id',
  auth.authenticate(),
  rbac.requirePermission('user:delete'),
  async (req, res) => {
    await userService.deleteUser(req.params.id);
    res.status(204).send();
  }
);
```

#### Attribute-Based Access Control (ABAC)
```javascript
// ABAC with policy engine
class ABACService {
  constructor() {
    this.policies = [];
  }

  // Define policies
  definePolicies() {
    // Users can read their own profile
    this.addPolicy({
      effect: 'allow',
      action: 'read',
      resource: 'user:*',
      condition: (subject, resource) => {
        return subject.id === resource.id;
      }
    });

    // Managers can read their team members' data
    this.addPolicy({
      effect: 'allow',
      action: ['read', 'update'],
      resource: 'user:*',
      condition: (subject, resource) => {
        return subject.role === 'manager' && 
               resource.teamId === subject.teamId;
      }
    });

    // Time-based access
    this.addPolicy({
      effect: 'allow',
      action: 'access',
      resource: 'report:financial',
      condition: (subject, resource, context) => {
        const now = new Date();
        const businessHours = now.getHours() >= 9 && now.getHours() < 17;
        return subject.department === 'finance' && businessHours;
      }
    });
  }

  // Evaluate access
  async evaluate(subject, action, resource, context = {}) {
    const applicablePolicies = this.policies.filter(policy => {
      const actionMatch = Array.isArray(policy.action) 
        ? policy.action.includes(action)
        : policy.action === action || policy.action === '*';
      
      const resourceMatch = this.matchResource(policy.resource, resource);
      
      return actionMatch && resourceMatch;
    });

    // Evaluate conditions
    for (const policy of applicablePolicies) {
      if (policy.condition) {
        const conditionMet = await policy.condition(subject, resource, context);
        if (conditionMet && policy.effect === 'allow') {
          return true;
        }
        if (conditionMet && policy.effect === 'deny') {
          return false;
        }
      }
    }

    return false; // Default deny
  }
}
```

### 3. Data Protection Patterns

#### Encryption at Rest and in Transit
```javascript
// Comprehensive encryption service
const crypto = require('crypto');

class EncryptionService {
  constructor() {
    this.algorithm = 'aes-256-gcm';
    this.keyDerivationIterations = 100000;
  }

  // Field-level encryption for sensitive data
  encryptField(data, masterKey) {
    // Generate unique key for this field
    const salt = crypto.randomBytes(32);
    const key = crypto.pbkdf2Sync(masterKey, salt, this.keyDerivationIterations, 32, 'sha256');
    
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipheriv(this.algorithm, key, iv);
    
    const encrypted = Buffer.concat([
      cipher.update(JSON.stringify(data), 'utf8'),
      cipher.final()
    ]);
    
    const tag = cipher.getAuthTag();
    
    return {
      encrypted: encrypted.toString('base64'),
      salt: salt.toString('base64'),
      iv: iv.toString('base64'),
      tag: tag.toString('base64')
    };
  }

  decryptField(encryptedData, masterKey) {
    const salt = Buffer.from(encryptedData.salt, 'base64');
    const key = crypto.pbkdf2Sync(masterKey, salt, this.keyDerivationIterations, 32, 'sha256');
    
    const decipher = crypto.createDecipheriv(
      this.algorithm,
      key,
      Buffer.from(encryptedData.iv, 'base64')
    );
    
    decipher.setAuthTag(Buffer.from(encryptedData.tag, 'base64'));
    
    const decrypted = Buffer.concat([
      decipher.update(Buffer.from(encryptedData.encrypted, 'base64')),
      decipher.final()
    ]);
    
    return JSON.parse(decrypted.toString('utf8'));
  }

  // Searchable encryption for database queries
  async createSearchableHash(value, salt) {
    // Use deterministic encryption for searchability
    const hash = crypto.createHmac('sha256', salt)
      .update(value.toLowerCase().trim())
      .digest('hex');
    
    return hash;
  }

  // Key rotation
  async rotateEncryptionKeys(oldKey, newKey) {
    const records = await this.repository.findAllEncrypted();
    
    for (const record of records) {
      // Decrypt with old key
      const decrypted = this.decryptField(record.encryptedData, oldKey);
      
      // Re-encrypt with new key
      const reencrypted = this.encryptField(decrypted, newKey);
      
      await this.repository.update(record.id, {
        encryptedData: reencrypted,
        keyVersion: 2
      });
    }
  }
}

// Database model with encryption
class UserModel {
  async create(userData) {
    const encryptionKey = await this.getEncryptionKey();
    
    // Encrypt sensitive fields
    const encryptedSSN = this.encryptionService.encryptField(
      userData.ssn,
      encryptionKey
    );
    
    // Create searchable hash for encrypted email
    const emailHash = await this.encryptionService.createSearchableHash(
      userData.email,
      process.env.SEARCH_SALT
    );
    
    return await this.db.insert('users', {
      email: userData.email, // Store plaintext for login
      emailHash, // For duplicate checking
      encryptedSSN,
      createdAt: new Date()
    });
  }
}
```

### 4. Input Validation Patterns

#### Comprehensive Input Sanitization
```javascript
// Input validation and sanitization service
const validator = require('validator');
const DOMPurify = require('isomorphic-dompurify');

class InputValidationService {
  // SQL Injection prevention
  validateSQLInput(input) {
    // Whitelist allowed characters
    const sqlPattern = /^[a-zA-Z0-9\s\-_@.]+$/;
    
    if (!sqlPattern.test(input)) {
      throw new ValidationError('Invalid characters in input');
    }
    
    // Check for SQL keywords
    const sqlKeywords = ['SELECT', 'INSERT', 'UPDATE', 'DELETE', 'DROP', 'UNION', 'OR', 'AND'];
    const upperInput = input.toUpperCase();
    
    for (const keyword of sqlKeywords) {
      if (upperInput.includes(keyword)) {
        throw new ValidationError('SQL keywords not allowed');
      }
    }
    
    return input;
  }

  // XSS Prevention
  sanitizeHTML(html) {
    // Configure DOMPurify
    const config = {
      ALLOWED_TAGS: ['b', 'i', 'em', 'strong', 'a', 'p', 'br'],
      ALLOWED_ATTR: ['href', 'title'],
      ALLOWED_PROTOCOLS: ['http', 'https', 'mailto']
    };
    
    return DOMPurify.sanitize(html, config);
  }

  // Command injection prevention
  validateFilePath(path) {
    // Remove any path traversal attempts
    const sanitized = path.replace(/\.\./g, '').replace(/[^\w\s\-_.]/g, '');
    
    // Ensure path is within allowed directory
    const normalizedPath = path.normalize(sanitized);
    const allowedBase = '/app/uploads/';
    
    if (!normalizedPath.startsWith(allowedBase)) {
      throw new ValidationError('Invalid file path');
    }
    
    return normalizedPath;
  }

  // Comprehensive validation middleware
  validateRequest(schema) {
    return (req, res, next) => {
      const errors = [];
      
      // Validate body
      if (schema.body) {
        const bodyErrors = this.validateObject(req.body, schema.body);
        errors.push(...bodyErrors);
      }
      
      // Validate query parameters
      if (schema.query) {
        const queryErrors = this.validateObject(req.query, schema.query);
        errors.push(...queryErrors);
      }
      
      // Validate path parameters
      if (schema.params) {
        const paramErrors = this.validateObject(req.params, schema.params);
        errors.push(...paramErrors);
      }
      
      if (errors.length > 0) {
        return res.status(400).json({ 
          error: 'Validation failed',
          details: errors 
        });
      }
      
      next();
    };
  }

  validateObject(obj, schema) {
    const errors = [];
    
    for (const [field, rules] of Object.entries(schema)) {
      const value = obj[field];
      
      // Required check
      if (rules.required && !value) {
        errors.push({ field, message: 'Field is required' });
        continue;
      }
      
      if (value) {
        // Type validation
        if (rules.type === 'email' && !validator.isEmail(value)) {
          errors.push({ field, message: 'Invalid email format' });
        }
        
        if (rules.type === 'url' && !validator.isURL(value)) {
          errors.push({ field, message: 'Invalid URL format' });
        }
        
        if (rules.type === 'uuid' && !validator.isUUID(value)) {
          errors.push({ field, message: 'Invalid UUID format' });
        }
        
        // Length validation
        if (rules.minLength && value.length < rules.minLength) {
          errors.push({ field, message: `Minimum length is ${rules.minLength}` });
        }
        
        if (rules.maxLength && value.length > rules.maxLength) {
          errors.push({ field, message: `Maximum length is ${rules.maxLength}` });
        }
        
        // Custom validation
        if (rules.custom && !rules.custom(value)) {
          errors.push({ field, message: rules.customMessage || 'Validation failed' });
        }
      }
    }
    
    return errors;
  }
}
```

### 5. Session Management Patterns

#### Secure Session Implementation
```javascript
// Secure session management
class SessionManager {
  constructor(redisClient) {
    this.redis = redisClient;
    this.sessionTimeout = 30 * 60; // 30 minutes
    this.absoluteTimeout = 8 * 60 * 60; // 8 hours
  }

  async createSession(userId, metadata = {}) {
    const sessionId = crypto.randomBytes(32).toString('hex');
    const now = Date.now();
    
    const session = {
      userId,
      sessionId,
      createdAt: now,
      lastActivity: now,
      metadata: {
        ...metadata,
        userAgent: metadata.userAgent,
        ipAddress: metadata.ipAddress,
        fingerprint: await this.generateFingerprint(metadata)
      }
    };
    
    // Store session with expiry
    await this.redis.setex(
      `session:${sessionId}`,
      this.sessionTimeout,
      JSON.stringify(session)
    );
    
    // Track active sessions per user
    await this.redis.sadd(`user:${userId}:sessions`, sessionId);
    
    return sessionId;
  }

  async validateSession(sessionId, metadata = {}) {
    const sessionKey = `session:${sessionId}`;
    const sessionData = await this.redis.get(sessionKey);
    
    if (!sessionData) {
      throw new UnauthorizedError('Invalid session');
    }
    
    const session = JSON.parse(sessionData);
    
    // Check absolute timeout
    if (Date.now() - session.createdAt > this.absoluteTimeout * 1000) {
      await this.destroySession(sessionId);
      throw new UnauthorizedError('Session expired');
    }
    
    // Verify session fingerprint
    const currentFingerprint = await this.generateFingerprint(metadata);
    if (session.metadata.fingerprint !== currentFingerprint) {
      // Possible session hijacking
      await this.handleSuspiciousActivity(session, metadata);
    }
    
    // Update last activity
    session.lastActivity = Date.now();
    await this.redis.setex(
      sessionKey,
      this.sessionTimeout,
      JSON.stringify(session)
    );
    
    return session;
  }

  async generateFingerprint(metadata) {
    // Create device fingerprint
    const components = [
      metadata.userAgent,
      metadata.acceptLanguage,
      metadata.acceptEncoding,
      metadata.screenResolution
    ].filter(Boolean);
    
    return crypto.createHash('sha256')
      .update(components.join('|'))
      .digest('hex');
  }

  // Session fixation prevention
  async regenerateSession(oldSessionId) {
    const session = await this.validateSession(oldSessionId);
    await this.destroySession(oldSessionId);
    
    return await this.createSession(session.userId, session.metadata);
  }

  // Concurrent session control
  async enforceSessionLimit(userId, limit = 3) {
    const sessions = await this.redis.smembers(`user:${userId}:sessions`);
    
    if (sessions.length >= limit) {
      // Remove oldest session
      const sessionDetails = await Promise.all(
        sessions.map(async (sid) => {
          const data = await this.redis.get(`session:${sid}`);
          return data ? { sid, ...JSON.parse(data) } : null;
        })
      );
      
      const validSessions = sessionDetails.filter(Boolean);
      validSessions.sort((a, b) => a.lastActivity - b.lastActivity);
      
      // Destroy oldest sessions
      const toRemove = validSessions.slice(0, validSessions.length - limit + 1);
      for (const session of toRemove) {
        await this.destroySession(session.sid);
      }
    }
  }
}
```

### 6. API Security Patterns

#### API Rate Limiting and DDoS Protection
```javascript
// Advanced rate limiting
class RateLimiter {
  constructor(redis) {
    this.redis = redis;
    this.limits = {
      global: { requests: 1000, window: 3600 }, // 1000 req/hour
      authenticated: { requests: 5000, window: 3600 }, // 5000 req/hour
      endpoint: {
        '/api/auth/login': { requests: 5, window: 900 }, // 5 attempts/15min
        '/api/password/reset': { requests: 3, window: 3600 } // 3 req/hour
      }
    };
  }

  async checkLimit(identifier, endpoint, isAuthenticated = false) {
    const limits = [];
    
    // Global limit
    limits.push({
      key: `rate:global:${identifier}`,
      limit: this.limits.global
    });
    
    // Authenticated user higher limit
    if (isAuthenticated) {
      limits.push({
        key: `rate:auth:${identifier}`,
        limit: this.limits.authenticated
      });
    }
    
    // Endpoint-specific limit
    if (this.limits.endpoint[endpoint]) {
      limits.push({
        key: `rate:endpoint:${identifier}:${endpoint}`,
        limit: this.limits.endpoint[endpoint]
      });
    }
    
    // Check all applicable limits
    for (const { key, limit } of limits) {
      const current = await this.redis.incr(key);
      
      if (current === 1) {
        await this.redis.expire(key, limit.window);
      }
      
      if (current > limit.requests) {
        const ttl = await this.redis.ttl(key);
        throw new RateLimitError(`Rate limit exceeded. Try again in ${ttl} seconds`);
      }
    }
  }

  // Distributed rate limiting with sliding window
  async checkSlidingWindow(identifier, limit, window) {
    const now = Date.now();
    const windowStart = now - window * 1000;
    const key = `sliding:${identifier}`;
    
    // Remove old entries
    await this.redis.zremrangebyscore(key, 0, windowStart);
    
    // Count requests in window
    const count = await this.redis.zcard(key);
    
    if (count >= limit) {
      throw new RateLimitError('Rate limit exceeded');
    }
    
    // Add current request
    await this.redis.zadd(key, now, `${now}:${crypto.randomBytes(4).toString('hex')}`);
    await this.redis.expire(key, window);
  }

  // Middleware
  middleware(options = {}) {
    return async (req, res, next) => {
      try {
        const identifier = req.ip; // Or use user ID for authenticated requests
        const endpoint = req.path;
        const isAuthenticated = !!req.user;
        
        await this.checkLimit(identifier, endpoint, isAuthenticated);
        
        // Add rate limit headers
        res.set({
          'X-RateLimit-Limit': this.limits.global.requests,
          'X-RateLimit-Remaining': this.limits.global.requests - 1,
          'X-RateLimit-Reset': new Date(Date.now() + this.limits.global.window * 1000).toISOString()
        });
        
        next();
      } catch (error) {
        if (error instanceof RateLimitError) {
          res.status(429).json({ error: error.message });
        } else {
          next(error);
        }
      }
    };
  }
}

// API Key authentication
class APIKeyService {
  async generateAPIKey(userId, name, permissions = []) {
    const key = crypto.randomBytes(32).toString('hex');
    const hashedKey = await this.hashAPIKey(key);
    
    const apiKey = {
      id: crypto.randomUUID(),
      userId,
      name,
      hashedKey,
      permissions,
      lastUsed: null,
      createdAt: new Date(),
      expiresAt: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000) // 1 year
    };
    
    await this.apiKeyRepository.create(apiKey);
    
    // Return the unhashed key only once
    return {
      id: apiKey.id,
      key: `myapp_${key}`, // Prefix for easy identification
      name: apiKey.name,
      permissions: apiKey.permissions,
      expiresAt: apiKey.expiresAt
    };
  }

  async validateAPIKey(key) {
    // Extract actual key from prefix
    const actualKey = key.replace(/^myapp_/, '');
    const hashedKey = await this.hashAPIKey(actualKey);
    
    const apiKey = await this.apiKeyRepository.findByHash(hashedKey);
    
    if (!apiKey) {
      throw new UnauthorizedError('Invalid API key');
    }
    
    if (apiKey.expiresAt < new Date()) {
      throw new UnauthorizedError('API key expired');
    }
    
    // Update last used
    await this.apiKeyRepository.updateLastUsed(apiKey.id);
    
    return apiKey;
  }
}
```

## Code Examples

### Complete Security Implementation

```javascript
// Comprehensive security middleware stack
class SecurityMiddleware {
  constructor(config) {
    this.config = config;
    this.setupMiddleware();
  }

  setupMiddleware() {
    const app = express();

    // 1. Security headers
    app.use(helmet({
      contentSecurityPolicy: {
        directives: {
          defaultSrc: ["'self'"],
          scriptSrc: ["'self'", "'strict-dynamic'"],
          styleSrc: ["'self'", "'unsafe-inline'"],
          imgSrc: ["'self'", "data:", "https:"],
          connectSrc: ["'self'"],
          fontSrc: ["'self'"],
          objectSrc: ["'none'"],
          mediaSrc: ["'self'"],
          frameSrc: ["'none'"]
        }
      },
      hsts: {
        maxAge: 31536000,
        includeSubDomains: true,
        preload: true
      }
    }));

    // 2. CORS configuration
    app.use(cors({
      origin: (origin, callback) => {
        const allowedOrigins = process.env.ALLOWED_ORIGINS.split(',');
        if (!origin || allowedOrigins.includes(origin)) {
          callback(null, true);
        } else {
          callback(new Error('Not allowed by CORS'));
        }
      },
      credentials: true,
      maxAge: 86400 // 24 hours
    }));

    // 3. Request sanitization
    app.use(expressSanitizer());

    // 4. Rate limiting
    app.use(this.rateLimiter.middleware());

    // 5. Request size limits
    app.use(express.json({ limit: '10mb' }));
    app.use(express.urlencoded({ extended: true, limit: '10mb' }));

    // 6. SQL injection prevention (example with Sequelize)
    this.configureDatabaseSecurity();

    // 7. Authentication
    app.use(this.authService.authenticate());

    // 8. Request logging for security audit
    app.use(this.securityLogger());

    // 9. CSRF protection
    app.use(csrf({ cookie: true }));

    // 10. Response sanitization
    app.use(this.responseSanitizer());

    return app;
  }

  securityLogger() {
    return (req, res, next) => {
      const logData = {
        timestamp: new Date().toISOString(),
        ip: req.ip,
        method: req.method,
        url: req.url,
        userAgent: req.get('user-agent'),
        userId: req.user?.id,
        statusCode: res.statusCode
      };

      // Log security-relevant events
      if (req.url.includes('/admin') || req.method === 'DELETE') {
        this.logger.security('Sensitive operation', logData);
      }

      next();
    };
  }

  responseSanitizer() {
    return (req, res, next) => {
      const originalJson = res.json;
      
      res.json = function(data) {
        // Remove sensitive fields from responses
        const sanitized = SecurityMiddleware.removeSensitiveFields(data);
        originalJson.call(this, sanitized);
      };
      
      next();
    };
  }

  static removeSensitiveFields(obj) {
    const sensitiveFields = ['password', 'ssn', 'creditCard', 'apiKey'];
    
    if (typeof obj !== 'object' || obj === null) {
      return obj;
    }
    
    if (Array.isArray(obj)) {
      return obj.map(item => SecurityMiddleware.removeSensitiveFields(item));
    }
    
    const cleaned = {};
    for (const [key, value] of Object.entries(obj)) {
      if (!sensitiveFields.includes(key)) {
        cleaned[key] = SecurityMiddleware.removeSensitiveFields(value);
      }
    }
    
    return cleaned;
  }
}

// Security monitoring and alerting
class SecurityMonitor {
  constructor(alertService) {
    this.alertService = alertService;
    this.thresholds = {
      failedLogins: 5,
      suspiciousRequests: 10,
      rateLimitHits: 20
    };
  }

  async monitorFailedLogins(userId, ip) {
    const key = `failed_login:${userId || ip}`;
    const count = await this.redis.incr(key);
    
    if (count === 1) {
      await this.redis.expire(key, 900); // 15 minutes
    }
    
    if (count >= this.thresholds.failedLogins) {
      await this.alertService.sendAlert({
        type: 'SECURITY',
        severity: 'HIGH',
        message: `Multiple failed login attempts for ${userId || ip}`,
        details: { count, userId, ip }
      });
      
      // Auto-block after threshold
      await this.blockTemporarily(userId || ip);
    }
  }

  async detectAnomalousActivity(userId, activity) {
    // Check for unusual patterns
    const recentActivities = await this.getRecentActivities(userId);
    
    // Detect anomalies
    if (this.isAnomalous(activity, recentActivities)) {
      await this.alertService.sendAlert({
        type: 'ANOMALY',
        severity: 'MEDIUM',
        message: `Unusual activity detected for user ${userId}`,
        details: activity
      });
      
      // Require additional authentication
      await this.requireMFA(userId);
    }
  }
}
```

## Benefits & Trade-offs

### Benefits
- **Data Protection**: Prevents unauthorized access to sensitive information
- **Compliance**: Meets regulatory requirements (GDPR, HIPAA, PCI-DSS)
- **Trust**: Builds user confidence in the application
- **Risk Mitigation**: Reduces potential for breaches and attacks
- **Audit Trail**: Provides accountability and forensic capabilities
- **Defense in Depth**: Multiple layers of security

### Trade-offs
- **Performance Impact**: Security measures add processing overhead
- **Complexity**: Security implementations increase code complexity
- **User Experience**: Security can add friction to user workflows
- **Development Time**: Proper security takes time to implement
- **Maintenance**: Security measures require ongoing updates
- **Cost**: Security tools and infrastructure have associated costs

## Common Pitfalls

1. **Hardcoded Secrets**: Storing passwords or API keys in code
2. **Weak Cryptography**: Using outdated or weak encryption algorithms
3. **Missing Input Validation**: Trusting user input without validation
4. **Session Fixation**: Not regenerating session IDs after login
5. **Insufficient Logging**: Not tracking security-relevant events
6. **Poor Error Handling**: Revealing sensitive information in errors
7. **Missing Security Headers**: Not implementing proper HTTP headers

## Integration with AugmentedClaude Specialists

### Security Engineer
- Conducts security assessments and penetration testing
- Implements security controls and monitoring
- Responds to security incidents

### Backend Developer
- Implements authentication and authorization
- Secures API endpoints
- Handles data encryption

### DevOps Engineer
- Secures infrastructure and deployment pipelines
- Manages secrets and certificates
- Implements security monitoring

### Compliance Officer
- Ensures regulatory compliance
- Manages security policies
- Conducts security audits

## Related Patterns

- **Zero Trust Architecture**: Never trust, always verify
- **Defense in Depth**: Multiple security layers
- **Principle of Least Privilege**: Minimal necessary access
- **Secure by Design**: Security built into architecture
- **Security as Code**: Automated security testing
- **DevSecOps**: Security integrated into DevOps

## Best Practices

1. **Security First Design**
   - Consider security requirements from the start
   - Threat model your application
   - Regular security reviews

2. **Keep Dependencies Updated**
   ```json
   // package.json security audit
   {
     "scripts": {
       "security-check": "npm audit && snyk test",
       "update-deps": "npm update && npm audit fix"
     }
   }
   ```

3. **Secure Configuration**
   ```javascript
   // Environment-based configuration
   const config = {
     jwt: {
       secret: process.env.JWT_SECRET,
       expiresIn: process.env.JWT_EXPIRES_IN || '15m'
     },
     encryption: {
       key: Buffer.from(process.env.ENCRYPTION_KEY, 'hex')
     },
     session: {
       secret: process.env.SESSION_SECRET,
       secure: process.env.NODE_ENV === 'production',
       httpOnly: true,
       sameSite: 'strict'
     }
   };
   ```

4. **Regular Security Testing**
   - Automated security scanning in CI/CD
   - Regular penetration testing
   - Security code reviews

5. **Incident Response Plan**
   - Document security procedures
   - Regular drills and updates
   - Clear escalation paths

These patterns provide comprehensive security coverage for modern applications, protecting against common vulnerabilities while maintaining usability and performance.