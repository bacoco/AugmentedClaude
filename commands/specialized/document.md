# Document Command

## Purpose
Comprehensive documentation creation and management command for generating, organizing, and maintaining technical documentation, user guides, and knowledge bases.

## Specialist Integration
- **Primary**: @specialists/cognitive/researcher.md
- **Supporting**: @specialists/domain/technical-writer.md, @specialists/cognitive/architect.md

## Command Syntax
```
@commands/specialized/document.md [--type] [--audience] [--format] [--scope]
```

## Parameters
- `--type`: Documentation type (technical, user-guide, api, architecture, process, knowledge-base)
- `--audience`: Target audience (developers, users, administrators, stakeholders, public)
- `--format`: Output format (markdown, html, pdf, wiki, interactive, video)
- `--scope`: Documentation scope (component, service, system, organization, public)

## Usage Examples

### API Documentation Generation
```
@commands/specialized/document.md --type=api --audience=developers --format=interactive --scope=service
```
**Activates**: @specialists/cognitive/researcher.md for comprehensive API documentation
**Tools**: @shared/mcp-integration/magic.md for automated API doc generation
**Patterns**: @patterns/development/documentation-patterns.md, @patterns/development/api-patterns.md

### Technical Architecture Documentation
```
@commands/specialized/document.md --type=architecture --audience=stakeholders --format=html --specialist=@specialists/cognitive/architect.md
```
**Activates**: @specialists/cognitive/architect.md for architectural documentation
**Tools**: @shared/mcp-integration/sequential.md for diagram generation and technical writing
**Patterns**: @patterns/architectural/documentation.md, @patterns/development/technical-writing.md

### User Guide Creation
```
@commands/specialized/document.md --type=user-guide --audience=users --format=interactive --scope=system
```
**Activates**: @specialists/domain/technical-writer.md for user-focused documentation
**Tools**: @shared/mcp-integration/magic.md for interactive tutorial generation
**Patterns**: @patterns/ux/documentation.md, @patterns/development/user-documentation.md

## Execution Workflow

### Phase 1: Documentation Planning
1. **Requirement Analysis**
   - Identify documentation needs and objectives
   - Analyze target audience and use cases
   - Define scope and coverage requirements

2. **Information Architecture**
   - Design documentation structure and organization
   - Plan content hierarchy and navigation
   - Establish style guides and standards

### Phase 2: Content Creation
1. **Information Gathering**
   - Extract information from code, designs, and specifications
   - Conduct interviews with subject matter experts
   - Research existing documentation and resources

2. **Content Development**
   - Write clear, concise, and accurate content
   - Create diagrams, screenshots, and visual aids
   - Develop examples, tutorials, and code samples

### Phase 3: Review & Validation
1. **Technical Review**
   - Validate technical accuracy and completeness
   - Ensure consistency with implementation
   - Check for outdated or incorrect information

2. **Usability Testing**
   - Test documentation with target users
   - Gather feedback on clarity and usefulness
   - Identify gaps and improvement opportunities

### Phase 4: Publication & Maintenance
1. **Publishing**
   - Format and publish documentation
   - Set up search and navigation features
   - Configure access controls and permissions

2. **Maintenance Strategy**
   - Establish update and review cycles
   - Set up automated validation checks
   - Plan version control and change management

## Integration Points
- **Development**: Documentation integrated with @commands/core/build.md workflows
- **Design**: Design documentation from @commands/specialized/design.md outputs
- **Research**: Knowledge base enriched by @commands/specialized/research.md findings
- **Validation**: Documentation accuracy verified through @commands/core/validate.md

## Success Criteria
- [ ] Documentation completeness and accuracy achieved
- [ ] Target audience needs addressed effectively
- [ ] Information easily discoverable and navigable
- [ ] Content maintained and up-to-date
- [ ] User feedback and satisfaction positive
- [ ] Documentation integrated with development workflow

## Memory & Context Usage
- **Documentation Registry**: @memory/documentation/doc-inventory.md
- **Style Guidelines**: @memory/documentation/style-standards.md
- **Content History**: @memory/documentation/content-versions.md
- **Session Notes**: @memory/sessions/current-session.md#documentation-log

## Error Handling & Fallbacks
- Content gaps → @specialists/cognitive/researcher.md for additional information gathering
- Technical inaccuracies → Subject matter expert consultation
- Usability issues → @specialists/domain/technical-writer.md for content improvement
- Format problems → @shared/mcp-integration/magic.md for alternative generation approaches

## Advanced Features
- **Automated Documentation**: Code-driven documentation generation
- **Interactive Documentation**: Executable examples and live demos
- **Multi-Language Support**: Internationalization and localization
- **Analytics Integration**: Documentation usage tracking and optimization