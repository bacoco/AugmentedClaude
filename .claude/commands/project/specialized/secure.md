# Secure Command

## Purpose
Comprehensive security command for vulnerability assessment, threat mitigation, compliance validation, and security hardening across applications and infrastructure.

## Specialist Integration
- **Primary**: @claude/agents/technical/security.md
- **Supporting**: @claude/agents/technical/devops.md, @claude/agents/cognitive/analyzer.md

## Command Syntax
```
@claude/commands/specialized/secure.md [--action] [--scope] [--standard] [--severity]
```

## Parameters
- `--action`: Security action (audit, harden, monitor, respond, certify)
- `--scope`: Security scope (application, infrastructure, data, network, identity)
- `--standard`: Compliance standard (OWASP, PCI-DSS, HIPAA, SOC2, ISO27001)
- `--severity`: Focus level (critical, high, medium, all)

## Usage Examples

### Application Security Audit
```
@claude/commands/specialized/secure.md --action=audit --scope=application --standard=OWASP --severity=critical
```
**Activates**: @claude/agents/technical/security.md, @claude/agents/technical/qa-tester.md
**Tools**: @claude/integrations/sequential.md for vulnerability scanning workflows
**Patterns**: @claude/patterns/operational/security-testing.md#application-audit

### Infrastructure Hardening
```
@claude/commands/specialized/secure.md --action=harden --scope=infrastructure --standard=CIS
```
**Activates**: @claude/agents/technical/security.md, @claude/agents/technical/devops.md
**Tools**: @claude/integrations/magic.md for security configuration scripts
**Patterns**: @claude/patterns/operational/infrastructure-security.md#hardening

### Incident Response
```
@claude/commands/specialized/secure.md --action=respond --scope=network --severity=critical
```
**Activates**: @claude/agents/technical/security.md with incident response protocols
**Tools**: @claude/integrations/context7.md for threat intelligence, @claude/integrations/sequential.md for response orchestration
**Patterns**: @claude/patterns/operational/incident-response.md#security-breach

## Execution Workflow

### Phase 1: Security Assessment
1. **Threat Modeling**
   - Identify attack surfaces and vectors
   - Map data flows and trust boundaries
   - Prioritize risks by impact and likelihood

2. **Vulnerability Discovery**
   - Static application security testing (SAST)
   - Dynamic application security testing (DAST)
   - Infrastructure and configuration scanning

### Phase 2: Risk Analysis
1. **Impact Assessment**
   - Evaluate potential business impact
   - Assess data exposure risks
   - Calculate remediation costs

2. **Compliance Mapping**
   - Map findings to compliance requirements
   - Identify regulatory obligations
   - Document compliance gaps

### Phase 3: Remediation Planning
1. **Priority Matrix**
   - Rank vulnerabilities by severity
   - Consider exploitability factors
   - Balance risk vs remediation effort

2. **Security Controls**
   - Design preventive controls
   - Implement detective measures
   - Establish corrective procedures

### Phase 4: Implementation & Validation
1. **Security Hardening**
   - Apply security patches and updates
   - Configure security controls
   - Implement monitoring and alerting

2. **Verification Testing**
   - Validate remediation effectiveness
   - Perform penetration testing
   - Conduct compliance audits

## Integration Points
- **Development**: Security requirements for @claude/commands/core/build.md
- **Testing**: Security test cases for @claude/commands/core/test.md
- **Deployment**: Security gates in @claude/commands/core/deploy.md
- **Monitoring**: Continuous security monitoring via @claude/commands/core/analyze.md

## Success Criteria
- [ ] All critical vulnerabilities remediated
- [ ] Compliance requirements satisfied
- [ ] Security controls tested and verified
- [ ] Incident response procedures documented
- [ ] Security metrics within acceptable ranges
- [ ] Continuous monitoring established

## Memory & Context Usage
- **Security Baseline**: @claude/memory/operational/security-baseline.md
- **Threat Intelligence**: @claude/memory/knowledge/threat-intelligence.md
- **Compliance Status**: @claude/memory/context/compliance-requirements.md
- **Incident History**: @claude/memory/operational/security-incidents.md

## Error Handling & Fallbacks
- Zero-day vulnerabilities → @claude/agents/cognitive/researcher.md for threat research
- Complex attacks → @claude/agents/cognitive/analyzer.md for forensic analysis
- Compliance failures → @claude/agents/domain/product-manager.md for business impact
- Resource constraints → Risk-based prioritization approach

## Advanced Features
- **Threat Hunting**: Proactive security investigation
- **Security Chaos Engineering**: Controlled security testing
- **Supply Chain Security**: Third-party dependency scanning
- **Zero Trust Implementation**: Identity-based security architecture