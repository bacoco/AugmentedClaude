# Collect Command

## Purpose
Comprehensive data collection and aggregation command for gathering information from multiple sources, systems, and environments for analysis and decision-making.

## Specialist Integration
- **Primary**: @specialists/domain/data-scientist.md
- **Supporting**: @specialists/cognitive/researcher.md, @specialists/technical/backend-dev.md

## Command Syntax
```
@commands/specialized/collect.md [--source] [--type] [--format] [--scope]
```

## Parameters
- `--source`: Data source (logs, metrics, apis, databases, files, web, sensors)
- `--type`: Data type (structured, unstructured, real-time, historical, streaming)
- `--format`: Output format (json, csv, database, stream, warehouse)
- `--scope`: Collection scope (application, system, network, business, external)

## Usage Examples

### System Metrics Collection
```
@commands/specialized/collect.md --source=metrics --type=real-time --format=database --scope=system
```
**Activates**: @specialists/domain/data-scientist.md for data pipeline design
**Tools**: @shared/mcp-integration/sequential.md for multi-source data aggregation
**Patterns**: @patterns/operational/data-collection.md, @patterns/operational/monitoring-patterns.md

### Log Aggregation and Processing
```
@commands/specialized/collect.md --source=logs --type=structured --format=warehouse --scope=application
```
**Activates**: @specialists/technical/backend-dev.md, @specialists/domain/data-scientist.md
**Tools**: @shared/mcp-integration/magic.md for log parsing and enrichment
**Patterns**: @patterns/operational/logging-patterns.md, @patterns/analytical/data-processing.md

### External Data Research Collection
```
@commands/specialized/collect.md --source=web --type=unstructured --specialist=@specialists/cognitive/researcher.md
```
**Activates**: @specialists/cognitive/researcher.md for web scraping and data extraction
**Tools**: @shared/mcp-integration/perplexity.md for intelligent web data collection
**Patterns**: @patterns/development/research-patterns.md, @patterns/analytical/data-extraction.md

## Execution Workflow

### Phase 1: Collection Planning
1. **Source Identification**
   - Identify all relevant data sources
   - Assess data availability and accessibility
   - Plan collection strategies and methodologies

2. **Infrastructure Preparation**
   - Set up data collection infrastructure
   - Configure storage and processing systems
   - Establish security and compliance measures

### Phase 2: Data Extraction
1. **Source Connection**
   - Establish connections to data sources
   - Configure authentication and authorization
   - Set up data access and extraction mechanisms

2. **Data Retrieval**
   - Extract data from identified sources
   - Handle rate limiting and throttling
   - Manage data source dependencies and timing

### Phase 3: Data Processing
1. **Data Transformation**
   - Clean and normalize collected data
   - Apply data quality validation rules
   - Enrich data with additional context

2. **Data Integration**
   - Merge data from multiple sources
   - Resolve conflicts and inconsistencies
   - Create unified data schemas and formats

### Phase 4: Storage & Access
1. **Data Storage**
   - Store processed data in appropriate systems
   - Implement data retention and archival policies
   - Set up backup and recovery mechanisms

2. **Access Enablement**
   - Create data access interfaces and APIs
   - Set up querying and reporting capabilities
   - Establish data governance and security controls

## Integration Points
- **Analysis**: Collected data feeds @commands/specialized/analyze.md workflows
- **Research**: Data supports @commands/specialized/research.md investigations
- **Monitoring**: Real-time data enhances @commands/core/monitor.md capabilities
- **Documentation**: Collection processes documented via @commands/specialized/document.md

## Success Criteria
- [ ] All identified data sources successfully accessed
- [ ] Data quality and integrity maintained
- [ ] Collection processes automated and reliable
- [ ] Data properly stored and accessible
- [ ] Performance and scalability requirements met
- [ ] Security and compliance standards satisfied

## Memory & Context Usage
- **Data Sources**: @memory/data/source-registry.md
- **Collection History**: @memory/data/collection-logs.md
- **Data Schemas**: @memory/data/schema-definitions.md
- **Session Notes**: @memory/sessions/current-session.md#collection-log

## Error Handling & Fallbacks
- Source unavailability → @specialists/technical/backend-dev.md for alternative approaches
- Data quality issues → @specialists/domain/data-scientist.md for validation strategies
- Performance problems → @specialists/cognitive/analyzer.md for optimization
- Security concerns → @specialists/technical/security.md for compliance review

## Advanced Features
- **Real-Time Streaming**: Continuous data collection and processing
- **Intelligent Sampling**: Smart data sampling strategies for large datasets
- **Multi-Source Fusion**: Advanced data integration from heterogeneous sources
- **Automated Discovery**: Automatic identification of new data sources