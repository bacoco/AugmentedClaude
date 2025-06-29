# Market Research Workflow

## Overview
Comprehensive market research workflow leveraging multiple MCP servers and specialists for thorough competitive analysis and market intelligence.

## MCP Server Integration
- **@claude/integrations/perplexity.md** - Real-time market trends and news
- **@claude/integrations/firecrawl.md** - Competitor data extraction
- **@claude/integrations/sequential.md** - Multi-step analysis
- **@claude/integrations/context7.md** - Industry reports and documentation

## Workflow Stages

### 1. Market Landscape Analysis
**Specialist**: @claude/agents/cognitive/researcher.md
**MCP Servers**: Perplexity + Context7

```bash
@claude/commands/specialized/research.md --source=perplexity --market-trends --industry=[sector]
```

**Activities**:
- Industry trend identification
- Market size and growth analysis
- Regulatory landscape review
- Technology adoption patterns

### 2. Competitor Intelligence
**Specialist**: @claude/agents/cognitive/analyzer.md
**MCP Servers**: Firecrawl + Perplexity

```bash
@claude/commands/specialized/collect.md --source=firecrawl --competitors --features --pricing
```

**Activities**:
- Feature comparison matrix
- Pricing strategy analysis
- Marketing message extraction
- Customer review aggregation

### 3. User Needs Assessment
**Specialist**: @claude/agents/domain/product-manager.md
**MCP Servers**: Perplexity + Sequential

```bash
@claude/commands/core/analyze.md --user-needs --source=perplexity --forums --reviews
```

**Activities**:
- Pain point identification
- Feature request analysis
- User sentiment evaluation
- Unmet needs discovery

### 4. Data Synthesis
**Specialist**: @claude/agents/domain/data-scientist.md
**MCP Servers**: Sequential + Firecrawl

```bash
@claude/commands/core/analyze.md --synthesize --patterns --insights
```

**Activities**:
- Pattern recognition
- Statistical analysis
- Trend forecasting
- Opportunity identification

### 5. Strategic Recommendations
**Specialist**: @claude/agents/cognitive/strategist.md
**MCP Servers**: Sequential + Context7

```bash
@claude/commands/core/plan.md --strategic --recommendations --action-items
```

**Activities**:
- Market entry strategies
- Differentiation opportunities
- Risk assessment
- Implementation roadmap

## Automation Script

```javascript
// Market Research Automation
TodoWrite([
  {
    id: "market_landscape",
    content: "Analyze industry trends and market size using Perplexity",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/cognitive/researcher.md"
  },
  {
    id: "competitor_analysis",
    content: "Extract competitor data using Firecrawl",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/cognitive/analyzer.md"
  },
  {
    id: "user_research",
    content: "Analyze user needs and pain points",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/domain/product-manager.md"
  },
  {
    id: "data_synthesis",
    content: "Synthesize findings and identify patterns",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/domain/data-scientist.md"
  },
  {
    id: "recommendations",
    content: "Develop strategic recommendations",
    status: "pending",
    priority: "low",
    specialist: "@claude/agents/cognitive/strategist.md"
  }
]);
```

## Output Deliverables

### Market Research Report
- Executive summary
- Market landscape overview
- Competitive analysis matrix
- User needs assessment
- Strategic recommendations
- Implementation roadmap

### Supporting Documents
- Raw data exports (Firecrawl)
- Search results compilation (Perplexity)
- Statistical analysis (Sequential)
- Reference documentation (Context7)

## Success Criteria
- Comprehensive market coverage
- Actionable insights identified
- Data-driven recommendations
- Clear differentiation opportunities
- Validated market opportunities

## Integration Points
- **@claude/workflows/development/feature-development.md** - Feature planning based on research
- **@claude/workflows/operations/product-launch.md** - Go-to-market strategy
- **@claude/workflows/analysis/competitive-analysis.md** - Ongoing monitoring

## Memory Integration
- Store findings: `@claude/memory/knowledge/market-research.md`
- Track competitors: `@claude/memory/context/competitive-landscape.md`
- Save insights: `@claude/memory/sessions/current-session.md#market-insights`

## Error Handling
- **Data gaps**: Use multiple sources to fill information gaps
- **Access issues**: Fallback to alternative data sources
- **Conflicting data**: Cross-reference and validate findings
- **Time constraints**: Prioritize high-impact research areas