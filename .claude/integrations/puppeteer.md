# Puppeteer MCP Integration

## Overview
Puppeteer provides low-level browser automation capabilities, enabling specialists to perform web scraping, automated interactions, PDF generation, and browser-based task automation.

## Primary Use Cases
- Browser automation and scripting
- Web scraping (complementing Firecrawl)
- PDF and screenshot generation
- Form filling and interaction automation
- Performance testing and monitoring
- Pre-rendering for SEO

## Specialist Integration

### Best Suited Specialists
1. **@claude/agents/technical/qa-tester.md**
   - E2E test automation
   - User flow automation
   - Smoke test implementation
   - Integration testing

2. **@claude/agents/technical/backend-dev.md**
   - PDF generation services
   - Server-side rendering
   - Web scraping APIs
   - Automation endpoints

3. **@claude/agents/cognitive/analyzer.md**
   - Performance metric collection
   - User behavior simulation
   - Load testing scenarios
   - Error reproduction

4. **@claude/agents/technical/frontend-dev.md**
   - Component interaction testing
   - JavaScript execution testing
   - Dynamic content validation
   - SEO pre-rendering

5. **@claude/agents/technical/devops.md**
   - Automated deployment verification
   - Health check automation
   - Monitoring and alerting
   - CI/CD integration

## Workflow Integration

### Automation Workflows
- **@claude/workflows/development/test-automation.md**
  - E2E test script development
  - User journey automation
  - Continuous testing setup

- **@claude/workflows/operations/monitoring.md#synthetic**
  - Synthetic monitoring setup
  - Automated health checks
  - Performance baseline creation

- **@claude/workflows/development/pdf-generation.md**
  - Report generation automation
  - Invoice and document creation
  - Screenshot capture workflows

## Command Integration

### Browser Automation
```
@commands/specialized/automate.md --source=puppeteer --script=[path] --headless
```
**Activates**: Puppeteer for task automation
**Specialists**: @claude/agents/technical/qa-tester.md
**Output**: Automation results and captured data

### PDF Generation
```
@commands/specialized/generate.md --pdf --source=puppeteer --url=[url] --options=[config]
```
**Activates**: Puppeteer for document generation
**Specialists**: @claude/agents/technical/backend-dev.md
**Output**: Generated PDF with specified formatting

### Performance Testing
```
@commands/core/test.md --performance --source=puppeteer --scenarios=[list]
```
**Activates**: Puppeteer for performance simulation
**Specialists**: @claude/agents/cognitive/analyzer.md
**Output**: Performance metrics and analysis

## Configuration

### Automation Parameters
- **Headless Mode**: True/false for visible execution
- **Viewport**: Device emulation settings
- **Network**: Throttling and offline simulation
- **Execution**: Timeout and retry configuration

### Browser Control
- Page navigation and interaction
- JavaScript execution in context
- Cookie and storage management
- Request interception and modification

## Memory Integration
- **Automation Scripts**: @claude/memory/knowledge/automation-library.md
- **Test Scenarios**: @claude/memory/context/test-scenarios.md
- **Performance Baselines**: @claude/memory/knowledge/performance-metrics.md

## Complementing Other MCP Servers

### With BrowserMCP
- **Puppeteer**: Low-level automation and control
- **BrowserMCP**: High-level visual and accessibility testing
- Use together for comprehensive test coverage

### With Firecrawl
- **Puppeteer**: Dynamic content and JavaScript-heavy sites
- **Firecrawl**: Static content and structured data
- Choose based on site complexity and needs

## Usage Examples

### E2E Test Automation
```
Specialist: @claude/agents/technical/qa-tester.md
Task: "Automate user registration and login flow"
Puppeteer: Simulates user interactions, form filling, navigation
Output: Test results with success/failure status
```

### PDF Report Generation
```
Specialist: @claude/agents/technical/backend-dev.md
Task: "Generate monthly analytics report as PDF"
Puppeteer: Renders dashboard, captures as formatted PDF
Output: Professional PDF report with charts and data
```

### Performance Monitoring
```
Specialist: @claude/agents/cognitive/analyzer.md
Task: "Monitor page load performance over time"
Puppeteer: Measures performance metrics, traces execution
Output: Performance trends and bottleneck identification
```

## Advanced Features

### Browser Capabilities
- Multi-page and multi-browser management
- Device emulation (mobile, tablet)
- Network condition simulation
- Geolocation and timezone override

### Interaction Features
- Mouse and keyboard simulation
- File upload handling
- Dialog and popup management
- iframe and shadow DOM access

### Data Extraction
- JavaScript evaluation in page context
- Element selection and manipulation
- Network request/response capture
- Console log collection

## Error Handling
- **Navigation Timeouts**: Configurable wait strategies
- **Element Not Found**: Retry mechanisms with backoff
- **Browser Crashes**: Automatic browser restart
- **Network Failures**: Request retry and fallback

## Performance Optimization
- Browser instance reuse and pooling
- Parallel page execution
- Resource blocking for faster loads
- Efficient selector strategies

## Integration Benefits
- **Flexibility**: Complete browser control
- **JavaScript Support**: Handle dynamic content
- **Automation**: Complex workflow automation
- **Testing**: Realistic user simulation
- **Generation**: PDF and screenshot creation

## Best Practices
1. Use page.waitForSelector() over arbitrary delays
2. Implement proper error handling for all operations
3. Close browser instances to prevent memory leaks
4. Use efficient selectors (prefer data-testid)
5. Enable request interception only when needed
6. Run in headless mode for better performance
7. Implement retry logic for flaky operations