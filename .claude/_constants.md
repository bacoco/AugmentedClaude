# System Constants and Configuration

## API Limits and Thresholds

### Claude API Limits
```javascript
export const API_LIMITS = {
  // Token limits by model
  TOKEN_LIMITS: {
    'claude-3-opus': 200000,
    'claude-3-sonnet': 200000,
    'claude-3-haiku': 200000,
    'claude-2.1': 200000,
    'claude-2': 100000,
    'claude-instant': 100000
  },
  
  // Rate limits (requests per minute)
  RATE_LIMITS: {
    'claude-3-opus': 50,
    'claude-3-sonnet': 100,
    'claude-3-haiku': 200,
    'claude-2.1': 100,
    'claude-2': 100,
    'claude-instant': 200
  },
  
  // Response time limits (ms)
  RESPONSE_TIMEOUTS: {
    'claude-3-opus': 120000,    // 2 minutes
    'claude-3-sonnet': 90000,    // 1.5 minutes
    'claude-3-haiku': 60000,     // 1 minute
    'claude-2.1': 90000,         // 1.5 minutes
    'claude-2': 60000,           // 1 minute
    'claude-instant': 30000      // 30 seconds
  }
};
```

### Request Configuration
```javascript
export const REQUEST_CONFIG = {
  // Default timeout for API requests
  DEFAULT_TIMEOUT: 60000,            // 1 minute
  
  // Maximum timeout allowed
  MAX_TIMEOUT: 600000,               // 10 minutes
  
  // Retry configuration
  RETRY: {
    MAX_ATTEMPTS: 5,
    INITIAL_DELAY: 1000,             // 1 second
    MAX_DELAY: 60000,                // 1 minute
    BACKOFF_MULTIPLIER: 2,
    JITTER_FACTOR: 0.1
  },
  
  // Request queue settings
  QUEUE: {
    MAX_SIZE: 1000,
    MAX_PRIORITY: 10,
    DEFAULT_PRIORITY: 5,
    PROCESSING_INTERVAL: 100         // ms
  }
};
```

## File Size Limits

```javascript
export const FILE_LIMITS = {
  // Maximum file sizes for operations
  MAX_FILE_SIZE: 10 * 1024 * 1024,   // 10MB
  MAX_READ_SIZE: 5 * 1024 * 1024,    // 5MB
  MAX_WRITE_SIZE: 10 * 1024 * 1024,  // 10MB
  
  // Line limits
  MAX_LINES_PER_READ: 50000,
  DEFAULT_LINES_PER_READ: 2000,
  MAX_LINE_LENGTH: 10000,
  
  // Batch operation limits
  MAX_FILES_PER_BATCH: 100,
  MAX_BATCH_SIZE: 50 * 1024 * 1024,  // 50MB total
  
  // File type restrictions
  BINARY_EXTENSIONS: [
    '.jpg', '.jpeg', '.png', '.gif', '.bmp', '.ico', '.webp',
    '.mp3', '.mp4', '.avi', '.mov', '.wmv', '.flv',
    '.zip', '.tar', '.gz', '.rar', '.7z',
    '.exe', '.dll', '.so', '.dylib',
    '.pdf', '.doc', '.docx', '.xls', '.xlsx'
  ],
  
  // Text file extensions (for optimization)
  TEXT_EXTENSIONS: [
    '.txt', '.md', '.js', '.ts', '.jsx', '.tsx',
    '.py', '.java', '.c', '.cpp', '.h', '.hpp',
    '.css', '.scss', '.sass', '.less',
    '.html', '.xml', '.json', '.yaml', '.yml',
    '.sh', '.bash', '.zsh', '.fish',
    '.vim', '.conf', '.cfg', '.ini', '.env'
  ]
};
```

## Memory Allocation Constants

```javascript
export const MEMORY_CONFIG = {
  // Storage limits
  MAX_MEMORY_SIZE: 100 * 1024 * 1024,     // 100MB total
  MAX_ENTRY_SIZE: 5 * 1024 * 1024,        // 5MB per entry
  MAX_ENTRIES: 10000,
  
  // Cache configuration
  CACHE: {
    MAX_SIZE: 50 * 1024 * 1024,           // 50MB
    TTL: 15 * 60 * 1000,                  // 15 minutes
    CHECK_INTERVAL: 60 * 1000,            // 1 minute
    EVICTION_BATCH_SIZE: 100
  },
  
  // Compression thresholds
  COMPRESSION: {
    MIN_SIZE: 1024,                       // 1KB
    COMPRESSION_LEVEL: 6,                 // zlib level (1-9)
    CHUNK_SIZE: 64 * 1024                 // 64KB chunks
  },
  
  // Persistence settings
  PERSISTENCE: {
    SAVE_INTERVAL: 5 * 60 * 1000,         // 5 minutes
    BACKUP_COUNT: 5,
    BACKUP_RETENTION_DAYS: 30
  }
};
```

## Specialist Activation Thresholds

```javascript
export const SPECIALIST_THRESHOLDS = {
  // Confidence scores for automatic activation (0-1)
  ACTIVATION_CONFIDENCE: {
    orchestrator: 0.0,      // Always available
    coder: 0.7,
    researcher: 0.6,
    tdd: 0.8,
    architect: 0.7,
    reviewer: 0.6,
    debugger: 0.8,
    tester: 0.7,
    analyzer: 0.6,
    optimizer: 0.7,
    documenter: 0.6,
    designer: 0.7,
    innovator: 0.5,
    'swarm-coordinator': 0.8,
    'memory-manager': 0.7,
    'batch-executor': 0.8,
    'workflow-manager': 0.7
  },
  
  // Keywords that trigger specialists
  ACTIVATION_KEYWORDS: {
    coder: ['implement', 'code', 'function', 'class', 'api', 'develop'],
    researcher: ['research', 'investigate', 'explore', 'analyze', 'compare'],
    tdd: ['test', 'tdd', 'unit test', 'testing', 'test-driven'],
    architect: ['design', 'architecture', 'structure', 'system', 'pattern'],
    reviewer: ['review', 'audit', 'check', 'validate', 'inspect'],
    debugger: ['debug', 'fix', 'error', 'bug', 'issue', 'problem'],
    tester: ['test', 'verify', 'validate', 'check', 'qa'],
    analyzer: ['analyze', 'profile', 'performance', 'metrics', 'benchmark'],
    optimizer: ['optimize', 'improve', 'enhance', 'performance', 'speed'],
    documenter: ['document', 'docs', 'readme', 'guide', 'manual'],
    designer: ['ui', 'ux', 'design', 'interface', 'layout', 'style'],
    innovator: ['innovate', 'creative', 'novel', 'unique', 'brainstorm']
  },
  
  // Complexity thresholds for specialist activation
  COMPLEXITY_THRESHOLDS: {
    simple: 0.3,
    moderate: 0.6,
    complex: 0.8,
    expert: 0.95
  }
};
```

## Quality Gate Metrics

```javascript
export const QUALITY_GATES = {
  // Code quality metrics
  CODE_QUALITY: {
    MIN_TEST_COVERAGE: 80,              // percentage
    MAX_CYCLOMATIC_COMPLEXITY: 10,
    MAX_FUNCTION_LENGTH: 50,            // lines
    MAX_FILE_LENGTH: 500,               // lines
    MAX_LINE_LENGTH: 120,               // characters
    MIN_DOCUMENTATION_COVERAGE: 70      // percentage
  },
  
  // Performance metrics
  PERFORMANCE: {
    MAX_RESPONSE_TIME: 5000,            // ms
    MAX_MEMORY_USAGE: 512,              // MB
    MAX_CPU_USAGE: 80,                  // percentage
    MIN_THROUGHPUT: 100                 // requests/second
  },
  
  // Security metrics
  SECURITY: {
    MAX_VULNERABILITY_SCORE: 7.0,       // CVSS score
    REQUIRED_SECURITY_HEADERS: [
      'Content-Security-Policy',
      'X-Frame-Options',
      'X-Content-Type-Options',
      'Strict-Transport-Security'
    ],
    PASSWORD_MIN_LENGTH: 12,
    SESSION_TIMEOUT: 30 * 60 * 1000     // 30 minutes
  },
  
  // Build metrics
  BUILD: {
    MAX_BUILD_TIME: 10 * 60 * 1000,     // 10 minutes
    MAX_BUNDLE_SIZE: 5 * 1024 * 1024,   // 5MB
    MAX_ASSET_SIZE: 1 * 1024 * 1024,    // 1MB
    MIN_LIGHTHOUSE_SCORE: 80            // out of 100
  }
};
```

## System Defaults

```javascript
export const SYSTEM_DEFAULTS = {
  // Default configurations
  DEFAULT_MODEL: 'claude-3-sonnet',
  DEFAULT_TEMPERATURE: 0.7,
  DEFAULT_MAX_TOKENS: 4096,
  DEFAULT_TOP_P: 0.9,
  
  // UI defaults
  UI: {
    DEFAULT_PORT: 3000,
    DEFAULT_HOST: 'localhost',
    SESSION_DURATION: 24 * 60 * 60 * 1000,  // 24 hours
    REFRESH_INTERVAL: 5000,                  // 5 seconds
    MAX_CONSOLE_LINES: 1000
  },
  
  // Agent defaults
  AGENTS: {
    MAX_CONCURRENT: 10,
    DEFAULT_PRIORITY: 5,
    HEARTBEAT_INTERVAL: 30000,              // 30 seconds
    ZOMBIE_TIMEOUT: 5 * 60 * 1000           // 5 minutes
  },
  
  // Swarm defaults
  SWARM: {
    DEFAULT_STRATEGY: 'balanced',
    DEFAULT_MODE: 'hierarchical',
    MAX_AGENTS: 20,
    MIN_AGENTS: 2,
    COORDINATION_INTERVAL: 1000,            // 1 second
    CONSENSUS_THRESHOLD: 0.7                // 70% agreement
  }
};
```

## Error Constants

```javascript
export const ERROR_CODES = {
  // API errors (1xxx)
  API_TIMEOUT: 1001,
  API_RATE_LIMIT: 1002,
  API_INVALID_REQUEST: 1003,
  API_AUTHENTICATION: 1004,
  API_SERVER_ERROR: 1005,
  
  // File errors (2xxx)
  FILE_NOT_FOUND: 2001,
  FILE_TOO_LARGE: 2002,
  FILE_ACCESS_DENIED: 2003,
  FILE_CORRUPT: 2004,
  FILE_UNSUPPORTED_TYPE: 2005,
  
  // Memory errors (3xxx)
  MEMORY_FULL: 3001,
  MEMORY_CORRUPT: 3002,
  MEMORY_KEY_NOT_FOUND: 3003,
  MEMORY_INVALID_DATA: 3004,
  
  // Agent errors (4xxx)
  AGENT_SPAWN_FAILED: 4001,
  AGENT_NOT_FOUND: 4002,
  AGENT_TIMEOUT: 4003,
  AGENT_CRASHED: 4004,
  AGENT_BUSY: 4005,
  
  // System errors (5xxx)
  SYSTEM_OVERLOAD: 5001,
  SYSTEM_CONFIG_INVALID: 5002,
  SYSTEM_DEPENDENCY_MISSING: 5003,
  SYSTEM_PERMISSION_DENIED: 5004
};
```

## Monitoring Constants

```javascript
export const MONITORING = {
  // Metrics collection
  METRICS: {
    COLLECTION_INTERVAL: 10000,         // 10 seconds
    RETENTION_PERIOD: 7 * 24 * 3600000, // 7 days
    MAX_DATAPOINTS: 10000,
    AGGREGATION_INTERVALS: [
      60000,        // 1 minute
      300000,       // 5 minutes
      3600000,      // 1 hour
      86400000      // 1 day
    ]
  },
  
  // Alerting thresholds
  ALERTS: {
    CPU_HIGH: 80,                       // percentage
    MEMORY_HIGH: 85,                    // percentage
    DISK_HIGH: 90,                      // percentage
    ERROR_RATE_HIGH: 5,                 // percentage
    RESPONSE_TIME_HIGH: 5000,           // ms
    QUEUE_SIZE_HIGH: 500                // items
  },
  
  // Logging configuration
  LOGGING: {
    MAX_LOG_SIZE: 50 * 1024 * 1024,    // 50MB
    MAX_LOG_FILES: 10,
    LOG_ROTATION_INTERVAL: 86400000,    // 1 day
    LOG_LEVELS: {
      ERROR: 0,
      WARN: 1,
      INFO: 2,
      DEBUG: 3,
      TRACE: 4
    }
  }
};
```

## Feature Flags

```javascript
export const FEATURES = {
  // Core features
  ENABLE_SWARM: true,
  ENABLE_MEMORY: true,
  ENABLE_MCP: true,
  ENABLE_UI: true,
  
  // Experimental features
  EXPERIMENTAL: {
    ENABLE_AUTO_SCALING: false,
    ENABLE_DISTRIBUTED_MEMORY: false,
    ENABLE_AI_OPTIMIZATION: false,
    ENABLE_PREDICTIVE_CACHING: false
  },
  
  // Enterprise features
  ENTERPRISE: {
    ENABLE_SSO: false,
    ENABLE_AUDIT_TRAIL: false,
    ENABLE_ADVANCED_ANALYTICS: false,
    ENABLE_MULTI_TENANCY: false,
    ENABLE_CUSTOM_MODELS: false
  },
  
  // Debug features
  DEBUG: {
    ENABLE_VERBOSE_LOGGING: false,
    ENABLE_PERFORMANCE_PROFILING: false,
    ENABLE_MEMORY_PROFILING: false,
    ENABLE_NETWORK_DEBUGGING: false
  }
};
```

## Magic Numbers and Ratios

```javascript
export const MAGIC_NUMBERS = {
  // Golden ratios for UI
  GOLDEN_RATIO: 1.618,
  INVERSE_GOLDEN_RATIO: 0.618,
  
  // Common time intervals
  MILLISECOND: 1,
  SECOND: 1000,
  MINUTE: 60000,
  HOUR: 3600000,
  DAY: 86400000,
  WEEK: 604800000,
  
  // Byte conversions
  BYTE: 1,
  KILOBYTE: 1024,
  MEGABYTE: 1048576,
  GIGABYTE: 1073741824,
  
  // Percentage thresholds
  CRITICAL_THRESHOLD: 0.9,    // 90%
  WARNING_THRESHOLD: 0.7,     // 70%
  INFO_THRESHOLD: 0.5,        // 50%
  
  // Magic primes for hashing
  HASH_PRIME_1: 31,
  HASH_PRIME_2: 37,
  HASH_PRIME_3: 41
};
```