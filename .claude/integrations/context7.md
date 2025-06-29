# Context7 MCP Integration

## Overview
Context7 provides access to documentation, API references, and knowledge bases, enabling specialists to research and reference authoritative information.

## Primary Use Cases
- API documentation lookup and reference
- Technology best practices research
- Architecture pattern investigation
- Compliance and regulatory guidance research

## Specialist Integration

### Best Suited Specialists
1. **@claude/agents/cognitive/researcher.md**
   - Comprehensive technology research
   - Best practices investigation
   - Competitive analysis and benchmarking

2. **@claude/agents/technical/backend-dev.md**
   - API documentation and integration guides
   - Database design patterns and best practices
   - Framework and library documentation

3. **@claude/agents/domain/tech-writer.md**
   - Documentation standards and examples
   - Technical writing best practices
   - Style guide and template research

4. **@claude/agents/technical/security.md**
   - Security framework documentation (OWASP, NIST)
   - Compliance standards and requirements
   - Vulnerability database research

5. **@claude/agents/cognitive/architect.md**
   - Architecture pattern documentation
   - Technology evaluation and comparison
   - Scaling and performance best practices

## Workflow Integration

### Research Workflows
- **@claude/workflows/development/feature-development.md#research-phase**
  - Technology stack evaluation
  - API design pattern research
  - Implementation best practices

- **@claude/workflows/analysis/security-assessment.md#framework-research**
  - Security testing methodologies
  - Compliance framework requirements
  - Vulnerability assessment procedures

- **@claude/workflows/operations/knowledge-transfer.md**
  - Documentation standards research
  - Training material development
  - Best practices compilation

## Command Integration

### Research Command
```
@commands/specialized/research.md --source=context7 --topic=[topic] --depth=[level]
```
**Activates**: Context7 for comprehensive information gathering
**Specialists**: @claude/agents/cognitive/researcher.md
**Output**: Structured research findings with authoritative sources

### Documentation Command  
```
@commands/specialized/document.md --reference=context7 --standards=industry
```
**Activates**: Context7 for documentation standards and examples
**Specialists**: @claude/agents/domain/tech-writer.md
**Output**: Documentation following industry best practices

### Architecture Analysis
```
@commands/core/analyze.md --architecture --reference=context7 --patterns=industry
```
**Activates**: Context7 for architecture pattern research
**Specialists**: @claude/agents/cognitive/architect.md
**Output**: Architecture evaluation with industry pattern comparison

## Configuration

### Access Patterns
- **Documentation Lookup**: Direct API/framework documentation access
- **Pattern Research**: Architecture and design pattern investigation
- **Best Practices**: Industry standard and best practice research
- **Compliance**: Regulatory and compliance framework research

### Response Processing
- Structured information extraction
- Source credibility assessment
- Information synthesis and summarization
- Cross-reference validation

## Memory Integration
- **Knowledge Base**: @claude/memory/knowledge/external-references.md
- **Research History**: @claude/memory/sessions/current-session.md#context7-queries
- **Authoritative Sources**: @claude/memory/knowledge/trusted-sources.md

## Quality Assurance
- Source verification and credibility checking
- Information currency and relevance validation
- Cross-referencing with multiple authoritative sources
- Bias detection and balanced perspective maintenance

## Usage Examples

### API Integration Research
```
Specialist: @claude/agents/technical/backend-dev.md
Query: "Best practices for RESTful API design and OpenAPI specification"
Context7: Retrieves IETF standards, OpenAPI docs, industry best practices
Output: Comprehensive API design guidelines with authoritative references
```

### Security Framework Research
```
Specialist: @claude/agents/technical/security.md
Query: "OWASP API Security Top 10 implementation guidelines"
Context7: Retrieves OWASP documentation, implementation examples
Output: Detailed security implementation plan with OWASP compliance
```

### Architecture Pattern Investigation
```
Specialist: @claude/agents/cognitive/architect.md
Query: "Microservices architecture patterns for event-driven systems"
Context7: Retrieves architecture documentation, pattern libraries
Output: Architecture recommendation with proven pattern references
```

## Error Handling
- **Information Not Found**: Escalate to @claude/agents/cognitive/researcher.md for alternative sources
- **Outdated Information**: Cross-reference with multiple sources for currency
- **Conflicting Information**: Present multiple perspectives with source credibility assessment
- **Access Issues**: Fallback to alternative research methods and sources

## Performance Optimization
- Query result caching for frequently accessed information
- Intelligent query refinement based on context
- Parallel information gathering for comprehensive topics
- Response summarization for quick reference

## Integration Benefits
- **Authoritative Information**: Access to trusted, official documentation
- **Time Efficiency**: Rapid access to comprehensive information
- **Quality Assurance**: Verified, authoritative sources
- **Consistency**: Standardized information access across all specialists
- **Context Awareness**: Information tailored to specific specialist needs
