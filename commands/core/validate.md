# Validate Command

## Purpose
Comprehensive validation and verification command for ensuring quality, compliance, and correctness across code, configurations, and systems.

## Specialist Integration
- **Primary**: @specialists/technical/qa-tester.md
- **Supporting**: @specialists/technical/security.md, @specialists/cognitive/analyzer.md

## Command Syntax
```
@commands/core/validate.md [--type] [--scope] [--level] [--standards]
```

## Parameters
- `--type`: Validation type (code-quality, security, performance, compliance, integration)
- `--scope`: Validation scope (component, service, system, end-to-end)
- `--level`: Validation level (basic, comprehensive, exhaustive)
- `--standards`: Standards to validate against (industry, internal, regulatory)

## Usage Examples

### Code Quality Validation
```
@commands/core/validate.md --type=code-quality --scope=component --level=comprehensive
```
**Activates**: @specialists/technical/qa-tester.md for quality assessment
**Tools**: @shared/mcp-integration/sequential.md for static analysis and linting
**Patterns**: @patterns/development/quality-patterns.md, @patterns/development/testing-patterns.md

### Security Validation
```
@commands/core/validate.md --type=security --scope=system --standards=industry --specialist=@specialists/technical/security.md
```
**Activates**: @specialists/technical/security.md for security assessment
**Tools**: @shared/mcp-integration/magic.md for vulnerability scanning
**Patterns**: @patterns/development/security-patterns.md, @patterns/operational/security-validation.md

### Performance Validation
```
@commands/core/validate.md --type=performance --scope=end-to-end --level=exhaustive
```
**Activates**: @specialists/cognitive/analyzer.md, @specialists/technical/qa-tester.md
**Tools**: @shared/mcp-integration/sequential.md for performance testing
**Patterns**: @patterns/operational/performance-patterns.md

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
- **Testing**: Core testing framework through @commands/core/test.md
- **Security**: Security validation via @specialists/technical/security.md
- **Building**: Pre-build validation in @commands/core/build.md workflow
- **Deployment**: Pre-deployment validation in @commands/core/deploy.md

## Success Criteria
- [ ] All critical validation checks passed
- [ ] Code quality metrics within acceptable ranges
- [ ] Security vulnerabilities addressed
- [ ] Performance requirements met
- [ ] Compliance standards satisfied
- [ ] Comprehensive validation report generated

## Memory & Context Usage
- **Validation History**: @memory/quality/validation-results.md
- **Quality Standards**: @memory/context/quality-standards.md
- **Issue Tracking**: @memory/quality/issue-registry.md
- **Session Notes**: @memory/sessions/current-session.md#validation-log

## Error Handling & Fallbacks
- Validation failures → @specialists/technical/qa-tester.md for detailed analysis
- Security issues → @specialists/technical/security.md immediate escalation
- Performance problems → @specialists/cognitive/analyzer.md optimization
- Tool failures → @shared/mcp-integration/sequential.md alternative validation

## Advanced Features
- **Continuous Validation**: Automated validation in CI/CD pipelines
- **Risk-Based Validation**: Priority-driven validation strategies
- **Cross-Platform Validation**: Multi-environment consistency checks
- **Regulatory Compliance**: Industry-specific validation frameworks