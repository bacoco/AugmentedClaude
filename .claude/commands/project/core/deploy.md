# Deploy Command

## Purpose
Automated deployment command for releasing applications and infrastructure to various environments with security, validation, and rollback capabilities.

## Specialist Integration
- **Primary**: @claude/agents/technical/devops.md
- **Supporting**: @claude/agents/technical/security.md, @claude/agents/technical/qa-tester.md

## Command Syntax
```
@claude/commands/core/deploy.md [--environment] [--strategy] [--validation] [--rollback]
```

## Parameters
- `--environment`: Target environment (development, staging, production, disaster-recovery)
- `--strategy`: Deployment strategy (blue-green, canary, rolling, recreate)
- `--validation`: Validation level (smoke, standard, comprehensive)
- `--rollback`: Rollback strategy (automatic, manual, checkpoint)

## Usage Examples

### Production Blue-Green Deployment
```
@claude/commands/core/deploy.md --environment=production --strategy=blue-green --validation=comprehensive
```
**Activates**: @claude/agents/technical/devops.md, @claude/agents/technical/security.md
**Tools**: @claude/integrations/sequential.md for deployment orchestration
**Patterns**: @claude/patterns/operational/deployment-patterns.md#blue-green

### Canary Release to Staging
```
@claude/commands/core/deploy.md --environment=staging --strategy=canary --validation=standard --rollback=automatic
```
**Activates**: @claude/agents/technical/devops.md, @claude/agents/technical/qa-tester.md
**Tools**: @claude/integrations/puppeteer.md for automated validation testing
**Patterns**: @claude/patterns/operational/deployment-patterns.md#canary-deployment

### Emergency Rollback
```
@claude/commands/core/deploy.md --environment=production --rollback=checkpoint --validation=smoke
```
**Activates**: @claude/agents/technical/devops.md with emergency protocols
**Tools**: @claude/integrations/magic.md for rapid recovery scripts
**Patterns**: @claude/patterns/operational/incident-response.md#rollback-procedures

## Execution Workflow

### Phase 1: Pre-Deployment Validation
1. **Environment Readiness Check**
   - Verify target environment availability
   - Check resource capacity and scaling limits
   - Validate network connectivity and dependencies
   
2. **Security Clearance**
   - Run security scans on deployment artifacts
   - Verify compliance requirements
   - Check certificate validity and secrets management

### Phase 2: Deployment Preparation
1. **Artifact Verification**
   - Validate build artifacts and checksums
   - Check version compatibility
   - Ensure all dependencies are available

2. **Rollback Preparation**
   - Create deployment checkpoint
   - Backup current state and configuration
   - Prepare rollback scripts and procedures

### Phase 3: Deployment Execution
1. **Progressive Rollout**
   - Execute deployment according to strategy
   - Monitor real-time metrics and health checks
   - Apply traffic management rules

2. **Validation Gates**
   - Run smoke tests after each deployment phase
   - Monitor error rates and performance metrics
   - Execute automated validation suites

### Phase 4: Post-Deployment Verification
1. **Health Monitoring**
   - Continuous health check monitoring
   - Performance baseline comparison
   - Error rate and log analysis

2. **User Acceptance**
   - Synthetic monitoring execution
   - Real user monitoring setup
   - Feedback collection mechanisms

## Integration Points
- **Testing**: Automatic @claude/commands/core/test.md --type=smoke,e2e execution
- **Monitoring**: Integration with @claude/commands/core/analyze.md --type=performance
- **Security**: @claude/commands/specialized/secure.md for runtime security validation
- **Documentation**: Deployment notes via @claude/commands/specialized/document.md

## Success Criteria
- [ ] All pre-deployment checks passed
- [ ] Deployment completed without errors
- [ ] Health checks passing (99.9% uptime)
- [ ] Performance within acceptable thresholds
- [ ] Security scans show no new vulnerabilities
- [ ] Rollback capability verified and tested

## Memory & Context Usage
- **Deployment History**: @claude/memory/operational/deployment-history.md
- **Environment Config**: @claude/memory/context/infrastructure-config.md
- **Rollback Points**: @claude/memory/operational/rollback-checkpoints.md
- **Deployment Metrics**: @claude/memory/sessions/current-session.md#deployment-metrics

## Error Handling & Fallbacks
- Deployment failures → Automatic rollback to checkpoint
- Performance degradation → @claude/agents/cognitive/analyzer.md investigation
- Security issues → @claude/agents/technical/security.md immediate response
- Infrastructure problems → @claude/agents/technical/devops.md troubleshooting

## Advanced Features
- **Multi-Region Deployment**: Coordinate across geographic regions
- **Feature Flags**: Progressive feature enablement post-deployment
- **A/B Testing**: Deploy multiple versions for testing
- **Chaos Engineering**: Controlled failure injection for resilience testing