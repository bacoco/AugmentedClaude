# UI Testing Workflow

## Overview
Comprehensive UI testing workflow combining visual regression, cross-browser compatibility, and accessibility testing using advanced MCP servers.

## MCP Server Integration
- **@claude/integrations/browsermcp.md** - Visual regression and accessibility testing
- **@claude/integrations/puppeteer.md** - Browser automation and interaction
- **@claude/integrations/sequential.md** - Test orchestration and reporting
- **@claude/integrations/firecrawl.md** - Test data generation

## Workflow Stages

### 1. Test Environment Setup
**Specialist**: @claude/agents/technical/devops.md
**MCP Servers**: Puppeteer + Sequential

```bash
@claude/commands/core/setup.md --test-environment --browsers=[chrome,firefox,safari,edge]
```

**Activities**:
- Browser configuration
- Test data preparation
- Baseline image setup
- Environment validation

### 2. Visual Regression Testing
**Specialist**: @claude/agents/technical/qa-tester.md
**MCP Servers**: BrowserMCP + Sequential

```bash
@claude/commands/core/test.md --visual --source=browsermcp --baseline --threshold=0.1
```

**Activities**:
- Screenshot capture across viewports
- Pixel-by-pixel comparison
- Dynamic content handling
- Change detection reporting

### 3. Cross-Browser Testing
**Specialist**: @claude/agents/technical/frontend-dev.md
**MCP Servers**: BrowserMCP + Puppeteer

```bash
@claude/commands/core/test.md --compatibility --source=browsermcp --matrix=all-browsers
```

**Activities**:
- Feature compatibility checks
- Layout consistency validation
- JavaScript functionality testing
- Performance comparison

### 4. Accessibility Testing
**Specialist**: @claude/agents/domain/ux-designer.md
**MCP Servers**: BrowserMCP + Context7

```bash
@claude/commands/specialized/test.md --accessibility --wcag=2.1 --level=AA
```

**Activities**:
- WCAG compliance validation
- Screen reader testing
- Keyboard navigation verification
- Color contrast analysis

### 5. User Flow Testing
**Specialist**: @claude/agents/technical/qa-tester.md
**MCP Servers**: Puppeteer + BrowserMCP

```bash
@claude/commands/core/test.md --e2e --user-flows --visual-validation
```

**Activities**:
- Critical path testing
- Multi-step workflow validation
- Form interaction testing
- Error state verification

## Automation Script

```javascript
// UI Testing Automation
TodoWrite([
  {
    id: "setup_environment",
    content: "Configure test environment and browsers",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/devops.md"
  },
  {
    id: "visual_regression",
    content: "Run visual regression tests across all pages",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/qa-tester.md"
  },
  {
    id: "browser_compatibility",
    content: "Test cross-browser compatibility",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/frontend-dev.md"
  },
  {
    id: "accessibility_audit",
    content: "Perform comprehensive accessibility testing",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/domain/ux-designer.md"
  },
  {
    id: "user_flow_validation",
    content: "Validate critical user journeys",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/technical/qa-tester.md"
  }
]);

// Parallel execution for efficiency
Task("Visual Testing Team", "Run visual regression tests in parallel across browsers");
Task("Accessibility Team", "Conduct accessibility audit simultaneously");
Task("Flow Testing Team", "Execute user flow tests with visual validation");
```

## Test Configuration

### Browser Matrix
```yaml
browsers:
  - name: Chrome
    versions: [latest, latest-1]
    viewports: [mobile, tablet, desktop]
  - name: Firefox
    versions: [latest]
    viewports: [desktop]
  - name: Safari
    versions: [latest]
    viewports: [mobile, desktop]
  - name: Edge
    versions: [latest]
    viewports: [desktop]

viewports:
  mobile: { width: 375, height: 812 }
  tablet: { width: 768, height: 1024 }
  desktop: { width: 1920, height: 1080 }
```

### Visual Testing Thresholds
```yaml
thresholds:
  default: 0.1  # 0.1% difference threshold
  animations: ignore
  dynamic_content:
    - selectors: [".timestamp", ".random-id"]
    - action: exclude
```

## Output Reports

### Visual Regression Report
- Diff images highlighting changes
- Pass/fail status by component
- Historical comparison data
- Approval workflow integration

### Accessibility Report
- WCAG violation details
- Severity levels and impact
- Remediation recommendations
- Compliance score tracking

### Cross-Browser Report
- Compatibility matrix
- Feature support table
- Performance metrics comparison
- Browser-specific issues

## Integration Points
- **@claude/workflows/development/feature-development.md** - Pre-release testing
- **@claude/workflows/operations/deployment.md** - Post-deployment validation
- **@claude/workflows/development/code-review.md** - PR visual testing

## Memory Integration
- Visual baselines: `@claude/memory/knowledge/visual-baselines.md`
- Test results: `@claude/memory/sessions/current-session.md#test-results`
- Known issues: `@claude/memory/knowledge/browser-issues.md`

## CI/CD Integration
```yaml
# Example GitHub Actions integration
ui-tests:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v3
    - name: Run UI Tests
      run: |
        ./claude-flow sparc run qa-tester "Execute full UI test suite"
    - name: Upload Visual Diffs
      if: failure()
      uses: actions/upload-artifact@v3
      with:
        name: visual-diffs
        path: test-results/visual-diffs/
```

## Best Practices
1. Run visual tests on consistent environments
2. Update baselines intentionally with review
3. Use semantic selectors for stability
4. Parallelize tests for faster execution
5. Document browser-specific workarounds
6. Monitor flaky tests and stabilize
7. Integrate with PR workflows