# Stakeholder Management Patterns

## Pattern Overview
**Category**: Operational  
**Problem**: Projects fail due to poor stakeholder engagement, misaligned expectations, and inadequate communication.  
**Solution**: Systematic approaches for identifying, analyzing, engaging, and managing stakeholders throughout project lifecycle.

## Context & Applicability

### When to Use
- Starting new projects or initiatives
- Implementing organizational changes
- Launching new products or services
- Managing complex multi-team projects
- Dealing with conflicting stakeholder interests

### Constraints
- Requires ongoing time investment
- Success depends on stakeholder willingness to engage
- Cultural factors may impact effectiveness

## Stakeholder Identification Patterns

### 1. Stakeholder Mapping Pattern

#### Problem
Important stakeholders are overlooked or misunderstood.

#### Solution
```yaml
stakeholder_categories:
  internal:
    - executives_sponsors
    - project_team_members
    - support_functions
    - end_users
  external:
    - customers_clients
    - suppliers_vendors
    - regulatory_bodies
    - community_groups
  classification:
    power_level: "high|medium|low"
    interest_level: "high|medium|low"
    influence: "high|medium|low"
    impact: "positive|neutral|negative"
```

#### Implementation
```javascript
const stakeholderMapping = {
  identifyStakeholders: (project) => {
    return {
      primaryStakeholders: ['direct_impact_or_influence'],
      secondaryStakeholders: ['indirect_impact_or_influence'],
      keyStakeholders: ['high_power_high_interest']
    };
  },
  
  stakeholderProfile: {
    name: 'stakeholder_name',
    role: 'job_title_or_role',
    organization: 'company_or_department',
    powerLevel: 'high|medium|low',
    interestLevel: 'high|medium|low',
    attitude: 'champion|supporter|neutral|critic|blocker',
    communicationPreference: 'email|meeting|report|dashboard',
    keyInterests: ['list_of_primary_concerns'],
    influenceNetwork: ['connected_stakeholders']
  }
};
```

### 2. Power-Interest Grid Pattern

#### Problem
Stakeholder engagement efforts are not prioritized effectively.

#### Solution
```yaml
power_interest_grid:
  high_power_high_interest:
    strategy: "manage_closely"
    actions:
      - regular_one_on_one_meetings
      - involve_in_decision_making
      - detailed_status_updates
  high_power_low_interest:
    strategy: "keep_satisfied"
    actions:
      - executive_summaries
      - key_milestone_updates
      - escalation_for_decisions
  low_power_high_interest:
    strategy: "keep_informed"
    actions:
      - regular_communications
      - detailed_project_updates
      - involve_in_planning
  low_power_low_interest:
    strategy: "monitor"
    actions:
      - minimal_communication
      - standard_reports
      - notify_of_major_changes
```

## Communication Patterns

### 1. Communication Planning Pattern

#### Problem
Stakeholders receive too much, too little, or irrelevant information.

#### Solution
```yaml
communication_plan:
  audience_segmentation:
    executives:
      content: "high_level_status_and_decisions"
      frequency: "weekly_or_monthly"
      format: "dashboard_or_summary"
    project_team:
      content: "detailed_progress_and_blockers"
      frequency: "daily_or_weekly"
      format: "standup_or_status_meeting"
    end_users:
      content: "features_and_training"
      frequency: "milestone_based"
      format: "demo_or_documentation"
  communication_methods:
    - status_reports
    - dashboard_updates
    - meetings_presentations
    - email_updates
    - collaborative_tools
```

### 2. Feedback Loop Pattern

#### Problem
Stakeholder input is not systematically collected or acted upon.

#### Solution
```yaml
feedback_mechanisms:
  collection_methods:
    - regular_surveys
    - one_on_one_interviews
    - focus_groups
    - feedback_sessions
    - suggestion_systems
  processing:
    - categorize_feedback
    - prioritize_by_impact
    - develop_response_plan
    - communicate_decisions
  follow_up:
    - acknowledge_receipt
    - provide_status_updates
    - close_the_loop
```

## Engagement Patterns

### 1. Stakeholder Journey Pattern

#### Problem
Stakeholder engagement is inconsistent across project phases.

#### Solution
```yaml
engagement_journey:
  initiation:
    activities:
      - stakeholder_identification
      - initial_meetings
      - expectation_setting
    deliverables:
      - stakeholder_register
      - communication_plan
      - engagement_strategy
  planning:
    activities:
      - requirements_gathering
      - solution_validation
      - resource_commitment
    deliverables:
      - signed_requirements
      - approved_project_plan
      - resource_agreements
  execution:
    activities:
      - regular_updates
      - change_approvals
      - issue_resolution
    deliverables:
      - status_reports
      - demo_sessions
      - decision_records
  closure:
    activities:
      - final_acceptance
      - lessons_learned
      - relationship_maintenance
    deliverables:
      - sign_off_documents
      - post_project_review
      - future_collaboration_plan
```

### 2. Resistance Management Pattern

#### Problem
Stakeholder resistance threatens project success.

#### Solution
```yaml
resistance_management:
  identification:
    signs:
      - lack_of_participation
      - negative_feedback
      - resource_constraints
      - competing_priorities
  analysis:
    - understand_root_causes
    - assess_impact_and_influence
    - identify_potential_solutions
  strategies:
    education:
      - provide_clear_rationale
      - demonstrate_benefits
      - address_concerns
    participation:
      - involve_in_solution_design
      - seek_input_on_decisions
      - create_ownership
    negotiation:
      - find_win_win_solutions
      - address_specific_concerns
      - make_compromises
    support:
      - provide_training_resources
      - offer_implementation_help
      - recognize_contributions
```

## Expectation Management Patterns

### 1. Expectation Setting Pattern

#### Problem
Misaligned expectations lead to stakeholder dissatisfaction.

#### Solution
```yaml
expectation_management:
  discovery:
    - understand_stakeholder_goals
    - identify_assumptions
    - clarify_constraints
    - document_requirements
  alignment:
    - communicate_project_scope
    - explain_limitations
    - set_realistic_timelines
    - define_success_criteria
  management:
    - regular_expectation_reviews
    - proactive_communication_of_changes
    - managed_scope_adjustments
    - transparent_progress_reporting
```

### 2. Change Communication Pattern

#### Problem
Stakeholders resist changes or are caught off-guard by them.

#### Solution
```yaml
change_communication:
  preparation:
    - assess_change_impact
    - identify_affected_stakeholders
    - develop_communication_strategy
  announcement:
    - clear_rationale_for_change
    - expected_benefits_and_impacts
    - timeline_for_implementation
    - support_available
  transition:
    - regular_progress_updates
    - address_concerns_and_questions
    - provide_training_and_support
    - celebrate_milestones
```

## Integration with AugmentedClaude

### Specialist Coordination
- **@claude/agents/domain/product-manager.md**: Customer and user stakeholder management
- **@claude/agents/orchestration/project-manager.md**: Overall stakeholder coordination
- **@claude/agents/cognitive/strategist.md**: Stakeholder strategy and alignment
- **@claude/agents/domain/ux-designer.md**: End-user stakeholder engagement

### Command Integration
- **@claude/commands/core/plan.md**: Stakeholder engagement planning
- **@claude/commands/orchestration/coordinate.md**: Multi-stakeholder coordination
- **@claude/commands/specialized/research.md**: Stakeholder analysis and feedback collection

### Memory Integration
- Stakeholder register: `@claude/memory/context/stakeholder-register.md`
- Communication history: `@claude/memory/sessions/current-session.md#stakeholder-interactions`
- Feedback tracking: `@claude/memory/knowledge/stakeholder-feedback.md`

## Digital Stakeholder Management

### 1. Stakeholder Portal Pattern

For large projects with many stakeholders:

```yaml
stakeholder_portal:
  features:
    - personalized_dashboards
    - role_based_information_access
    - feedback_submission_forms
    - document_repositories
    - communication_forums
  benefits:
    - self_service_information_access
    - reduced_communication_overhead
    - improved_transparency
    - centralized_stakeholder_hub
```

### 2. Automated Communication Pattern

```yaml
automated_communication:
  triggers:
    - milestone_completion
    - status_changes
    - deadline_approaches
    - issue_escalation
  personalization:
    - role_based_content
    - individual_preferences
    - communication_frequency
  channels:
    - email_notifications
    - dashboard_updates
    - mobile_push_notifications
    - slack_integrations
```

## Benefits & Trade-offs

### Benefits
- Improved project success rates
- Better stakeholder satisfaction
- Reduced resistance and conflicts
- Enhanced collaboration and support

### Trade-offs
- Requires significant time investment
- May slow down decision-making
- Administrative overhead
- Potential for over-communication

## Common Pitfalls

1. **One-Size-Fits-All Communication**: Same approach for all stakeholders
2. **Irregular Engagement**: Inconsistent stakeholder interaction
3. **Information Overload**: Too much detail for busy stakeholders
4. **Ignoring Informal Influencers**: Missing key opinion leaders
5. **Poor Timing**: Engaging stakeholders at wrong project phases

## Related Patterns
- @claude/patterns/operational/agile-patterns.md
- @claude/patterns/operational/continuous-improvement.md
- @claude/patterns/operational/risk-management.md
- @claude/patterns/development/requirements-gathering.md

## Best Practices

1. **Start Early**: Begin stakeholder engagement in project initiation
2. **Be Proactive**: Communicate before stakeholders ask
3. **Listen Actively**: Seek to understand before being understood
4. **Customize Approach**: Tailor engagement to stakeholder needs
5. **Manage Expectations**: Be clear about what is and isn't possible
6. **Build Relationships**: Invest in long-term stakeholder relationships
7. **Measure Effectiveness**: Track stakeholder satisfaction and engagement
8. **Stay Flexible**: Adapt approach based on feedback and results