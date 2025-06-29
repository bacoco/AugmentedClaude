---
schema_version: "1.0"
last_updated: "2025-01-29T00:00:00Z"
update_mode: "runtime"
integration_points:
  - "project-manager"
  - "scrum-master"
  - "architect"
  - "qa-tester"
  - "all-specialists"
---

# Lessons Learned Repository

## Purpose
This file captures experiential knowledge from project activities, incidents, and decisions. It serves as an organizational memory to prevent repeated mistakes and propagate successful approaches across the team and future projects.

## Schema Definition

### Lesson Entry
```yaml
lessons:
  - id: string              # Unique identifier (e.g., "LL-001")
    title: string           # Brief lesson title
    category: enum          # [technical, process, communication, planning, risk, quality]
    tags:                   # Searchable tags
      - string
    severity: enum          # [minor, moderate, major, critical]
    date_learned: date      # When the lesson was learned
    
    context:
      project_phase: enum   # [planning, design, development, testing, deployment, maintenance]
      team_size: number     # Team size at the time
      timeline: string      # Timeline context
      environment: string   # Technical/business environment
    
    situation:
      description: string   # What happened
      root_cause: string    # Why it happened
      contributing_factors: # Other factors
        - string
      initial_impact: string # Immediate consequences
    
    lesson:
      summary: string       # Key takeaway
      detailed: string      # Detailed explanation
      type: enum           # [mistake-to-avoid, success-to-repeat, insight-gained]
    
    outcomes:
      positive:             # Positive results
        - string
      negative:             # Negative results
        - string
      metrics:              # Measurable impacts
        - name: string
          before: string
          after: string
    
    recommendations:
      - action: string      # Recommended action
        owner: string       # Who should implement
        priority: enum      # [low, medium, high, critical]
        status: enum        # [pending, in-progress, implemented]
    
    prevention:
      process_changes:      # Process improvements
        - string
      tool_changes:         # Tool improvements
        - string
      training_needs:       # Training requirements
        - string
    
    applicability:
      scope: enum          # [project-specific, team-wide, organization-wide, industry-wide]
      conditions:          # When this lesson applies
        - string
      exceptions:          # When it doesn't apply
        - string
    
    validation:
      verified_by: string   # Who validated the lesson
      verification_date: date
      verification_method: string
      confidence_level: enum # [low, medium, high]
```

### Lesson Categories
```yaml
categories:
  technical:
    subcategories:
      - architecture_decisions
      - technology_choices
      - performance_optimization
      - security_practices
      - integration_challenges
  
  process:
    subcategories:
      - agile_practices
      - communication_flows
      - documentation_standards
      - review_processes
      - deployment_procedures
  
  communication:
    subcategories:
      - stakeholder_management
      - team_collaboration
      - requirement_gathering
      - status_reporting
      - conflict_resolution
  
  planning:
    subcategories:
      - estimation_accuracy
      - resource_allocation
      - risk_assessment
      - timeline_management
      - scope_control
  
  risk:
    subcategories:
      - technical_risks
      - business_risks
      - security_risks
      - compliance_risks
      - operational_risks
  
  quality:
    subcategories:
      - testing_strategies
      - code_quality
      - review_effectiveness
      - defect_prevention
      - user_satisfaction
```

### Impact Analysis
```yaml
impact_tracking:
  - lesson_id: string      # Lesson identifier
    implementations:       # Where lesson was applied
      - location: string   # Project/component
        date: date        # When applied
        result: enum      # [successful, partial, failed]
        notes: string     # Implementation notes
    prevented_issues: number # Issues prevented
    time_saved: string    # Estimated time saved
    cost_saved: string    # Estimated cost saved
```

## Example Entry (To be replaced during runtime)

```yaml
lessons:
  - id: "LL-001"
    title: "Database Migration Without Downtime"
    category: "technical"
    tags: ["database", "migration", "zero-downtime", "postgresql"]
    severity: "major"
    date_learned: "2025-01-22"
    
    context:
      project_phase: "deployment"
      team_size: 8
      timeline: "Q1 2025 release"
      environment: "Production system with 10k active users"
    
    situation:
      description: "Attempted to migrate database schema during business hours resulted in 2-hour outage"
      root_cause: "Migration script locked critical tables preventing read operations"
      contributing_factors:
        - "Insufficient testing on production-scale data"
        - "No rollback plan prepared"
        - "Underestimated migration duration"
      initial_impact: "2-hour service outage, 500+ support tickets"
    
    lesson:
      summary: "Always use online migration techniques for production databases"
      detailed: "Production database migrations must use non-blocking techniques like creating new columns/tables first, dual-writing, then switching over. Never use ALTER TABLE on large tables without CONCURRENTLY option in PostgreSQL."
      type: "mistake-to-avoid"
    
    outcomes:
      positive:
        - "Team learned proper migration techniques"
        - "Created comprehensive migration playbook"
      negative:
        - "Customer trust impacted"
        - "Revenue loss during outage"
      metrics:
        - name: "Downtime"
          before: "0 minutes (expected)"
          after: "120 minutes (actual)"
        - name: "Customer complaints"
          before: "0"
          after: "500+"
    
    recommendations:
      - action: "Implement blue-green database deployment strategy"
        owner: "devops"
        priority: "critical"
        status: "implemented"
      - action: "Create migration testing environment with production data volume"
        owner: "backend-dev"
        priority: "high"
        status: "in-progress"
    
    prevention:
      process_changes:
        - "All migrations must be tested on production-clone first"
        - "Require dual-write period for schema changes"
        - "Mandatory rollback plan for all migrations"
      tool_changes:
        - "Implement pg_repack for online table maintenance"
        - "Add migration duration estimation tools"
      training_needs:
        - "PostgreSQL administration best practices"
        - "Zero-downtime deployment strategies"
    
    applicability:
      scope: "organization-wide"
      conditions:
        - "Any production database migration"
        - "Tables with more than 1M rows"
        - "High-availability requirements"
      exceptions:
        - "Maintenance windows approved by business"
        - "Non-critical systems"
    
    validation:
      verified_by: "architect"
      verification_date: "2025-01-25"
      verification_method: "Successfully applied technique in next migration"
      confidence_level: "high"

  - id: "LL-002"
    title: "Early Stakeholder Involvement Reduces Rework"
    category: "process"
    tags: ["stakeholder", "requirements", "communication", "agile"]
    severity: "moderate"
    date_learned: "2025-01-18"
    
    context:
      project_phase: "development"
      team_size: 6
      timeline: "Sprint 3 of 8"
      environment: "New customer portal development"
    
    situation:
      description: "Built complete user dashboard based on initial requirements, required 80% rebuild after stakeholder review"
      root_cause: "Key stakeholders not involved in early design reviews"
      contributing_factors:
        - "Assumed product owner represented all stakeholder needs"
        - "No prototype validation with end users"
        - "Written requirements misinterpreted"
      initial_impact: "3-week delay, team morale impact"
    
    lesson:
      summary: "Involve all key stakeholders in design reviews before implementation"
      detailed: "Product owner alone cannot represent all stakeholder perspectives. Direct stakeholder involvement in wireframe and prototype reviews prevents expensive rework. Visual prototypes communicate better than written specs."
      type: "success-to-repeat"
    
    outcomes:
      positive:
        - "Established weekly stakeholder demo sessions"
        - "Improved requirement clarity process"
      negative:
        - "Sprint velocity reduced by 50%"
        - "Technical debt from rushed refactoring"
      metrics:
        - name: "Rework percentage"
          before: "80%"
          after: "< 10% (in subsequent sprints)"

impact_tracking:
  - lesson_id: "LL-001"
    implementations:
      - location: "User Service Database Migration"
        date: "2025-01-28"
        result: "successful"
        notes: "Zero downtime achieved using learned techniques"
    prevented_issues: 1
    time_saved: "~4 hours of downtime"
    cost_saved: "$50,000 (estimated revenue protection)"
```

## Update Instructions

### For Runtime Updates
1. Capture lessons immediately after incidents or milestones
2. Include both successes and failures
3. Focus on actionable insights
4. Link to relevant documentation and evidence
5. Update impact tracking as lessons are applied

### Integration Protocol
```yaml
lesson_submission:
  specialist: string        # Submitting specialist
  lesson: object           # Full lesson entry
  evidence: array          # Supporting documentation
  stakeholders: array      # Who should review
  urgency: enum           # [low, normal, high, immediate]
```

### Review Process
1. **Initial Capture**: Any specialist can submit
2. **Validation**: Technical review by relevant specialists
3. **Approval**: Project manager or architect approval
4. **Distribution**: Shared with affected teams
5. **Implementation**: Recommendations tracked
6. **Follow-up**: Impact measurement

## Query Interface

### Supported Queries
- `get_recent_lessons(days)` - Recent lessons
- `get_by_category(category)` - Filter by category
- `get_by_severity(severity)` - Filter by severity
- `get_applicable_lessons(context)` - Context-relevant lessons
- `get_unimplemented_recommendations()` - Pending actions
- `search_lessons(query)` - Full-text search

### Usage by Specialists
```python
# Example: Project Manager checking lessons before planning
planning_lessons = lessons_learned.get_by_category("planning")

# Example: Architect reviewing technical lessons
tech_lessons = lessons_learned.get_by_tags(["architecture", "performance"])
```

## Metrics and Reporting
- **Lesson Capture Rate**: Lessons per sprint/incident
- **Implementation Rate**: Recommendations implemented
- **Recurrence Prevention**: Similar issues prevented
- **Value Generated**: Time/cost saved from lessons
- **Knowledge Spread**: Teams applying lessons

## Organizational Learning Loop
1. **Experience**: Project activities and incidents
2. **Reflection**: Post-mortem and retrospectives
3. **Conceptualization**: Lesson extraction and documentation
4. **Application**: Implementing recommendations
5. **Measurement**: Tracking impact and effectiveness
6. **Sharing**: Cross-team knowledge transfer