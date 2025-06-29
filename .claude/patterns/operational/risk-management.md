# Risk Management Patterns

## Pattern Overview
**Category**: Operational  
**Problem**: Organizations struggle to systematically identify, assess, and mitigate risks that could impact project success or business operations.  
**Solution**: Structured approaches for risk identification, assessment, mitigation planning, and ongoing monitoring.

## Context & Applicability

### When to Use
- Starting new projects or initiatives
- Operating in uncertain or changing environments
- Implementing new technologies or processes
- Facing regulatory or compliance requirements
- Managing critical business operations

### Constraints
- Requires dedicated time and resources
- Effectiveness depends on organizational maturity
- May slow down decision-making if overdone

## Risk Identification Patterns

### 1. Systematic Risk Assessment Pattern

#### Problem
Risks are identified reactively rather than proactively.

#### Solution
```yaml
risk_identification:
  categories:
    technical:
      - technology_failure
      - integration_complexity
      - scalability_limitations
      - security_vulnerabilities
    business:
      - market_changes
      - competitive_threats
      - regulatory_changes
      - customer_requirements
    operational:
      - resource_availability
      - skill_gaps
      - process_dependencies
      - supplier_reliability
    external:
      - economic_conditions
      - natural_disasters
      - political_instability
      - pandemic_impacts
  methods:
    - brainstorming_sessions
    - expert_interviews
    - historical_analysis
    - scenario_planning
    - swot_analysis
```

#### Implementation
```javascript
const riskIdentification = {
  conductRiskWorkshop: (projectContext) => {
    return {
      participants: ['stakeholders', 'subject_matter_experts', 'team_leads'],
      techniques: ['brainstorming', 'affinity_mapping', 'impact_analysis'],
      outputs: ['risk_register', 'risk_categories', 'initial_assessments']
    };
  },
  
  riskRegister: {
    id: 'unique_identifier',
    title: 'short_description',
    description: 'detailed_description',
    category: 'technical|business|operational|external',
    probability: 'low|medium|high',
    impact: 'low|medium|high',
    owner: 'responsible_person',
    status: 'open|mitigated|closed|accepted'
  }
};
```

### 2. Risk Assessment Matrix Pattern

#### Problem
Inconsistent risk evaluation leads to poor prioritization.

#### Solution
```yaml
risk_assessment_matrix:
  probability_scale:
    low: "< 20% chance of occurring"
    medium: "20-60% chance of occurring"
    high: "> 60% chance of occurring"
  impact_scale:
    low: "minimal impact on objectives"
    medium: "moderate impact, manageable"
    high: "severe impact, project threatening"
  risk_levels:
    low_risk: "probability: low, impact: low|medium"
    medium_risk: "probability: medium, impact: low|medium OR probability: low, impact: high"
    high_risk: "probability: medium|high, impact: high"
```

## Risk Mitigation Patterns

### 1. Four T's Risk Response Pattern

#### Problem
Limited range of risk response strategies considered.

#### Solution
```yaml
risk_response_strategies:
  transfer:
    description: "shift risk to third party"
    examples:
      - insurance_coverage
      - outsourcing_to_specialists
      - contractual_risk_transfer
  tolerate:
    description: "accept risk and its consequences"
    examples:
      - risk_below_tolerance_threshold
      - cost_of_mitigation_exceeds_impact
      - time_constraints_prevent_mitigation
  treat:
    description: "reduce probability or impact"
    examples:
      - additional_testing
      - redundancy_implementation
      - process_improvements
  terminate:
    description: "eliminate risk by avoiding activity"
    examples:
      - project_scope_reduction
      - technology_alternative_selection
      - process_redesign
```

### 2. Contingency Planning Pattern

#### Problem
No clear plan when risks materialize.

#### Solution
```yaml
contingency_planning:
  trigger_conditions:
    - specific_metrics_or_events
    - early_warning_indicators
    - threshold_breaches
  response_actions:
    - immediate_steps
    - resource_allocation
    - communication_plan
    - escalation_procedures
  roles_responsibilities:
    - decision_makers
    - action_owners
    - communication_coordinators
```

## Risk Monitoring Patterns

### 1. Risk Dashboard Pattern

#### Problem
Risk status is not visible or regularly communicated.

#### Solution
```yaml
risk_dashboard:
  key_metrics:
    - total_risks_by_category
    - risk_trend_over_time
    - mitigation_progress
    - new_risks_identified
  visualization:
    - risk_heat_map
    - trend_charts
    - status_indicators
    - progress_meters
  reporting_frequency:
    - daily_for_high_risks
    - weekly_for_medium_risks
    - monthly_for_low_risks
```

### 2. Early Warning System Pattern

#### Problem
Risks materialize without advance warning.

#### Solution
```yaml
early_warning_system:
  indicators:
    technical:
      - performance_degradation
      - error_rate_increases
      - security_scan_results
    business:
      - market_indicators
      - customer_feedback_trends
      - competitor_actions
    operational:
      - resource_utilization
      - team_velocity_changes
      - dependency_delays
  thresholds:
    - yellow_alert_levels
    - red_alert_levels
    - escalation_triggers
  automated_monitoring:
    - metric_collection
    - threshold_checking
    - alert_generation
```

## Specialized Risk Patterns

### 1. Technical Risk Management Pattern

For software development projects:

```yaml
technical_risk_management:
  architecture_risks:
    - scalability_bottlenecks
    - single_points_of_failure
    - technology_obsolescence
  implementation_risks:
    - code_quality_issues
    - integration_failures
    - performance_problems
  mitigation_strategies:
    - proof_of_concepts
    - architecture_reviews
    - continuous_testing
    - code_quality_gates
```

### 2. Security Risk Management Pattern

```yaml
security_risk_management:
  threat_modeling:
    - identify_assets
    - identify_threats
    - identify_vulnerabilities
    - assess_risk_levels
  security_controls:
    - preventive_controls
    - detective_controls
    - corrective_controls
  incident_response:
    - preparation
    - detection_analysis
    - containment_eradication
    - recovery_lessons_learned
```

## Integration with AugmentedClaude

### Specialist Coordination
- **@claude/agents/orchestration/project-manager.md**: Overall risk management coordination
- **@claude/agents/cognitive/strategist.md**: Strategic risk assessment and planning
- **@claude/agents/cognitive/analyzer.md**: Risk analysis and impact assessment
- **@claude/agents/technical/security.md**: Security risk management

### Command Integration
- **@claude/commands/core/analyze.md**: Risk analysis and assessment
- **@claude/commands/core/plan.md**: Risk mitigation planning
- **@claude/commands/specialized/secure.md**: Security risk management
- **@claude/commands/core/troubleshoot.md**: Risk materialization response

### Memory Integration
- Risk register: `@claude/memory/knowledge/risk-register.md`
- Mitigation strategies: `@claude/memory/knowledge/risk-mitigations.md`
- Lessons learned: `@claude/memory/knowledge/lessons-learned.md`

## Risk Governance Patterns

### 1. Risk Committee Pattern

#### Problem
No clear governance structure for risk management.

#### Solution
```yaml
risk_governance:
  risk_committee:
    composition:
      - senior_management
      - technical_leads
      - business_stakeholders
    responsibilities:
      - risk_strategy_approval
      - resource_allocation
      - escalation_decisions
  risk_reporting:
    frequency: "monthly or quarterly"
    content:
      - risk_status_summary
      - new_risks_identified
      - mitigation_progress
      - trend_analysis
```

## Benefits & Trade-offs

### Benefits
- Proactive identification and management of potential issues
- Better decision-making with risk information
- Reduced impact when risks materialize
- Improved stakeholder confidence

### Trade-offs
- Requires time and resources for risk activities
- May slow down decision-making
- Can create risk-averse culture if overdone
- Administrative overhead

## Common Pitfalls

1. **Risk Paralysis**: Over-analyzing risks without taking action
2. **Risk Theater**: Going through motions without real commitment
3. **Optimism Bias**: Underestimating probability or impact
4. **Static Risk Register**: Not updating risk assessments regularly
5. **One-Size-Fits-All**: Using same approach for all risk types

## Related Patterns
- @claude/patterns/operational/continuous-improvement.md
- @claude/patterns/operational/agile-patterns.md
- @claude/patterns/development/security-patterns.md
- @claude/patterns/operational/monitoring-patterns.md

## Best Practices

1. **Make Risk Management Part of Culture**: Embed in regular processes
2. **Keep It Practical**: Focus on actionable risks and responses
3. **Regular Updates**: Review and update risk assessments frequently
4. **Clear Ownership**: Assign specific people to manage each risk
5. **Learn from Experience**: Update processes based on outcomes
6. **Balance Rigor with Speed**: Don't let risk management slow down innovation
7. **Communicate Clearly**: Make risk information accessible to stakeholders