---
schema_version: "1.0"
last_updated: "2025-01-29T00:00:00Z"
update_mode: "runtime"
integration_points:
  - "project-manager"
  - "product-manager"
  - "strategist"
  - "scrum-master"
---

# Project Overview

## Purpose
This file maintains the high-level project context including goals, milestones, team structure, and success metrics. It is updated during runtime by project management specialists.

## Schema Definition

### Project Metadata
```yaml
project:
  name: string               # Project identifier
  description: string        # Brief project description
  status: enum              # [planning, active, maintenance, completed, archived]
  start_date: date          # ISO 8601 format
  target_completion: date   # ISO 8601 format
  repository: string        # Git repository URL
  documentation: string     # Documentation URL
```

### Goals and Objectives
```yaml
goals:
  - id: string             # Unique identifier (e.g., "goal-001")
    title: string          # Goal title
    description: string    # Detailed description
    type: enum            # [business, technical, user-experience]
    priority: enum        # [critical, high, medium, low]
    success_criteria:     # Measurable criteria
      - metric: string
        target: any
        current: any
    status: enum          # [not-started, in-progress, achieved, blocked]
```

### Team Structure
```yaml
team:
  - role: string          # Role title
    specialist: string    # Specialist ID from registry
    responsibilities:     # List of key responsibilities
      - string
    allocated_time: number # Percentage of time allocated
```

### Milestones
```yaml
milestones:
  - id: string           # Unique identifier (e.g., "m1")
    name: string         # Milestone name
    description: string  # What this milestone represents
    due_date: date      # Target completion date
    dependencies:       # List of dependent milestone IDs
      - string
    deliverables:       # Expected outputs
      - string
    status: enum        # [pending, in-progress, completed, delayed]
    completion_date: date # Actual completion date
```

### Success Metrics
```yaml
metrics:
  - id: string          # Unique identifier
    name: string        # Metric name
    category: enum      # [performance, quality, adoption, business]
    measurement: string # How to measure
    baseline: any       # Starting value
    target: any         # Target value
    current: any        # Current value
    trend: enum         # [improving, stable, declining]
    last_updated: date  # Last measurement date
```

## Example Entry (To be replaced during runtime)

```yaml
project:
  name: "AugmentedClaude"
  description: "AI-powered development orchestration system"
  status: "active"
  start_date: "2025-01-29"
  target_completion: "2025-06-30"
  repository: "https://github.com/example/augmentedclaude"
  documentation: "https://docs.augmentedclaude.io"

goals:
  - id: "goal-001"
    title: "Implement Core Orchestration System"
    description: "Build the foundation for AI specialist coordination"
    type: "technical"
    priority: "critical"
    success_criteria:
      - metric: "specialist_types_implemented"
        target: 15
        current: 0
      - metric: "command_coverage"
        target: 100
        current: 0
    status: "not-started"

team:
  - role: "Lead Architect"
    specialist: "architect"
    responsibilities:
      - "System design and architecture decisions"
      - "Technical stack selection"
      - "Integration pattern definition"
    allocated_time: 30

milestones:
  - id: "m1"
    name: "Foundation Setup"
    description: "Core system structure and basic specialist framework"
    due_date: "2025-02-15"
    dependencies: []
    deliverables:
      - "Directory structure"
      - "Base specialist templates"
      - "Command registry"
    status: "pending"
    completion_date: null

metrics:
  - id: "metric-001"
    name: "Development Velocity"
    category: "performance"
    measurement: "Story points per sprint"
    baseline: 0
    target: 40
    current: 0
    trend: "stable"
    last_updated: "2025-01-29"
```

## Update Instructions

### For Runtime Updates
1. Specialists should use YAML merge operations to update specific sections
2. Always increment version timestamps when updating
3. Preserve existing data unless explicitly replacing
4. Validate against schema before writing

### Integration Protocol
```yaml
update_request:
  specialist: string      # Requesting specialist ID
  section: string        # Section to update
  operation: enum        # [merge, replace, append]
  data: object          # New data
  reason: string        # Update justification
```

### Validation Rules
- All dates must be ISO 8601 format
- IDs must be unique within their section
- Status enums must match defined values
- Dependencies must reference existing IDs
- Metrics must have measurable values

## Query Interface

### Supported Queries
- `get_current_milestone()` - Returns active milestone
- `get_team_by_role(role)` - Returns team member info
- `get_metrics_by_category(category)` - Returns metrics list
- `get_blocked_goals()` - Returns goals with blocked status
- `calculate_progress()` - Returns overall project progress

### Usage by Specialists
```python
# Example: Project Manager updating milestone
project_overview.update_milestone(
    milestone_id="m1",
    status="completed",
    completion_date="2025-02-10"
)

# Example: Scrum Master checking velocity
current_velocity = project_overview.get_metric("metric-001")
```