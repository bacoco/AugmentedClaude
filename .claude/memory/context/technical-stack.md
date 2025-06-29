---
schema_version: "1.0"
last_updated: "2025-01-29T00:00:00Z"
update_mode: "runtime"
integration_points:
  - "architect"
  - "backend-dev"
  - "frontend-dev"
  - "devops"
  - "system-integrator"
---

# Technical Stack

## Purpose
This file maintains the comprehensive technical stack information including technologies, versions, architecture decisions, and migration history. It is updated during runtime by technical specialists.

## Schema Definition

### Technology Categories
```yaml
technologies:
  frontend:
    - name: string            # Technology name
      version: string         # Current version
      role: string           # Primary use case
      dependencies:          # Direct dependencies
        - name: string
          version: string
      status: enum           # [active, deprecated, migrating, evaluating]
      introduced: date       # When adopted
      sunset_date: date      # Planned deprecation date (if applicable)
  
  backend:
    - name: string
      version: string
      role: string
      runtime: string        # Runtime environment
      frameworks:            # Associated frameworks
        - name: string
          version: string
      status: enum
      introduced: date
  
  database:
    - name: string
      version: string
      type: enum            # [relational, document, key-value, graph, time-series]
      role: string          # Primary use case
      connection_string: string # Template (with placeholders)
      status: enum
      introduced: date
  
  infrastructure:
    - name: string
      version: string
      provider: string      # Cloud/hosting provider
      service_type: enum    # [compute, storage, networking, security, monitoring]
      configuration:        # Key configuration details
        key: value
      status: enum
      introduced: date
  
  tools:
    - name: string
      version: string
      category: enum        # [build, test, deploy, monitor, security]
      configuration_file: string # Path to config
      status: enum
      introduced: date
```

### Architecture Decisions
```yaml
decisions:
  - id: string              # ADR number (e.g., "ADR-001")
    title: string           # Decision title
    status: enum            # [proposed, accepted, deprecated, superseded]
    date: date              # Decision date
    context: string         # Why this decision was needed
    decision: string        # What was decided
    rationale: string       # Why this approach
    consequences: string    # Trade-offs and impacts
    alternatives:           # Other options considered
      - option: string
        reason_rejected: string
    superseded_by: string   # ADR ID if superseded
```

### Version Control
```yaml
version_control:
  - component: string       # Component name
    current_version: string # Current version
    target_version: string  # Target version (if upgrading)
    last_updated: date      # Last version update
    update_frequency: enum  # [daily, weekly, monthly, quarterly, as-needed]
    breaking_changes:       # Known breaking changes
      - version: string
        description: string
        migration_guide: string
```

### Migration History
```yaml
migrations:
  - id: string             # Migration identifier
    type: enum             # [upgrade, replacement, consolidation, split]
    from_technology: string # Source technology
    to_technology: string   # Target technology
    start_date: date       # Migration start
    completion_date: date  # Migration end (null if ongoing)
    status: enum           # [planning, in-progress, completed, rolled-back]
    reason: string         # Why migrating
    impact:                # Impact assessment
      downtime: string     # Expected/actual downtime
      risk_level: enum     # [low, medium, high, critical]
      affected_components: # List of affected parts
        - string
    rollback_plan: string  # How to rollback if needed
```

### Integration Matrix
```yaml
integrations:
  - source: string         # Source system
    target: string         # Target system
    type: enum            # [api, message-queue, database, file, event]
    protocol: string      # Communication protocol
    authentication: enum  # [none, api-key, oauth, jwt, certificate]
    data_format: enum     # [json, xml, protobuf, avro, custom]
    status: enum          # [active, deprecated, planned]
    documentation: string # Link to integration docs
```

## Example Entry (To be replaced during runtime)

```yaml
technologies:
  frontend:
    - name: "React"
      version: "18.2.0"
      role: "Primary UI framework"
      dependencies:
        - name: "react-dom"
          version: "18.2.0"
        - name: "react-router"
          version: "6.8.0"
      status: "active"
      introduced: "2025-01-15"
      sunset_date: null

  backend:
    - name: "Node.js"
      version: "20.11.0"
      role: "Primary runtime"
      runtime: "V8"
      frameworks:
        - name: "Express"
          version: "4.18.2"
        - name: "TypeScript"
          version: "5.3.3"
      status: "active"
      introduced: "2025-01-15"

  database:
    - name: "PostgreSQL"
      version: "15.5"
      type: "relational"
      role: "Primary data store"
      connection_string: "postgresql://{{user}}:{{password}}@{{host}}:5432/{{database}}"
      status: "active"
      introduced: "2025-01-15"

  infrastructure:
    - name: "AWS EC2"
      version: "current"
      provider: "AWS"
      service_type: "compute"
      configuration:
        instance_type: "t3.medium"
        region: "us-east-1"
        auto_scaling: true
      status: "active"
      introduced: "2025-01-20"

decisions:
  - id: "ADR-001"
    title: "Use React for Frontend Development"
    status: "accepted"
    date: "2025-01-10"
    context: "Need a modern, component-based UI framework with strong ecosystem"
    decision: "Adopt React as the primary frontend framework"
    rationale: "React provides excellent performance, large community, and extensive tooling"
    consequences: "Team needs React expertise, bundle size considerations, state management complexity"
    alternatives:
      - option: "Vue.js"
        reason_rejected: "Smaller ecosystem and less team familiarity"
      - option: "Angular"
        reason_rejected: "Steeper learning curve and more opinionated structure"
    superseded_by: null

migrations:
  - id: "MIG-001"
    type: "upgrade"
    from_technology: "Node.js 16.x"
    to_technology: "Node.js 20.x"
    start_date: "2025-02-01"
    completion_date: null
    status: "planning"
    reason: "EOL for Node 16, performance improvements in Node 20"
    impact:
      downtime: "0 minutes (rolling update)"
      risk_level: "medium"
      affected_components:
        - "API servers"
        - "Background workers"
    rollback_plan: "Blue-green deployment allows instant rollback"

integrations:
  - source: "Frontend"
    target: "Backend API"
    type: "api"
    protocol: "HTTPS/REST"
    authentication: "jwt"
    data_format: "json"
    status: "active"
    documentation: "/docs/api/integration"
```

## Update Instructions

### For Runtime Updates
1. Use atomic updates for version changes
2. Maintain historical data in migration section
3. Update decision records when superseding
4. Validate compatibility before updates

### Integration Protocol
```yaml
tech_update:
  specialist: string        # Requesting specialist
  category: string         # Technology category
  operation: enum          # [add, update, deprecate, remove]
  technology: object       # Technology details
  impact_analysis: object  # Affected components
  rollback_plan: string    # How to revert if needed
```

### Validation Rules
- Version strings must follow semantic versioning where applicable
- Status transitions must follow valid paths
- Dependencies must exist in the stack
- Migration plans must include rollback procedures
- All dates must be ISO 8601 format

## Query Interface

### Supported Queries
- `get_technology_by_role(role)` - Find technology serving specific role
- `get_dependencies(technology)` - List all dependencies
- `check_compatibility(tech1, tech2)` - Verify compatibility
- `get_migration_status()` - Current migration activities
- `get_deprecated_technologies()` - Technologies to phase out
- `get_integration_map()` - Full integration matrix

### Usage by Specialists
```python
# Example: Architect adding new technology
technical_stack.add_technology(
    category="frontend",
    technology={
        "name": "TailwindCSS",
        "version": "3.4.0",
        "role": "Utility-first CSS framework",
        "status": "evaluating"
    }
)

# Example: DevOps checking infrastructure
current_infra = technical_stack.get_category("infrastructure")
```

## Dependency Graph
The system automatically maintains a dependency graph that can be queried:
- Direct dependencies
- Transitive dependencies  
- Circular dependency detection
- Version conflict identification
- Update impact analysis