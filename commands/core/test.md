# Test Command

## Purpose
Comprehensive testing command covering unit, integration, end-to-end, performance, and security testing.

## Specialist Integration
- **Primary**: @specialists/technical/qa-tester.md
- **Supporting**: Domain-specific specialists for specialized testing

## Command Syntax
```
@commands/core/test.md [--type] [--scope] [--coverage] [--environment]
```

## Parameters
- `--type`: Test type (unit, integration, e2e, performance, security, accessibility)
- `--scope`: Test scope (component, feature, system, regression)
- `--coverage`: Coverage requirements (basic, standard, comprehensive)
- `--environment`: Target environment (local, staging, production)

## Usage Examples

### Unit Testing
```
@commands/core/test.md --type=unit --scope=component --coverage=comprehensive
```
**Activates**: @specialists/technical/qa-tester.md + component specialist
**Tools**: Framework-specific testing tools
**Patterns**: @patterns/development/testing-patterns.md#unit-testing

### End-to-End Testing
```
@commands/core/test.md --type=e2e --scope=feature --environment=staging
```
**Activates**: @specialists/technical/qa-tester.md
**Tools**: @shared/mcp-integration/puppeteer.md for browser automation
**Patterns**: @patterns/development/testing-patterns.md#e2e-testing

### Security Testing
```
@commands/core/test.md --type=security --scope=system --specialist=@specialists/technical/security.md
```
**Activates**: @specialists/technical/security.md + @specialists/technical/qa-tester.md
**Tools**: @shared/mcp-integration/sequential.md for complex security scenarios
**Patterns**: @patterns/operational/security-testing.md

## Execution Workflow

### Phase 1: Test Planning
1. **Test Strategy Definition**
   - Analyze requirements and acceptance criteria
   - Select appropriate testing types and approaches
   - Define success criteria and coverage targets

2. **Test Environment Setup**
   - Prepare test data and environments
   - Configure testing tools and frameworks
   - Establish baseline metrics

### Phase 2: Test Development
1. **Test Case Creation**
   - Write test cases based on requirements
   - Implement automated test scripts
   - Create test data and mock services

2. **Test Infrastructure**
   - Set up CI/CD integration
   - Configure test reporting and analytics
   - Implement test monitoring and alerting

### Phase 3: Test Execution
1. **Automated Testing**
   - Execute test suites across different levels
   - Collect metrics and performance data
   - Generate detailed test reports

2. **Manual Testing**
   - Exploratory testing for edge cases
   - Usability and accessibility testing
   - User acceptance testing coordination

### Phase 4: Results Analysis
1. **Coverage Analysis**
   - Analyze test coverage metrics
   - Identify untested code paths
   - Recommend coverage improvements

2. **Defect Analysis**
   - Categorize and prioritize defects
   - Root cause analysis for failures
   - Integration with @workflows/development/bug-resolution.md

## Test Types

### Unit Testing
- **Focus**: Individual components and functions
- **Specialists**: Component developers + @specialists/technical/qa-tester.md
- **Tools**: Jest, pytest, JUnit (framework-specific)
- **Patterns**: @patterns/development/testing-patterns.md#unit-testing

### Integration Testing
- **Focus**: Component interactions and API contracts
- **Specialists**: @specialists/technical/qa-tester.md, @specialists/technical/backend-dev.md
- **Tools**: @shared/mcp-integration/sequential.md for complex integration scenarios
- **Patterns**: @patterns/development/testing-patterns.md#integration-testing

### End-to-End Testing
- **Focus**: Complete user workflows and scenarios
- **Specialists**: @specialists/technical/qa-tester.md, @specialists/domain/ux-designer.md
- **Tools**: @shared/mcp-integration/puppeteer.md for browser automation
- **Patterns**: @patterns/development/testing-patterns.md#e2e-testing

### Performance Testing
- **Focus**: System performance under load
- **Specialists**: @specialists/cognitive/analyzer.md, @specialists/technical/qa-tester.md
- **Tools**: Load testing tools, performance monitoring
- **Patterns**: @patterns/development/performance-patterns.md#performance-testing

### Security Testing
- **Focus**: Security vulnerabilities and compliance
- **Specialists**: @specialists/technical/security.md
- **Tools**: Security testing tools, vulnerability scanners
- **Patterns**: @patterns/operational/security-testing.md

### Accessibility Testing
- **Focus**: WCAG compliance and inclusive design
- **Specialists**: @specialists/technical/frontend-dev.md, @specialists/domain/ux-designer.md
- **Tools**: @shared/mcp-integration/puppeteer.md for automated accessibility testing
- **Patterns**: @patterns/development/accessibility-patterns.md

## Integration Points
- **Bug Resolution**: Failed tests trigger @workflows/development/bug-resolution.md
- **Performance Issues**: Performance test failures escalate to @commands/specialized/optimize.md
- **Security Issues**: Security test failures escalate to @commands/specialized/secure.md
- **Documentation**: Test results documented via @commands/specialized/document.md

## Success Criteria
- [ ] All test types executed successfully
- [ ] Coverage targets met (80%+ for unit tests)
- [ ] Performance benchmarks satisfied
- [ ] Security tests passed with no critical vulnerabilities
- [ ] Accessibility compliance verified
- [ ] Defects properly categorized and tracked

## Memory & Context Usage
- **Test History**: @memory/knowledge/test-patterns.md
- **Quality Standards**: @memory/context/quality-standards.md
- **Test Results**: @memory/sessions/current-session.md#test-results
- **Known Issues**: @memory/knowledge/anti-patterns.md#testing-antipatterns

## Error Handling & Escalation
- Test failures → @workflows/development/bug-resolution.md
- Performance issues → @specialists/cognitive/analyzer.md + @commands/specialized/optimize.md
- Security failures → @specialists/technical/security.md immediate review
- Infrastructure issues → @specialists/technical/devops.md support
