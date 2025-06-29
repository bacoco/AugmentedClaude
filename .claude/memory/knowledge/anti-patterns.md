---
schema_version: "1.0"
last_updated: "2025-01-29T00:00:00Z"
update_mode: "runtime"
integration_points:
  - "architect"
  - "qa-tester"
  - "security"
  - "analyzer"
  - "reviewer"
---

# Anti-Patterns Catalog

## Purpose
This file maintains a comprehensive catalog of identified anti-patterns, their detection criteria, impact assessments, and resolution strategies. It is continuously updated during runtime as new anti-patterns are discovered or resolved.

## Schema Definition

### Anti-Pattern Entry
```yaml
anti_patterns:
  - id: string                # Unique identifier (e.g., "AP-001")
    name: string              # Anti-pattern name
    category: enum            # [architecture, code, process, security, performance, testing]
    severity: enum            # [critical, high, medium, low]
    status: enum              # [active, mitigated, resolved, monitoring]
    first_detected: date      # When first identified
    last_seen: date          # Most recent occurrence
    occurrences: number      # Total number of detections
    
    description: string       # Detailed description
    symptoms:                # Observable symptoms
      - string
    root_causes:             # Underlying causes
      - string
    
    detection:
      automated: boolean     # Can be automatically detected
      rules:                # Detection rules/queries
        - type: enum        # [regex, ast, metric, pattern]
          rule: string      # Detection rule
      tools:                # Tools that can detect
        - string
      false_positive_rate: number # Percentage
    
    impact:
      scope: enum           # [local, module, system, enterprise]
      performance: enum     # [none, minor, major, severe]
      security: enum        # [none, low, medium, high, critical]
      maintainability: enum # [none, low, medium, high]
      reliability: enum     # [none, low, medium, high]
      cost_estimate: string # Estimated cost of not fixing
    
    examples:               # Code/config examples
      - location: string    # File path or component
        snippet: string     # Example code
        explanation: string # Why this is problematic
    
    resolution:
      strategy: string      # How to fix
      effort: enum         # [trivial, small, medium, large, massive]
      automated_fix: boolean # Can be auto-fixed
      fix_pattern: string   # Pattern for fixing
      prevention: string    # How to prevent recurrence
      references:          # External references
        - url: string
          title: string
```

### Anti-Pattern Relationships
```yaml
relationships:
  - source_id: string       # Anti-pattern that causes
    target_id: string       # Anti-pattern that results
    relationship: enum      # [causes, correlates, prevents, conflicts]
    strength: enum          # [weak, moderate, strong]
    description: string     # Relationship explanation
```

### Resolution History
```yaml
resolutions:
  - anti_pattern_id: string # Which anti-pattern
    date: date             # When resolved
    method: string         # How it was resolved
    specialist: string     # Who resolved it
    verification: string   # How resolution was verified
    recurrence_check: date # Next check date
    notes: string         # Additional notes
```

### Monitoring Rules
```yaml
monitoring:
  - anti_pattern_id: string # Anti-pattern to monitor
    frequency: enum        # [continuous, hourly, daily, weekly]
    threshold: number      # Alert threshold
    escalation: enum       # [info, warning, error, critical]
    notification_channels: # Where to send alerts
      - string
```

## Example Entry (To be replaced during runtime)

```yaml
anti_patterns:
  - id: "AP-001"
    name: "God Object"
    category: "architecture"
    severity: "high"
    status: "active"
    first_detected: "2025-01-20"
    last_seen: "2025-01-28"
    occurrences: 3
    
    description: "A class that knows too much or does too much, violating single responsibility principle"
    symptoms:
      - "Class with more than 1000 lines of code"
      - "Class with more than 20 public methods"
      - "High coupling with many other classes"
      - "Difficult to test in isolation"
    root_causes:
      - "Lack of proper domain modeling"
      - "Incremental feature additions without refactoring"
      - "Fear of creating new classes"
    
    detection:
      automated: true
      rules:
        - type: "metric"
          rule: "LOC > 1000 OR method_count > 20 OR coupling > 10"
        - type: "pattern"
          rule: "class_name.endswith('Manager') AND method_count > 15"
      tools:
        - "SonarQube"
        - "ESLint"
        - "Custom analyzer"
      false_positive_rate: 15
    
    impact:
      scope: "module"
      performance: "minor"
      security: "none"
      maintainability: "high"
      reliability: "medium"
      cost_estimate: "40-60 hours of refactoring debt"
    
    examples:
      - location: "src/core/ApplicationManager.js"
        snippet: |
          class ApplicationManager {
            // 2500+ lines of code
            // 35 public methods
            // Handles user auth, data processing, UI state, API calls...
          }
        explanation: "This class handles multiple unrelated responsibilities"
    
    resolution:
      strategy: "Extract cohesive groups of methods into separate classes based on responsibility"
      effort: "large"
      automated_fix: false
      fix_pattern: "Extract Class refactoring for each identified responsibility"
      prevention: "Enforce class size limits in linting rules, regular code reviews"
      references:
        - url: "https://refactoring.guru/smells/large-class"
          title: "Large Class - Refactoring Guru"

  - id: "AP-002"
    name: "Callback Hell"
    category: "code"
    severity: "medium"
    status: "resolved"
    first_detected: "2025-01-15"
    last_seen: "2025-01-22"
    occurrences: 12
    
    description: "Deeply nested callbacks making code hard to read and maintain"
    symptoms:
      - "Multiple levels of nested callbacks"
      - "Pyramid-shaped code indentation"
      - "Difficult error handling"
      - "Hard to follow control flow"
    root_causes:
      - "Not using modern async patterns"
      - "Legacy code patterns"
      - "Lack of promise awareness"
    
    detection:
      automated: true
      rules:
        - type: "ast"
          rule: "callback_depth > 3"
        - type: "pattern"
          rule: "function.*function.*function.*function"
      tools:
        - "ESLint"
        - "Custom AST analyzer"
      false_positive_rate: 5
    
    impact:
      scope: "local"
      performance: "none"
      security: "low"
      maintainability: "high"
      reliability: "medium"
      cost_estimate: "2-4 hours per instance"
    
    resolution:
      strategy: "Refactor to use async/await or promises"
      effort: "medium"
      automated_fix: true
      fix_pattern: "Convert callbacks to async/await pattern"
      prevention: "Enforce async/await in code standards"
      references:
        - url: "http://callbackhell.com/"
          title: "Callback Hell"

relationships:
  - source_id: "AP-001"
    target_id: "AP-003"
    relationship: "causes"
    strength: "strong"
    description: "God objects often lead to tight coupling anti-pattern"

resolutions:
  - anti_pattern_id: "AP-002"
    date: "2025-01-22"
    method: "Automated refactoring to async/await"
    specialist: "backend-dev"
    verification: "All tests passing, code review completed"
    recurrence_check: "2025-02-22"
    notes: "Applied codemod to convert all callback patterns"

monitoring:
  - anti_pattern_id: "AP-001"
    frequency: "weekly"
    threshold: 5
    escalation: "warning"
    notification_channels:
      - "architect"
      - "tech-lead"
```

## Update Instructions

### For Runtime Updates
1. Anti-patterns should be added when detected by specialists
2. Update occurrence counts and last_seen dates automatically
3. Resolution attempts should be logged even if unsuccessful
4. Maintain relationships graph for pattern analysis

### Integration Protocol
```yaml
anti_pattern_report:
  specialist: string         # Reporting specialist
  anti_pattern: object      # Full anti-pattern entry
  evidence: array           # Supporting evidence
  suggested_priority: enum  # Suggested resolution priority
  affected_components: array # Components affected
```

### Detection Workflow
1. Specialists run detection rules during analysis
2. Matches are verified against false positive patterns
3. New instances update occurrence tracking
4. Threshold breaches trigger notifications
5. Resolution strategies are suggested

## Query Interface

### Supported Queries
- `get_active_anti_patterns()` - All unresolved anti-patterns
- `get_by_category(category)` - Filter by category
- `get_by_severity(severity)` - Filter by severity
- `get_resolution_candidates()` - Anti-patterns ready to fix
- `get_related_patterns(id)` - Related anti-patterns
- `calculate_technical_debt()` - Total cost estimate

### Usage by Specialists
```python
# Example: QA Tester reporting new anti-pattern
anti_patterns.report({
    "name": "Flaky Test",
    "category": "testing",
    "severity": "medium",
    "location": "tests/integration/user.test.js",
    "evidence": ["fails 30% of runs", "timing dependent"]
})

# Example: Architect querying for high-severity issues
critical_issues = anti_patterns.get_by_severity("high")
```

## Anti-Pattern Metrics
- **Detection Rate**: New anti-patterns per week
- **Resolution Rate**: Fixed anti-patterns per sprint  
- **Recurrence Rate**: Percentage that reappear
- **Mean Time to Resolution**: Average fix time
- **Technical Debt**: Total estimated hours

## Prevention Strategies
1. **Automated Checks**: Pre-commit hooks and CI/CD gates
2. **Code Reviews**: Checklist includes anti-pattern detection
3. **Education**: Team training on common anti-patterns
4. **Refactoring Sprints**: Dedicated time for debt reduction
5. **Pattern Libraries**: Positive patterns to follow