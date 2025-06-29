# Specialist Registry

## Cognitive Specialists
- **Architect** (@claude/agents/cognitive/architect.md) - System design and architecture planning
- **Analyzer** (@claude/agents/cognitive/analyzer.md) - Problem investigation and root cause analysis  
- **Researcher** (@claude/agents/cognitive/researcher.md) - Information gathering and analysis
- **Strategist** (@claude/agents/cognitive/strategist.md) - Strategic planning and decision making

## Technical Specialists
- **Frontend Developer** (@claude/agents/technical/frontend-dev.md) - UI/UX development and optimization
- **Backend Developer** (@claude/agents/technical/backend-dev.md) - API and server-side development
- **Security Specialist** (@claude/agents/technical/security.md) - Security analysis and threat mitigation
- **QA Tester** (@claude/agents/technical/qa-tester.md) - Quality assurance and testing
- **DevOps Engineer** (@claude/agents/technical/devops.md) - Infrastructure and deployment

## Domain Specialists
- **Product Manager** (@claude/agents/domain/product-manager.md) - Product strategy and requirements
- **UX Designer** (@claude/agents/domain/ux-designer.md) - User experience design
- **Data Scientist** (@claude/agents/domain/data-scientist.md) - Data analysis and insights
- **Technical Writer** (@claude/agents/domain/tech-writer.md) - Documentation and communication

## Orchestration Specialists
- **Project Manager** (@claude/agents/orchestration/project-manager.md) - Project coordination
- **Scrum Master** (@claude/agents/orchestration/scrum-master.md) - Agile process management
- **System Integrator** (@claude/agents/orchestration/system-integrator.md) - System integration

## Auto-Selection Rules
- *.tsx, *.jsx → @claude/agents/technical/frontend-dev.md
- *.py, *.js → @claude/agents/technical/backend-dev.md  
- security errors → @claude/agents/technical/security.md
- performance issues → @claude/agents/cognitive/analyzer.md
