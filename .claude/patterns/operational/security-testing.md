# Security Testing Patterns

## Overview

Security testing patterns provide systematic approaches to identifying, preventing, and mitigating security vulnerabilities throughout the software development lifecycle. These patterns integrate security testing into DevOps workflows to ensure continuous security validation.

## Security Testing Methodologies

### Static Application Security Testing (SAST)

```typescript
// SAST Scanner Implementation
class SASTScanner {
  private rules: SecurityRule[] = [];
  private analyzers: Map<string, CodeAnalyzer> = new Map();
  private vulnerabilities: Vulnerability[] = [];

  constructor(config: SASTConfig) {
    this.loadRules(config.rulesPath);
    this.initializeAnalyzers(config.languages);
  }

  // Scan source code for vulnerabilities
  async scanProject(projectPath: string): Promise<ScanResult> {
    const startTime = Date.now();
    const files = await this.discoverFiles(projectPath);
    
    // Analyze files in parallel
    const fileResults = await Promise.all(
      files.map(file => this.analyzeFile(file))
    );

    // Aggregate results
    const vulnerabilities = fileResults.flat();
    const metrics = this.calculateMetrics(vulnerabilities);

    return {
      projectPath,
      scanDuration: Date.now() - startTime,
      filesScanned: files.length,
      vulnerabilities,
      metrics,
      report: this.generateReport(vulnerabilities)
    };
  }

  private async analyzeFile(filePath: string): Promise<Vulnerability[]> {
    const language = this.detectLanguage(filePath);
    const analyzer = this.analyzers.get(language);
    
    if (!analyzer) {
      return [];
    }

    const content = await this.readFile(filePath);
    const ast = await analyzer.parse(content);
    const vulnerabilities: Vulnerability[] = [];

    // Apply security rules
    for (const rule of this.rules) {
      if (rule.languages.includes(language)) {
        const matches = await rule.analyze(ast, content);
        
        vulnerabilities.push(...matches.map(match => ({
          id: generateId(),
          rule: rule.id,
          severity: rule.severity,
          file: filePath,
          line: match.line,
          column: match.column,
          message: rule.message,
          code: this.extractCodeSnippet(content, match),
          remediation: rule.remediation,
          cwe: rule.cwe,
          owasp: rule.owasp
        })));
      }
    }

    return vulnerabilities;
  }

  // Incremental scanning for CI/CD
  async scanDiff(baseBranch: string, headBranch: string): Promise<ScanResult> {
    const changedFiles = await this.getChangedFiles(baseBranch, headBranch);
    const results: Vulnerability[] = [];

    for (const file of changedFiles) {
      if (file.status === 'added' || file.status === 'modified') {
        const vulnerabilities = await this.analyzeFile(file.path);
        
        // Filter to only new vulnerabilities
        const newVulnerabilities = await this.filterNewVulnerabilities(
          vulnerabilities,
          baseBranch,
          file.path
        );
        
        results.push(...newVulnerabilities);
      }
    }

    return {
      scanType: 'incremental',
      baseBranch,
      headBranch,
      vulnerabilities: results,
      filesScanned: changedFiles.length
    };
  }
}

// Security rules engine
class SecurityRule {
  constructor(
    public id: string,
    public name: string,
    public severity: Severity,
    public languages: string[],
    private pattern: Pattern,
    public message: string,
    public remediation: string,
    public cwe?: string[],
    public owasp?: string[]
  ) {}

  async analyze(ast: AST, source: string): Promise<Match[]> {
    const matches: Match[] = [];

    // Traverse AST looking for pattern
    await this.traverse(ast, (node) => {
      if (this.pattern.matches(node, source)) {
        matches.push({
          node,
          line: node.location.start.line,
          column: node.location.start.column,
          endLine: node.location.end.line,
          endColumn: node.location.end.column
        });
      }
    });

    // Apply data flow analysis if needed
    if (this.pattern.requiresDataFlow) {
      return this.analyzeDataFlow(matches, ast);
    }

    return matches;
  }

  private async analyzeDataFlow(matches: Match[], ast: AST): Promise<Match[]> {
    const confirmedMatches: Match[] = [];

    for (const match of matches) {
      const taintAnalysis = new TaintAnalysis(ast);
      const flows = await taintAnalysis.analyze(match.node);
      
      // Check if tainted data reaches a sink
      for (const flow of flows) {
        if (this.pattern.isSink(flow.sink)) {
          confirmedMatches.push({
            ...match,
            dataFlow: flow
          });
        }
      }
    }

    return confirmedMatches;
  }
}

// Common vulnerability patterns
const securityPatterns = {
  sqlInjection: {
    pattern: /query\s*\(\s*['"`].*\$\{.*\}.*['"`]\s*\)/,
    message: 'Potential SQL injection vulnerability',
    remediation: 'Use parameterized queries or prepared statements',
    cwe: ['CWE-89'],
    owasp: ['A03:2021']
  },
  
  xss: {
    pattern: /innerHTML\s*=\s*[^'"`]*\$\{.*\}/,
    message: 'Potential XSS vulnerability through innerHTML',
    remediation: 'Use textContent or sanitize user input',
    cwe: ['CWE-79'],
    owasp: ['A03:2021']
  },
  
  hardcodedSecret: {
    pattern: /(password|secret|api_key|token)\s*[:=]\s*['"`][^'"`]{8,}['"`]/i,
    message: 'Hardcoded secret detected',
    remediation: 'Use environment variables or secure key management',
    cwe: ['CWE-798'],
    owasp: ['A07:2021']
  },
  
  insecureRandom: {
    pattern: /Math\.random\(\)/,
    message: 'Use of insecure random number generator',
    remediation: 'Use crypto.randomBytes() for security-sensitive operations',
    cwe: ['CWE-330'],
    owasp: ['A02:2021']
  }
};
```

### Dynamic Application Security Testing (DAST)

```typescript
// DAST Scanner Implementation
class DASTScanner {
  private httpClient: HttpClient;
  private vulnerabilityChecks: VulnerabilityCheck[] = [];
  private crawler: WebCrawler;

  constructor(config: DASTConfig) {
    this.httpClient = new HttpClient(config.proxy);
    this.crawler = new WebCrawler(config.crawlerOptions);
    this.loadVulnerabilityChecks(config.checks);
  }

  // Scan running application
  async scanApplication(targetUrl: string): Promise<DASTResult> {
    const startTime = Date.now();
    
    // Phase 1: Crawl application
    const crawlResult = await this.crawler.crawl(targetUrl);
    const endpoints = crawlResult.endpoints;
    const forms = crawlResult.forms;
    
    // Phase 2: Passive scanning
    const passiveResults = await this.passiveScan(endpoints);
    
    // Phase 3: Active scanning
    const activeResults = await this.activeScan(endpoints, forms);
    
    // Phase 4: Authentication testing
    const authResults = await this.testAuthentication(targetUrl);
    
    return {
      targetUrl,
      scanDuration: Date.now() - startTime,
      endpoints: endpoints.length,
      vulnerabilities: [
        ...passiveResults,
        ...activeResults,
        ...authResults
      ],
      coverage: this.calculateCoverage(crawlResult)
    };
  }

  // Passive scanning (no attacks)
  private async passiveScan(endpoints: Endpoint[]): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];

    for (const endpoint of endpoints) {
      // Analyze headers
      const headerVulns = await this.analyzeHeaders(endpoint);
      vulnerabilities.push(...headerVulns);
      
      // Check for information disclosure
      const infoVulns = await this.checkInformationDisclosure(endpoint);
      vulnerabilities.push(...infoVulns);
      
      // SSL/TLS analysis
      if (endpoint.url.startsWith('https')) {
        const sslVulns = await this.analyzeSsl(endpoint);
        vulnerabilities.push(...sslVulns);
      }
    }

    return vulnerabilities;
  }

  // Active scanning (with attacks)
  private async activeScan(
    endpoints: Endpoint[],
    forms: Form[]
  ): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];

    // Test each endpoint
    for (const endpoint of endpoints) {
      for (const check of this.vulnerabilityChecks) {
        if (check.appliesTo(endpoint)) {
          const vulns = await check.test(endpoint, this.httpClient);
          vulnerabilities.push(...vulns);
        }
      }
    }

    // Test forms
    for (const form of forms) {
      const formVulns = await this.testForm(form);
      vulnerabilities.push(...formVulns);
    }

    return vulnerabilities;
  }

  private async testForm(form: Form): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];
    const payloads = this.getPayloadsForForm(form);

    for (const payload of payloads) {
      const response = await this.submitForm(form, payload);
      
      // Check for XSS
      if (this.detectXss(response, payload)) {
        vulnerabilities.push({
          type: 'XSS',
          severity: 'high',
          endpoint: form.action,
          method: form.method,
          parameter: payload.field,
          evidence: payload.value,
          request: this.captureRequest(form, payload),
          response: this.captureResponse(response)
        });
      }

      // Check for SQL injection
      if (this.detectSqlInjection(response, payload)) {
        vulnerabilities.push({
          type: 'SQL Injection',
          severity: 'critical',
          endpoint: form.action,
          method: form.method,
          parameter: payload.field,
          evidence: payload.value
        });
      }
    }

    return vulnerabilities;
  }
}

// Vulnerability check implementations
class XSSCheck implements VulnerabilityCheck {
  private payloads = [
    '<script>alert(1)</script>',
    '<img src=x onerror=alert(1)>',
    'javascript:alert(1)',
    '<svg onload=alert(1)>',
    '"><script>alert(1)</script>',
    "';alert(1);//"
  ];

  async test(endpoint: Endpoint, client: HttpClient): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];

    for (const param of endpoint.parameters) {
      for (const payload of this.payloads) {
        const testUrl = this.injectPayload(endpoint.url, param, payload);
        const response = await client.get(testUrl);

        if (this.isVulnerable(response, payload)) {
          vulnerabilities.push({
            type: 'XSS',
            severity: 'high',
            endpoint: endpoint.url,
            parameter: param,
            payload,
            evidence: this.extractEvidence(response, payload)
          });
          break; // One vulnerability per parameter is enough
        }
      }
    }

    return vulnerabilities;
  }

  private isVulnerable(response: Response, payload: string): boolean {
    // Check if payload is reflected without encoding
    return response.body.includes(payload) && 
           !response.body.includes(this.htmlEncode(payload));
  }
}

// Authentication testing
class AuthenticationTester {
  async testAuthentication(baseUrl: string): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];

    // Test for weak passwords
    const weakPasswordVulns = await this.testWeakPasswords(baseUrl);
    vulnerabilities.push(...weakPasswordVulns);

    // Test for session management issues
    const sessionVulns = await this.testSessionManagement(baseUrl);
    vulnerabilities.push(...sessionVulns);

    // Test for JWT vulnerabilities
    const jwtVulns = await this.testJWT(baseUrl);
    vulnerabilities.push(...jwtVulns);

    // Test for OAuth misconfigurations
    const oauthVulns = await this.testOAuth(baseUrl);
    vulnerabilities.push(...oauthVulns);

    return vulnerabilities;
  }

  private async testWeakPasswords(baseUrl: string): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];
    const commonPasswords = [
      'password', '123456', 'admin', 'letmein',
      'password123', 'admin123', 'root', 'toor'
    ];

    const loginEndpoint = await this.findLoginEndpoint(baseUrl);
    if (!loginEndpoint) return [];

    for (const password of commonPasswords) {
      const response = await this.attemptLogin(loginEndpoint, 'admin', password);
      
      if (response.status === 200 || response.status === 302) {
        vulnerabilities.push({
          type: 'Weak Password',
          severity: 'critical',
          endpoint: loginEndpoint,
          username: 'admin',
          password: password,
          message: `Successful login with weak password: ${password}`
        });
        break;
      }
    }

    return vulnerabilities;
  }

  private async testJWT(baseUrl: string): Promise<Vulnerability[]> {
    const vulnerabilities: Vulnerability[] = [];
    const token = await this.obtainJWT(baseUrl);
    
    if (!token) return [];

    // Test for algorithm confusion
    const algConfusion = await this.testAlgorithmConfusion(token, baseUrl);
    if (algConfusion) vulnerabilities.push(algConfusion);

    // Test for weak secret
    const weakSecret = await this.testWeakSecret(token);
    if (weakSecret) vulnerabilities.push(weakSecret);

    // Test for missing expiration
    const expiration = await this.testExpiration(token);
    if (expiration) vulnerabilities.push(expiration);

    return vulnerabilities;
  }
}
```

### Interactive Application Security Testing (IAST)

```typescript
// IAST Agent Implementation
class IASTAgent {
  private instrumenter: CodeInstrumenter;
  private runtime: RuntimeMonitor;
  private taintTracker: TaintTracker;

  constructor(config: IASTConfig) {
    this.instrumenter = new CodeInstrumenter(config);
    this.runtime = new RuntimeMonitor();
    this.taintTracker = new TaintTracker();
  }

  // Instrument application code
  async instrument(appPath: string): Promise<void> {
    const files = await this.discoverFiles(appPath);
    
    for (const file of files) {
      const instrumented = await this.instrumentFile(file);
      await this.writeInstrumentedCode(file, instrumented);
    }

    // Inject runtime monitor
    await this.injectRuntimeMonitor(appPath);
  }

  private async instrumentFile(filePath: string): Promise<string> {
    const code = await this.readFile(filePath);
    const ast = this.parseCode(code);

    // Instrument sources (user input)
    this.instrumentSources(ast);

    // Instrument sinks (dangerous operations)
    this.instrumentSinks(ast);

    // Instrument propagators
    this.instrumentPropagators(ast);

    return this.generateCode(ast);
  }

  // Runtime monitoring
  startMonitoring(): void {
    // Monitor taint propagation
    this.runtime.on('taint', (event: TaintEvent) => {
      this.taintTracker.track(event);
      
      // Check if tainted data reaches a sink
      if (event.type === 'sink' && this.taintTracker.isTainted(event.value)) {
        this.reportVulnerability({
          type: this.classifyVulnerability(event.sink),
          severity: 'high',
          source: this.taintTracker.getSource(event.value),
          sink: event.sink,
          stackTrace: event.stackTrace,
          dataFlow: this.taintTracker.getFlow(event.value)
        });
      }
    });

    // Monitor security violations
    this.runtime.on('violation', (violation: SecurityViolation) => {
      this.reportViolation(violation);
    });
  }
}

// Taint tracking implementation
class TaintTracker {
  private taintMap = new WeakMap<any, TaintInfo>();
  private flowGraph = new Map<string, FlowNode>();

  track(event: TaintEvent): void {
    switch (event.type) {
      case 'source':
        this.markAsTainted(event.value, {
          source: event.source,
          timestamp: Date.now(),
          id: generateId()
        });
        break;
        
      case 'propagation':
        const sourceTaint = this.getTaint(event.source);
        if (sourceTaint) {
          this.propagateTaint(event.source, event.target, event.operation);
        }
        break;
        
      case 'sink':
        // Handled by monitor
        break;
    }
  }

  isTainted(value: any): boolean {
    return this.taintMap.has(value);
  }

  getFlow(value: any): DataFlow {
    const taint = this.getTaint(value);
    if (!taint) return null;

    return this.reconstructFlow(taint.id);
  }

  private propagateTaint(source: any, target: any, operation: string): void {
    const sourceTaint = this.getTaint(source);
    if (!sourceTaint) return;

    // Create new taint for target
    this.markAsTainted(target, {
      ...sourceTaint,
      propagatedFrom: source
    });

    // Update flow graph
    this.addFlowEdge(sourceTaint.id, target, operation);
  }
}

// Runtime security hooks
const securityHooks = {
  // SQL query hook
  database: {
    query: function(original: Function) {
      return function(query: string, ...args: any[]) {
        // Check for tainted SQL
        if (globalTaintTracker.isTainted(query)) {
          globalRuntime.emit('violation', {
            type: 'SQL Injection',
            query,
            taintInfo: globalTaintTracker.getTaint(query),
            stackTrace: new Error().stack
          });
        }

        return original.apply(this, [query, ...args]);
      };
    }
  },

  // File system hook
  fs: {
    readFile: function(original: Function) {
      return function(path: string, ...args: any[]) {
        // Check for path traversal
        if (globalTaintTracker.isTainted(path) && path.includes('..')) {
          globalRuntime.emit('violation', {
            type: 'Path Traversal',
            path,
            taintInfo: globalTaintTracker.getTaint(path)
          });
        }

        return original.apply(this, [path, ...args]);
      };
    }
  },

  // Process execution hook
  childProcess: {
    exec: function(original: Function) {
      return function(command: string, ...args: any[]) {
        // Check for command injection
        if (globalTaintTracker.isTainted(command)) {
          globalRuntime.emit('violation', {
            type: 'Command Injection',
            command,
            taintInfo: globalTaintTracker.getTaint(command)
          });
        }

        return original.apply(this, [command, ...args]);
      };
    }
  }
};
```

## Penetration Testing Patterns

### Automated Penetration Testing

```typescript
// Penetration testing framework
class PenetrationTestFramework {
  private phases: TestPhase[] = [];
  private exploitModules: Map<string, ExploitModule> = new Map();
  private report: PenTestReport;

  constructor(config: PenTestConfig) {
    this.initializePhases(config);
    this.loadExploitModules(config.modules);
    this.report = new PenTestReport(config.reportFormat);
  }

  // Execute full penetration test
  async executePenTest(target: Target): Promise<PenTestReport> {
    // Phase 1: Reconnaissance
    const reconResults = await this.executePhase('reconnaissance', target);
    
    // Phase 2: Scanning and Enumeration
    const scanResults = await this.executePhase('scanning', {
      ...target,
      ...reconResults
    });
    
    // Phase 3: Vulnerability Assessment
    const vulnResults = await this.executePhase('vulnerability_assessment', {
      ...target,
      ...scanResults
    });
    
    // Phase 4: Exploitation
    const exploitResults = await this.executePhase('exploitation', {
      ...target,
      vulnerabilities: vulnResults.vulnerabilities
    });
    
    // Phase 5: Post-Exploitation
    const postExploitResults = await this.executePhase('post_exploitation', {
      ...target,
      exploits: exploitResults.successful
    });
    
    // Generate report
    return this.report.generate({
      target,
      phases: {
        reconnaissance: reconResults,
        scanning: scanResults,
        vulnerabilityAssessment: vulnResults,
        exploitation: exploitResults,
        postExploitation: postExploitResults
      }
    });
  }

  private async executePhase(phaseName: string, context: any): Promise<PhaseResult> {
    const phase = this.phases.find(p => p.name === phaseName);
    if (!phase) throw new Error(`Unknown phase: ${phaseName}`);

    const startTime = Date.now();
    const results = await phase.execute(context);

    return {
      phase: phaseName,
      duration: Date.now() - startTime,
      ...results
    };
  }
}

// Reconnaissance phase
class ReconnaissancePhase implements TestPhase {
  name = 'reconnaissance';

  async execute(target: Target): Promise<ReconResult> {
    const results = await Promise.all([
      this.performDnsRecon(target.domain),
      this.performWhoisLookup(target.domain),
      this.performSubdomainEnum(target.domain),
      this.performPortScan(target.ip),
      this.gatherOsint(target)
    ]);

    return {
      dns: results[0],
      whois: results[1],
      subdomains: results[2],
      openPorts: results[3],
      osint: results[4]
    };
  }

  private async performSubdomainEnum(domain: string): Promise<string[]> {
    const subdomains = new Set<string>();
    
    // Use multiple sources
    const sources = [
      this.bruteforceSubdomains(domain),
      this.searchCertificateTransparency(domain),
      this.searchDnsRecords(domain),
      this.searchSearchEngines(domain)
    ];

    const results = await Promise.all(sources);
    results.forEach(subs => subs.forEach(sub => subdomains.add(sub)));

    // Verify subdomains
    const verified = await this.verifySubdomains(Array.from(subdomains));
    
    return verified;
  }
}

// Exploitation phase
class ExploitationPhase implements TestPhase {
  name = 'exploitation';
  private exploitDb: ExploitDatabase;

  async execute(context: ExploitContext): Promise<ExploitResult> {
    const exploitResults: ExploitAttempt[] = [];

    for (const vulnerability of context.vulnerabilities) {
      // Find matching exploits
      const exploits = await this.exploitDb.findExploits(vulnerability);
      
      for (const exploit of exploits) {
        if (this.shouldAttemptExploit(exploit, context)) {
          const result = await this.attemptExploit(exploit, vulnerability, context);
          exploitResults.push(result);
          
          if (result.successful) {
            // Store successful exploit for post-exploitation
            context.successfulExploits.push(result);
          }
        }
      }
    }

    return {
      attempts: exploitResults.length,
      successful: exploitResults.filter(r => r.successful).length,
      results: exploitResults
    };
  }

  private async attemptExploit(
    exploit: Exploit,
    vulnerability: Vulnerability,
    context: ExploitContext
  ): Promise<ExploitAttempt> {
    try {
      // Prepare exploit
      const payload = await exploit.generatePayload(vulnerability, context);
      
      // Execute exploit
      const response = await exploit.execute(payload, context.target);
      
      // Verify success
      const successful = await exploit.verify(response, context);
      
      return {
        exploit: exploit.name,
        vulnerability: vulnerability.id,
        successful,
        response,
        evidence: successful ? await this.collectEvidence(response) : null
      };
    } catch (error) {
      return {
        exploit: exploit.name,
        vulnerability: vulnerability.id,
        successful: false,
        error: error.message
      };
    }
  }
}

// Exploit modules
class SQLInjectionExploit implements ExploitModule {
  name = 'SQL Injection';
  
  async generatePayload(vuln: Vulnerability, context: any): Promise<Payload> {
    const payloads = [
      "' OR '1'='1",
      "' OR '1'='1' --",
      "' OR '1'='1' /*",
      "'; DROP TABLE users--",
      "' UNION SELECT null, null, null--"
    ];

    // Select appropriate payload based on vulnerability details
    const payload = this.selectPayload(vuln, payloads);
    
    return {
      type: 'sqli',
      value: payload,
      encoding: 'none'
    };
  }

  async execute(payload: Payload, target: Target): Promise<ExploitResponse> {
    const response = await this.httpClient.request({
      url: target.url,
      method: target.method || 'GET',
      params: {
        [target.parameter]: payload.value
      }
    });

    return {
      status: response.status,
      headers: response.headers,
      body: response.body,
      timing: response.timing
    };
  }

  async verify(response: ExploitResponse, context: any): Promise<boolean> {
    // Check for SQL error messages
    const errorPatterns = [
      /SQL syntax.*MySQL/i,
      /Warning.*mysql_/i,
      /valid MySQL result/i,
      /mssql_query/i,
      /PostgreSQL.*ERROR/i,
      /ORA-\d{5}/
    ];

    return errorPatterns.some(pattern => pattern.test(response.body));
  }
}
```

## Security Test Automation

### CI/CD Security Integration

```typescript
// Security pipeline orchestrator
class SecurityPipeline {
  private stages: SecurityStage[] = [];
  private policyEngine: PolicyEngine;
  private notifier: SecurityNotifier;

  constructor(config: SecurityPipelineConfig) {
    this.initializeStages(config.stages);
    this.policyEngine = new PolicyEngine(config.policies);
    this.notifier = new SecurityNotifier(config.notifications);
  }

  // Execute security pipeline
  async execute(context: PipelineContext): Promise<PipelineResult> {
    const results: StageResult[] = [];
    let shouldContinue = true;

    for (const stage of this.stages) {
      if (!shouldContinue) break;

      const stageResult = await this.executeStage(stage, context);
      results.push(stageResult);

      // Check if stage passed policy
      const policyResult = await this.policyEngine.evaluate(stageResult);
      
      if (!policyResult.passed) {
        shouldContinue = this.handlePolicyFailure(policyResult, stage);
        
        // Notify stakeholders
        await this.notifier.notifyPolicyFailure(policyResult, stageResult);
      }

      // Update context for next stage
      context = { ...context, ...stageResult.output };
    }

    return {
      stages: results,
      passed: shouldContinue,
      report: await this.generateReport(results)
    };
  }

  private async executeStage(
    stage: SecurityStage,
    context: PipelineContext
  ): Promise<StageResult> {
    const startTime = Date.now();
    
    try {
      const output = await stage.execute(context);
      
      return {
        stage: stage.name,
        status: 'completed',
        duration: Date.now() - startTime,
        output,
        vulnerabilities: output.vulnerabilities || [],
        metrics: output.metrics || {}
      };
    } catch (error) {
      return {
        stage: stage.name,
        status: 'failed',
        duration: Date.now() - startTime,
        error: error.message,
        vulnerabilities: [],
        metrics: {}
      };
    }
  }
}

// Security stages
const securityStages = {
  // Dependency scanning
  dependencyCheck: {
    name: 'dependency-check',
    execute: async (context: PipelineContext) => {
      const scanner = new DependencyScanner();
      const results = await scanner.scan(context.projectPath);
      
      return {
        vulnerabilities: results.vulnerabilities,
        dependencies: results.dependencies,
        metrics: {
          totalDependencies: results.dependencies.length,
          vulnerableDependencies: results.vulnerabilities.length,
          criticalVulnerabilities: results.vulnerabilities.filter(
            v => v.severity === 'critical'
          ).length
        }
      };
    }
  },

  // Secret scanning
  secretScanning: {
    name: 'secret-scanning',
    execute: async (context: PipelineContext) => {
      const scanner = new SecretScanner();
      const results = await scanner.scan(context.projectPath);
      
      return {
        vulnerabilities: results.secrets.map(secret => ({
          type: 'exposed-secret',
          severity: 'critical',
          file: secret.file,
          line: secret.line,
          secretType: secret.type,
          remediation: 'Remove secret and rotate credentials'
        })),
        metrics: {
          secretsFound: results.secrets.length,
          filesScanned: results.filesScanned
        }
      };
    }
  },

  // Container scanning
  containerScanning: {
    name: 'container-scanning',
    execute: async (context: PipelineContext) => {
      if (!context.dockerImage) return { vulnerabilities: [] };
      
      const scanner = new ContainerScanner();
      const results = await scanner.scan(context.dockerImage);
      
      return {
        vulnerabilities: results.vulnerabilities,
        metrics: {
          baseImageVulnerabilities: results.baseImageVulns,
          applicationVulnerabilities: results.appVulns,
          misconfigurations: results.misconfigurations.length
        }
      };
    }
  },

  // Infrastructure as Code scanning
  iacScanning: {
    name: 'iac-scanning',
    execute: async (context: PipelineContext) => {
      const scanner = new IaCScanner();
      const results = await scanner.scan(context.iacPath || context.projectPath);
      
      return {
        vulnerabilities: results.issues.map(issue => ({
          type: 'iac-misconfiguration',
          severity: issue.severity,
          resource: issue.resource,
          rule: issue.rule,
          remediation: issue.remediation
        })),
        metrics: {
          resourcesScanned: results.resourcesScanned,
          complianceScore: results.complianceScore
        }
      };
    }
  }
};

// Security policy engine
class PolicyEngine {
  private policies: SecurityPolicy[] = [];

  async evaluate(stageResult: StageResult): Promise<PolicyResult> {
    const violations: PolicyViolation[] = [];

    for (const policy of this.policies) {
      if (policy.appliesTo(stageResult.stage)) {
        const violation = await policy.evaluate(stageResult);
        if (violation) {
          violations.push(violation);
        }
      }
    }

    return {
      passed: violations.length === 0,
      violations,
      breakBuild: violations.some(v => v.breakBuild)
    };
  }
}

// Security policies
const securityPolicies = {
  noCriticalVulnerabilities: {
    name: 'no-critical-vulnerabilities',
    evaluate: (result: StageResult) => {
      const criticalVulns = result.vulnerabilities.filter(
        v => v.severity === 'critical'
      );
      
      if (criticalVulns.length > 0) {
        return {
          policy: 'no-critical-vulnerabilities',
          message: `Found ${criticalVulns.length} critical vulnerabilities`,
          breakBuild: true,
          details: criticalVulns
        };
      }
      
      return null;
    }
  },

  dependencyAge: {
    name: 'dependency-age',
    evaluate: (result: StageResult) => {
      const oldDependencies = result.output.dependencies?.filter(
        dep => dep.age > 365 // Days
      );
      
      if (oldDependencies?.length > 0) {
        return {
          policy: 'dependency-age',
          message: `Found ${oldDependencies.length} dependencies older than 1 year`,
          breakBuild: false,
          details: oldDependencies
        };
      }
      
      return null;
    }
  },

  securityScore: {
    name: 'minimum-security-score',
    evaluate: (result: StageResult) => {
      const score = result.metrics?.securityScore || 0;
      const threshold = 80;
      
      if (score < threshold) {
        return {
          policy: 'minimum-security-score',
          message: `Security score ${score} is below threshold ${threshold}`,
          breakBuild: true
        };
      }
      
      return null;
    }
  }
};
```

## Compliance Testing Patterns

### Automated Compliance Validation

```typescript
// Compliance testing framework
class ComplianceTestFramework {
  private standards: Map<string, ComplianceStandard> = new Map();
  private validators: Map<string, ComplianceValidator> = new Map();

  constructor(config: ComplianceConfig) {
    this.loadStandards(config.standards);
    this.initializeValidators(config.validators);
  }

  // Test compliance against standards
  async testCompliance(
    target: ComplianceTarget,
    standards: string[]
  ): Promise<ComplianceReport> {
    const results: ComplianceResult[] = [];

    for (const standardName of standards) {
      const standard = this.standards.get(standardName);
      if (!standard) continue;

      const result = await this.testStandard(target, standard);
      results.push(result);
    }

    return {
      target,
      standards: results,
      overallCompliance: this.calculateOverallCompliance(results),
      recommendations: this.generateRecommendations(results)
    };
  }

  private async testStandard(
    target: ComplianceTarget,
    standard: ComplianceStandard
  ): Promise<ComplianceResult> {
    const controlResults: ControlResult[] = [];

    for (const control of standard.controls) {
      const validator = this.validators.get(control.type);
      if (!validator) continue;

      const result = await validator.validate(target, control);
      controlResults.push(result);
    }

    return {
      standard: standard.name,
      version: standard.version,
      controls: controlResults,
      compliant: controlResults.every(r => r.compliant),
      score: this.calculateComplianceScore(controlResults)
    };
  }
}

// Compliance standards
const complianceStandards = {
  pciDss: {
    name: 'PCI DSS',
    version: '4.0',
    controls: [
      {
        id: '2.2.1',
        description: 'Implement only one primary function per server',
        type: 'configuration',
        severity: 'high'
      },
      {
        id: '6.5.1',
        description: 'Injection flaws, particularly SQL injection',
        type: 'code-security',
        severity: 'critical'
      },
      {
        id: '8.3.1',
        description: 'Strong cryptography for authentication',
        type: 'authentication',
        severity: 'critical'
      }
    ]
  },

  hipaa: {
    name: 'HIPAA',
    version: '2022',
    controls: [
      {
        id: '164.312(a)(1)',
        description: 'Access control',
        type: 'access-control',
        severity: 'high'
      },
      {
        id: '164.312(e)(1)',
        description: 'Transmission security',
        type: 'encryption',
        severity: 'critical'
      }
    ]
  },

  gdpr: {
    name: 'GDPR',
    version: '2018',
    controls: [
      {
        id: 'Article 32',
        description: 'Security of processing',
        type: 'data-security',
        severity: 'high'
      },
      {
        id: 'Article 25',
        description: 'Data protection by design',
        type: 'privacy-by-design',
        severity: 'high'
      }
    ]
  }
};

// Compliance validators
class CodeSecurityValidator implements ComplianceValidator {
  async validate(target: ComplianceTarget, control: Control): Promise<ControlResult> {
    // Run SAST scan focused on specific vulnerability types
    const scanner = new SASTScanner({
      rules: this.getRulesForControl(control)
    });

    const results = await scanner.scan(target.codePath);
    const violations = results.vulnerabilities.filter(
      v => v.severity === 'high' || v.severity === 'critical'
    );

    return {
      control: control.id,
      compliant: violations.length === 0,
      violations: violations.map(v => ({
        description: v.message,
        location: `${v.file}:${v.line}`,
        severity: v.severity,
        remediation: v.remediation
      }))
    };
  }
}

class EncryptionValidator implements ComplianceValidator {
  async validate(target: ComplianceTarget, control: Control): Promise<ControlResult> {
    const violations: Violation[] = [];

    // Check TLS configuration
    const tlsConfig = await this.checkTlsConfiguration(target);
    if (!tlsConfig.compliant) {
      violations.push({
        description: 'Weak TLS configuration',
        details: tlsConfig.issues,
        severity: 'critical'
      });
    }

    // Check encryption at rest
    const encryptionAtRest = await this.checkEncryptionAtRest(target);
    if (!encryptionAtRest.compliant) {
      violations.push({
        description: 'Data not encrypted at rest',
        details: encryptionAtRest.issues,
        severity: 'high'
      });
    }

    // Check key management
    const keyManagement = await this.checkKeyManagement(target);
    if (!keyManagement.compliant) {
      violations.push({
        description: 'Inadequate key management',
        details: keyManagement.issues,
        severity: 'high'
      });
    }

    return {
      control: control.id,
      compliant: violations.length === 0,
      violations
    };
  }
}
```

## Integration with AugmentedClaude Specialists

```typescript
// SecurityArchitect Specialist
const securityArchitect = {
  designSecurityTestingStrategy: async (application: Application) => {
    return {
      testingApproach: {
        development: ['SAST', 'Dependency scanning', 'Secret scanning'],
        ci: ['SAST', 'DAST', 'Container scanning'],
        staging: ['DAST', 'Penetration testing'],
        production: ['Runtime protection', 'Continuous monitoring']
      },
      tools: {
        sast: 'SonarQube + Checkmarx',
        dast: 'OWASP ZAP + Burp Suite',
        dependencies: 'Snyk + OWASP Dependency Check',
        containers: 'Trivy + Clair'
      },
      compliance: {
        standards: this.identifyRequiredStandards(application),
        controls: this.mapControlsToTests(application),
        reporting: 'Automated compliance dashboards'
      },
      metrics: [
        'Mean time to detect (MTTD)',
        'Mean time to remediate (MTTR)',
        'Security debt ratio',
        'Vulnerability density'
      ]
    };
  }
};

// SecurityEngineer Specialist
const securityEngineer = {
  implementSecurityPipeline: async (project: Project) => {
    return {
      pipeline: {
        preCommit: [
          'Secret scanning',
          'Basic SAST checks'
        ],
        build: [
          'Full SAST scan',
          'Dependency check',
          'License compliance'
        ],
        test: [
          'DAST scan',
          'API security testing',
          'Compliance validation'
        ],
        deploy: [
          'Container scanning',
          'Infrastructure validation',
          'Security gates'
        ]
      },
      implementation: `
# .gitlab-ci.yml example
security_scan:
  stage: test
  script:
    - ./security-scanner --sast --threshold critical
    - ./dependency-check --fail-on high
    - ./container-scan $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
  artifacts:
    reports:
      sast: gl-sast-report.json
      dependency_scanning: gl-dependency-scanning.json
      container_scanning: gl-container-scanning.json
      `,
      breakingPolicies: [
        'No critical vulnerabilities',
        'No exposed secrets',
        'All high-risk dependencies patched',
        'Security score > 80%'
      ]
    };
  }
};

// ComplianceOfficer Specialist
const complianceOfficer = {
  validateCompliance: async (system: System, standards: string[]) => {
    return {
      complianceStatus: {
        'PCI DSS': {
          compliant: true,
          score: 94,
          gaps: ['Network segmentation review needed']
        },
        'GDPR': {
          compliant: false,
          score: 78,
          gaps: ['Data retention policy', 'Right to erasure implementation']
        }
      },
      remediationPlan: [
        {
          gap: 'Data encryption at rest',
          priority: 'critical',
          effort: '2 weeks',
          implementation: 'Enable database encryption with key rotation'
        }
      ],
      auditTrail: {
        automated: 'All security tests logged with immutable audit trail',
        reports: 'Monthly compliance reports generated automatically',
        evidence: 'Test results archived for 7 years'
      }
    };
  }
};
```

## Best Practices

1. **Shift Left**: Integrate security testing early in development
2. **Automate Everything**: Manual security testing doesn't scale
3. **Risk-Based Testing**: Focus on high-risk areas first
4. **Continuous Testing**: Security is not a one-time activity
5. **Developer Education**: Train developers on secure coding

## Common Pitfalls

1. **Tool Overreliance**: Tools find bugs, not all vulnerabilities
2. **False Positives**: Poor tuning leads to alert fatigue
3. **Missing Context**: Security without business context is ineffective
4. **Compliance Theater**: Checking boxes without real security
5. **Siloed Testing**: Security separate from development process

## Conclusion

Security testing patterns ensure that applications are continuously validated against security threats and compliance requirements. By integrating these patterns throughout the development lifecycle, teams can build secure applications while maintaining development velocity and meeting regulatory requirements.