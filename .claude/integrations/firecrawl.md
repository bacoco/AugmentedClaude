# Firecrawl MCP Integration

## Overview
Firecrawl provides advanced web scraping and data extraction capabilities, enabling specialists to collect structured data from websites, monitor changes, and build automated data pipelines.

## Primary Use Cases
- Structured data extraction from websites
- Competitor price and feature monitoring
- Content aggregation and analysis
- Data collection for machine learning
- Website change detection and monitoring

## Specialist Integration

### Best Suited Specialists
1. **@claude/agents/domain/data-scientist.md**
   - Large-scale data collection for analysis
   - Training data gathering for ML models
   - Time-series data extraction
   - A/B testing data collection

2. **@claude/agents/cognitive/researcher.md**
   - Systematic data gathering from multiple sources
   - Research data compilation
   - Documentation extraction
   - Knowledge base building

3. **@claude/agents/cognitive/analyzer.md**
   - Competitive analysis data collection
   - Performance metrics extraction
   - Pricing and feature comparison
   - Market trend data gathering

4. **@claude/agents/domain/product-manager.md**
   - Competitor feature tracking
   - Pricing intelligence gathering
   - User review aggregation
   - Market positioning data

5. **@claude/agents/technical/qa-tester.md**
   - Test data generation
   - Website monitoring for changes
   - Content validation
   - Automated testing data collection

## Workflow Integration

### Data Collection Workflows
- **@claude/workflows/analysis/data-collection.md**
  - Automated scraping pipeline setup
  - Data validation and cleaning
  - Storage and processing integration

- **@claude/workflows/analysis/competitive-analysis.md#data-gathering**
  - Competitor website monitoring
  - Feature and pricing extraction
  - Change detection and alerting

- **@claude/workflows/development/data-pipeline.md**
  - ETL process implementation
  - Data transformation rules
  - Quality assurance checks

## Command Integration

### Data Extraction
```
@commands/specialized/collect.md --source=firecrawl --url=[url] --structure=[schema]
```
**Activates**: Firecrawl for structured data extraction
**Specialists**: @claude/agents/domain/data-scientist.md
**Output**: Structured data in specified format

### Competitive Monitoring
```
@commands/core/monitor.md --competitors --source=firecrawl --frequency=[interval]
```
**Activates**: Firecrawl for continuous monitoring
**Specialists**: @claude/agents/cognitive/analyzer.md
**Output**: Change notifications and data updates

### Bulk Collection
```
@commands/specialized/collect.md --bulk --source=firecrawl --urls=[list] --parallel
```
**Activates**: Firecrawl for mass data collection
**Specialists**: @claude/agents/cognitive/researcher.md
**Output**: Aggregated dataset from multiple sources

## Configuration

### Scraping Parameters
- **Depth**: Single page, site-wide, or specific paths
- **Frequency**: One-time, scheduled, or real-time monitoring
- **Structure**: JSON, CSV, or custom schema
- **Filters**: Content type, size limits, domain restrictions

### Data Processing
- Schema validation and transformation
- Duplicate detection and removal
- Data quality scoring
- Error handling and retry logic

## Memory Integration
- **Scraping History**: @claude/memory/sessions/current-session.md#firecrawl-jobs
- **Data Schemas**: @claude/memory/knowledge/extraction-schemas.md
- **Monitoring Rules**: @claude/memory/context/monitoring-config.md

## Quality Assurance
- Data validation against expected schemas
- Completeness checking for required fields
- Change detection accuracy verification
- Rate limiting and ethical scraping practices

## Usage Examples

### E-commerce Price Monitoring
```
Specialist: @claude/agents/domain/product-manager.md
Task: "Monitor competitor pricing for product category"
Firecrawl: Extracts prices, features, availability from competitor sites
Output: Price comparison dashboard with trend analysis
```

### Research Data Collection
```
Specialist: @claude/agents/domain/data-scientist.md
Task: "Collect training data for sentiment analysis"
Firecrawl: Scrapes reviews, ratings, comments from multiple platforms
Output: Cleaned dataset ready for ML model training
```

### Documentation Aggregation
```
Specialist: @claude/agents/cognitive/researcher.md
Task: "Compile API documentation from multiple sources"
Firecrawl: Extracts and structures documentation from various sites
Output: Unified documentation repository
```

## Error Handling
- **Access Denied**: Implement authentication or use alternative sources
- **Rate Limiting**: Adaptive request throttling and scheduling
- **Structure Changes**: Dynamic schema adaptation and alerting
- **Data Quality Issues**: Validation rules and data cleaning pipelines

## Performance Optimization
- Parallel scraping for multiple URLs
- Incremental updates for monitored sites
- Smart caching for frequently accessed data
- Efficient storage with deduplication

## Ethical Considerations
- Respect robots.txt and rate limits
- Implement user-agent identification
- Follow website terms of service
- Cache data to minimize requests

## Integration Benefits
- **Automation**: Replace manual data collection
- **Scale**: Handle thousands of data sources
- **Accuracy**: Structured extraction reduces errors
- **Monitoring**: Real-time change detection
- **Integration**: Direct pipeline to analysis tools

## Best Practices
1. Always check robots.txt and terms of service
2. Implement proper error handling and retries
3. Use structured schemas for consistent data
4. Monitor data quality metrics
5. Document data sources and extraction rules
6. Implement rate limiting to be respectful
7. Regular validation of extraction accuracy