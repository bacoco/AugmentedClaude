---
schema_version: "1.0"
last_updated: "2025-01-29T00:00:00Z"
update_mode: "runtime"
integration_points:
  - "all-specialists"
  - "orchestrator"
  - "project-manager"
---

# Current Session State

## Purpose
This file maintains the real-time state of the current working session, including active tasks, decisions made, temporary data, and specialist coordination. It is cleared and reinitialized at the start of each new session.

## Schema Definition

### Session Metadata
```yaml
session:
  id: string                # Unique session identifier (UUID)
  start_time: datetime      # Session start timestamp
  last_activity: datetime   # Last update timestamp
  status: enum             # [active, paused, completed, terminated]
  mode: enum               # [development, analysis, planning, maintenance, emergency]
  context_loaded: boolean  # Whether historical context is loaded
  
  user:
    id: string             # User identifier
    preferences: object    # Session-specific preferences
    timezone: string       # User timezone
  
  environment:
    working_directory: string
    git_branch: string
    last_commit: string
    modified_files: array
```

### Active Specialists
```yaml
specialists:
  - id: string             # Specialist identifier
    type: string           # Specialist type from registry
    activated_at: datetime # When activated
    status: enum           # [idle, working, blocked, completed]
    current_task: string   # Current task description
    
    resources:
      memory_usage: string # Memory allocated
      tokens_used: number  # API tokens consumed
      
    interactions:
      messages_sent: number
      messages_received: number
      last_interaction: datetime
```

### Task Tracking
```yaml
tasks:
  - id: string             # Task identifier
    title: string          # Task title
    type: enum            # [feature, bug, refactor, analysis, documentation]
    status: enum          # [queued, in-progress, blocked, completed, cancelled]
    priority: enum        # [low, medium, high, critical]
    
    created_at: datetime
    started_at: datetime
    completed_at: datetime
    estimated_duration: string
    actual_duration: string
    
    assigned_to: array     # Specialist IDs
    dependencies: array    # Other task IDs
    blockers: array        # What's blocking progress
    
    artifacts:             # Generated artifacts
      - type: string       # [code, document, report, diagram]
        path: string       # File path
        description: string
    
    notes: string          # Additional notes
```

### Decision Log
```yaml
decisions:
  - id: string             # Decision identifier
    timestamp: datetime    # When decided
    made_by: string        # Specialist ID
    category: enum         # [technical, process, business, design]
    
    context: string        # Why decision was needed
    options_considered:    # Alternatives evaluated
      - option: string
        pros: array
        cons: array
    
    decision: string       # What was decided
    rationale: string      # Why this choice
    impact: string         # Expected impact
    
    approval:
      required: boolean
      approved_by: string
      approved_at: datetime
    
    reversible: boolean    # Can be undone
    review_date: date      # When to review decision
```

### Temporary Data Store
```yaml
temporary_data:
  - key: string            # Data key
    value: any             # Data value
    type: string           # Data type
    created_by: string     # Specialist ID
    created_at: datetime
    expires_at: datetime   # When to auto-delete
    purpose: string        # Why stored
    
    access_log:            # Who accessed
      - specialist: string
        timestamp: datetime
        operation: enum    # [read, write, delete]
```

### Communication Log
```yaml
communications:
  - id: string             # Message ID
    timestamp: datetime
    from: string           # Sender specialist ID
    to: array              # Recipient specialist IDs
    type: enum             # [query, response, notification, command]
    
    content: string        # Message content
    priority: enum         # [low, normal, high, urgent]
    
    response_required: boolean
    response_deadline: datetime
    responses: array       # Response message IDs
```

### Performance Metrics
```yaml
performance:
  session_metrics:
    total_tasks: number
    completed_tasks: number
    blocked_tasks: number
    average_task_time: string
    
  specialist_metrics:
    - specialist_id: string
      tasks_completed: number
      average_response_time: string
      efficiency_score: number
      
  resource_metrics:
    total_tokens: number
    total_api_calls: number
    error_count: number
    retry_count: number
```

## Example Entry (Replaced each session)

```yaml
session:
  id: "550e8400-e29b-41d4-a716-446655440000"
  start_time: "2025-01-29T09:00:00Z"
  last_activity: "2025-01-29T10:30:00Z"
  status: "active"
  mode: "development"
  context_loaded: true
  
  user:
    id: "user-123"
    preferences:
      auto_test: true
      verbose_logging: false
    timezone: "America/New_York"
  
  environment:
    working_directory: "/Users/loic/develop/AugmentedClaude"
    git_branch: "feature/user-auth"
    last_commit: "a1b2c3d4"
    modified_files:
      - "src/auth/login.js"
      - "src/auth/register.js"

specialists:
  - id: "backend-dev-001"
    type: "backend-dev"
    activated_at: "2025-01-29T09:05:00Z"
    status: "working"
    current_task: "Implementing JWT authentication"
    
    resources:
      memory_usage: "256MB"
      tokens_used: 15000
      
    interactions:
      messages_sent: 12
      messages_received: 8
      last_interaction: "2025-01-29T10:28:00Z"

tasks:
  - id: "task-001"
    title: "Implement user authentication system"
    type: "feature"
    status: "in-progress"
    priority: "high"
    
    created_at: "2025-01-29T09:00:00Z"
    started_at: "2025-01-29T09:05:00Z"
    completed_at: null
    estimated_duration: "4 hours"
    actual_duration: null
    
    assigned_to: ["backend-dev-001", "frontend-dev-001"]
    dependencies: []
    blockers: []
    
    artifacts:
      - type: "code"
        path: "src/auth/jwt.js"
        description: "JWT token generation and validation"
    
    notes: "Using RS256 algorithm for enhanced security"

decisions:
  - id: "dec-001"
    timestamp: "2025-01-29T09:15:00Z"
    made_by: "architect-001"
    category: "technical"
    
    context: "Need to choose authentication token format"
    options_considered:
      - option: "JWT with RS256"
        pros: ["Industry standard", "Stateless", "Secure"]
        cons: ["Larger token size", "Cannot revoke easily"]
      - option: "Opaque tokens with Redis"
        pros: ["Can revoke", "Smaller size"]
        cons: ["Requires session store", "Additional infrastructure"]
    
    decision: "Use JWT with RS256 algorithm"
    rationale: "Stateless architecture aligns with microservices goals"
    impact: "All services can validate tokens independently"
    
    approval:
      required: false
      approved_by: null
      approved_at: null
    
    reversible: true
    review_date: "2025-02-29"

temporary_data:
  - key: "jwt_secret"
    value: "temporary_development_secret_key"
    type: "string"
    created_by: "backend-dev-001"
    created_at: "2025-01-29T09:20:00Z"
    expires_at: "2025-01-29T18:00:00Z"
    purpose: "Development testing only"
    
    access_log:
      - specialist: "backend-dev-001"
        timestamp: "2025-01-29T09:20:00Z"
        operation: "write"

communications:
  - id: "msg-001"
    timestamp: "2025-01-29T09:10:00Z"
    from: "project-manager-001"
    to: ["backend-dev-001", "frontend-dev-001"]
    type: "command"
    
    content: "Please prioritize authentication implementation"
    priority: "high"
    
    response_required: true
    response_deadline: "2025-01-29T09:15:00Z"
    responses: ["msg-002", "msg-003"]

performance:
  session_metrics:
    total_tasks: 5
    completed_tasks: 2
    blocked_tasks: 0
    average_task_time: "45 minutes"
    
  specialist_metrics:
    - specialist_id: "backend-dev-001"
      tasks_completed: 1
      average_response_time: "30 seconds"
      efficiency_score: 85
      
  resource_metrics:
    total_tokens: 45000
    total_api_calls: 120
    error_count: 2
    retry_count: 3
```

## Update Instructions

### Session Lifecycle
1. **Initialization**: Clear previous session, generate new ID
2. **Context Loading**: Load relevant project context
3. **Active Work**: Continuous updates during work
4. **Checkpointing**: Periodic state saves
5. **Completion**: Final state capture and archival

### Real-time Updates
```yaml
update_types:
  specialist_status:
    frequency: "on_change"
    fields: ["status", "current_task", "last_interaction"]
    
  task_progress:
    frequency: "every_5_minutes"
    fields: ["status", "actual_duration", "blockers"]
    
  metrics:
    frequency: "every_10_minutes"
    fields: ["all_metrics"]
```

### Data Retention
- **Session Data**: Archived after completion
- **Temporary Data**: Auto-deleted at expiration
- **Decisions**: Promoted to permanent storage
- **Artifacts**: Linked in project documentation

## Query Interface

### Supported Queries
- `get_active_specialists()` - Currently active specialists
- `get_current_tasks()` - Tasks in progress
- `get_session_metrics()` - Performance metrics
- `get_recent_decisions()` - Recent decision log
- `get_blockers()` - Current blocking issues
- `check_specialist_availability(type)` - Is specialist available

### Usage by Specialists
```python
# Example: Orchestrator checking task status
active_tasks = current_session.get_current_tasks()
blocked = [t for t in active_tasks if t.status == "blocked"]

# Example: Specialist storing temporary data
current_session.store_temporary(
    key="analysis_results",
    value=results,
    expires_in_hours=4
)
```

## Session Coordination Protocol
1. **Specialist Activation**: Register in active specialists
2. **Task Assignment**: Update task tracking
3. **Communication**: Log all inter-specialist messages
4. **Decision Making**: Record with full context
5. **Resource Tracking**: Monitor usage continuously
6. **State Preservation**: Regular checkpoints

## Emergency Procedures
- **Session Recovery**: Restore from last checkpoint
- **Specialist Failure**: Reassign tasks to available specialists
- **Resource Limits**: Pause non-critical tasks
- **Data Corruption**: Rollback to last valid state