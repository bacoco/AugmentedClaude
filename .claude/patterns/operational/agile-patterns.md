# Agile Patterns

## Pattern Overview
**Category**: Operational  
**Problem**: Teams need structured approaches to implement agile methodologies effectively while maintaining quality and predictability.  
**Solution**: Proven patterns for sprint planning, execution, retrospectives, and scaling agile practices.

## Context & Applicability

### When to Use
- Implementing or improving agile development processes
- Teams transitioning from waterfall to agile methodologies
- Scaling agile practices across multiple teams
- Optimizing sprint planning and execution

### Constraints
- Requires team commitment to agile principles
- May need organizational culture changes
- Effectiveness depends on consistent application

## Implementation Patterns

### 1. Sprint Planning Pattern

#### Problem
Teams struggle with effective sprint planning, leading to overcommitment or underutilization.

#### Solution
```yaml
sprint_planning:
  duration: "2-4 hours for 2-week sprint"
  participants:
    - product_owner
    - scrum_master
    - development_team
  phases:
    capacity_planning:
      - review_team_availability
      - calculate_sprint_capacity
      - account_for_holidays_pto
    backlog_refinement:
      - review_prioritized_backlog
      - clarify_user_stories
      - estimate_story_points
    commitment:
      - select_sprint_goal
      - choose_user_stories
      - validate_capacity_vs_commitment
```

#### Implementation
1. **Capacity Calculation**
   ```javascript
   const calculateSprintCapacity = (teamMembers, sprintDays, focusFactor = 0.7) => {
     return teamMembers.reduce((total, member) => {
       const availableDays = sprintDays - member.plannedTimeOff;
       return total + (availableDays * member.dailyCapacity * focusFactor);
     }, 0);
   };
   ```

2. **Story Point Estimation**
   - Use planning poker for team consensus
   - Reference historical velocity data
   - Break down large stories (>8 points)

### 2. Daily Standup Pattern

#### Problem
Daily standups become status meetings rather than coordination tools.

#### Solution
```yaml
daily_standup:
  format: "3-question structure"
  timebox: "15 minutes maximum"
  focus: "coordination and impediment removal"
  questions:
    - "What did you complete yesterday?"
    - "What will you work on today?"
    - "What impediments are blocking you?"
  anti_patterns:
    - status_reporting_to_manager
    - detailed_technical_discussions
    - problem_solving_in_standup
```

### 3. Sprint Retrospective Pattern

#### Problem
Retrospectives become routine without driving meaningful improvement.

#### Solution
```yaml
retrospective_framework:
  frequency: "end of each sprint"
  duration: "1-2 hours"
  structure:
    opening: "set_the_stage (5 min)"
    data_gathering: "gather_data (20 min)"
    insights: "generate_insights (30 min)"
    actions: "decide_what_to_do (15 min)"
    closing: "close_retrospective (5 min)"
  techniques:
    - start_stop_continue
    - mad_sad_glad
    - five_whys
    - fishbone_diagram
```

### 4. Backlog Grooming Pattern

#### Problem
Product backlog becomes cluttered with unclear or outdated items.

#### Solution
```yaml
backlog_grooming:
  frequency: "weekly or bi-weekly"
  participants:
    - product_owner (required)
    - development_team
    - stakeholders (as needed)
  activities:
    refinement:
      - clarify_user_stories
      - add_acceptance_criteria
      - estimate_effort
    prioritization:
      - business_value_assessment
      - technical_dependency_analysis
      - risk_evaluation
    maintenance:
      - remove_obsolete_items
      - split_large_stories
      - update_story_status
```

## Scaling Patterns

### 1. Scrum of Scrums Pattern

For multiple teams working on related products:

```yaml
scrum_of_scrums:
  frequency: "daily or 3x per week"
  participants: "representative from each team"
  duration: "15-30 minutes"
  questions:
    - "What has your team accomplished since last meeting?"
    - "What will your team do before next meeting?"
    - "Are there any impediments or dependencies?"
    - "Are you about to put something in another team's way?"
```

### 2. SAFe Program Increment Pattern

For enterprise scaling:

```yaml
program_increment:
  duration: "8-12 weeks"
  structure:
    pi_planning: "2 days"
    development: "5 sprints"
    innovation_sprint: "1 sprint"
  ceremonies:
    - pi_planning
    - system_demo
    - inspect_and_adapt
  artifacts:
    - program_board
    - pi_objectives
    - feature_roadmap
```

## Quality Patterns

### 1. Definition of Done Pattern

```yaml
definition_of_done:
  code_quality:
    - unit_tests_written_and_passing
    - code_review_completed
    - static_analysis_passing
  integration:
    - integration_tests_passing
    - deployed_to_staging
    - qa_testing_completed
  documentation:
    - user_documentation_updated
    - technical_documentation_current
  acceptance:
    - acceptance_criteria_met
    - product_owner_approval
```

### 2. Continuous Integration Pattern

```yaml
ci_practices:
  commit_frequency: "multiple times per day"
  build_automation: "triggered on every commit"
  test_automation: "comprehensive test suite"
  feedback_loop: "fast failure notification"
  deployment: "automated to staging"
```

## Integration with AugmentedClaude

### Specialist Coordination
- **@claude/agents/orchestration/scrum-master.md**: Facilitates ceremonies and removes impediments
- **@claude/agents/domain/product-manager.md**: Manages backlog and prioritization
- **@claude/agents/orchestration/project-manager.md**: Coordinates across teams
- **@claude/agents/technical/qa-tester.md**: Ensures quality standards

### Command Integration
- **@claude/commands/core/plan.md**: Sprint and release planning
- **@claude/commands/orchestration/coordinate.md**: Multi-team coordination
- **@claude/commands/core/review.md**: Sprint reviews and retrospectives

### Memory Integration
- Store team velocity: `@claude/memory/knowledge/team-metrics.md`
- Track impediments: `@claude/memory/sessions/current-session.md#impediments`
- Retrospective actions: `@claude/memory/knowledge/improvement-actions.md`

## Benefits & Trade-offs

### Benefits
- Improved team collaboration and communication
- Faster feedback loops and adaptation
- Better visibility into progress and blockers
- Increased customer satisfaction through regular delivery

### Trade-offs
- Requires cultural shift and training
- May feel chaotic initially compared to waterfall
- Overhead of ceremonies and meetings
- Needs commitment from entire organization

## Common Pitfalls

1. **Agile Theater**: Going through motions without embracing principles
2. **Over-Planning**: Trying to plan everything upfront
3. **Ignoring Technical Debt**: Focusing only on features
4. **Skipping Retrospectives**: Missing improvement opportunities
5. **Waterfall in Disguise**: Fixed scope and timeline with agile ceremonies

## Related Patterns
- @claude/patterns/operational/continuous-improvement.md
- @claude/patterns/operational/stakeholder-management.md
- @claude/patterns/development/testing-patterns.md
- @claude/patterns/operational/deployment-patterns.md

## Best Practices

1. **Start Small**: Begin with one team before scaling
2. **Invest in Training**: Ensure team understands agile principles
3. **Focus on Value**: Always connect work to business outcomes
4. **Measure and Adapt**: Use metrics to drive continuous improvement
5. **Embrace Failure**: Treat failures as learning opportunities
6. **Customer Collaboration**: Regular feedback from end users
7. **Sustainable Pace**: Avoid burnout through realistic planning