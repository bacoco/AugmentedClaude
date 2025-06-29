# Validate Command

## Purpose
Comprehensive validation and verification command for ensuring quality, compliance, and correctness across code, configurations, and systems.

## Specialist Integration
- **Primary**: @claude/agents/technical/qa-tester.md
- **Supporting**: @claude/agents/technical/security.md, @claude/agents/cognitive/analyzer.md

## Command Syntax
```
@claude/commands/core/validate.md [--type] [--scope] [--level] [--standards]
```

## Parameters
- `--type`: Validation type (code-quality, security, performance, compliance, integration)
- `--scope`: Validation scope (component, service, system, end-to-end)
- `--level`: Validation level (basic, comprehensive, exhaustive)
- `--standards`: Standards to validate against (industry, internal, regulatory)

## Usage Examples

### Code Quality Validation
```
@claude/commands/core/validate.md --type=code-quality --scope=component --level=comprehensive
```
**Activates**: @claude/agents/technical/qa-tester.md for quality assessment
**Tools**: @claude/integrations/sequential.md for static analysis and linting
**Patterns**: @claude/patterns/development/quality-patterns.md, @claude/patterns/development/testing-patterns.md

### Security Validation
```
@claude/commands/core/validate.md --type=security --scope=system --standards=industry --specialist=@claude/agents/technical/security.md
```
**Activates**: @claude/agents/technical/security.md for security assessment
**Tools**: @claude/integrations/magic.md for vulnerability scanning
**Patterns**: @claude/patterns/development/security-patterns.md, @claude/patterns/operational/security-validation.md

### Performance Validation
```
@claude/commands/core/validate.md --type=performance --scope=end-to-end --level=exhaustive
```
**Activates**: @claude/agents/cognitive/analyzer.md, @claude/agents/technical/qa-tester.md
**Tools**: @claude/integrations/sequential.md for performance testing
**Patterns**: @claude/patterns/operational/performance-patterns.md

## Execution Workflow

### Phase 1: Validation Planning
1. **Scope Assessment**
   - Identify components and systems to validate
   - Define validation criteria and success metrics
   - Select appropriate validation methodologies

2. **Resource Preparation**
   - Configure validation tools and environments
   - Prepare test data and scenarios
   - Set up monitoring and reporting systems

### Phase 2: Static Validation
1. **Code Analysis**
   - Static code analysis and linting
   - Dependency vulnerability scanning
   - Configuration file validation

2. **Compliance Checking**
   - Coding standards verification
   - Architecture pattern compliance
   - Documentation completeness review

### Phase 3: Dynamic Validation
1. **Functional Testing**
   - Unit test execution and coverage analysis
   - Integration test validation
   - System behavior verification

2. **Non-Functional Testing**
   - Performance and load testing
   - Security penetration testing
   - Scalability and reliability assessment

### Phase 4: Reporting & Remediation
1. **Results Analysis**
   - Aggregate validation results and metrics
   - Identify critical issues and patterns
   - Generate comprehensive validation reports

2. **Remediation Planning**
   - Prioritize issues by severity and impact
   - Create remediation action plans
   - Track resolution progress and validation

## Integration Points
- **Testing**: Core testing framework through @claude/commands/core/test.md
- **Security**: Security validation via @claude/agents/technical/security.md
- **Building**: Pre-build validation in @claude/commands/core/build.md workflow
- **Deployment**: Pre-deployment validation in @claude/commands/core/deploy.md

## Success Criteria
- [ ] All critical validation checks passed
- [ ] Code quality metrics within acceptable ranges
- [ ] Security vulnerabilities addressed
- [ ] Performance requirements met
- [ ] Compliance standards satisfied
- [ ] Comprehensive validation report generated

## Memory & Context Usage
- **Validation History**: @claude/memory/quality/validation-results.md
- **Quality Standards**: @claude/memory/context/quality-standards.md
- **Issue Tracking**: @claude/memory/quality/issue-registry.md
- **Session Notes**: @claude/memory/sessions/current-session.md#validation-log

## Error Handling & Fallbacks
- Validation failures → @claude/agents/technical/qa-tester.md for detailed analysis
- Security issues → @claude/agents/technical/security.md immediate escalation
- Performance problems → @claude/agents/cognitive/analyzer.md optimization
- Tool failures → @claude/integrations/sequential.md alternative validation

## Advanced Features
- **Continuous Validation**: Automated validation in CI/CD pipelines
- **Risk-Based Validation**: Priority-driven validation strategies
- **Cross-Platform Validation**: Multi-environment consistency checks
- **Regulatory Compliance**: Industry-specific validation frameworks