# Reference System Documentation

## Overview

The AugmentedClaude reference system provides a standardized way to link and reference content across the entire codebase. Using the `@` symbol as a prefix, you can create references to specialists, commands, patterns, workflows, memory entries, and documentation.

## Basic Syntax

```
@[category]/[subcategory]/[file].md#[section]
```

### Components:
- **@** - Reference prefix (required)
- **category** - Top-level category (required)
- **subcategory** - Sub-category or type (optional)
- **file** - Filename without extension unless .md (required)
- **#section** - Specific section anchor (optional)

## Categories and Examples

### Specialists
Reference AI specialists and their capabilities:
```
@claude/agents/code/python              # Python specialist
@claude/agents/research/academic        # Academic research specialist
@claude/agents/analysis/data#methods    # Data analysis methods section
```

### Commands
Reference command definitions and usage:
```
@commands/sparc/orchestrator         # SPARC orchestrator command
@commands/swarm/coordinate           # Swarm coordination command
@commands/memory/store#parameters    # Memory store parameters
```

### Patterns
Reference design patterns and implementations:
```
@claude/patterns/batch/parallel-execution    # Parallel execution pattern
@claude/patterns/error/handling             # Error handling patterns
@claude/patterns/memory/coordination#sync   # Memory synchronization
```

### Workflows
Reference complete workflow definitions:
```
@claude/workflows/development/tdd           # Test-driven development workflow
@claude/workflows/research/systematic       # Systematic research workflow
@claude/workflows/deployment/staged#prod    # Production deployment stages
```

### Memory
Reference stored memory entries:
```
@claude/memory/architecture/decisions       # Architecture decision records
@claude/memory/context/project             # Project context
@claude/memory/config/system#defaults      # System default configurations
```

### Documentation
Reference documentation sections:
```
@docs/api/reference#authentication  # API authentication docs
@docs/guides/quickstart             # Quick start guide
@docs/tutorials/advanced#batch      # Advanced batch operations
```

## Resolution Rules

### 1. Path Resolution
References are resolved relative to the repository root:
```
@claude/patterns/batch/executor
→ /shared/patterns/batch/executor.md

@claude/agents/code/typescript
→ /shared/specialists/code/typescript.md
```

### 2. Default Extensions
If no extension is provided, `.md` is assumed:
```
@claude/workflows/development/agile
→ /shared/workflows/development/agile.md

@commands/sparc/modes.json
→ /shared/commands/sparc/modes.json (explicit extension)
```

### 3. Anchor Resolution
Anchors reference specific sections within files:
```
@claude/patterns/error/handling#validation
→ Resolves to the "validation" section in handling.md
```

## Advanced Features

### Cross-References
Create references between related content:
```markdown
## See Also
- @claude/patterns/batch/coordinator - For batch coordination
- @claude/workflows/development/tdd#testing - Testing methodology
- @claude/agents/code/reviewer - Code review specialist
```

### Inline References
Use references within documentation:
```markdown
This pattern implements the @claude/patterns/memory/coordination 
approach with modifications for distributed systems.
```

### Reference Chains
Chain references for complex relationships:
```markdown
The @claude/workflows/development/microservices workflow uses 
@claude/patterns/distributed/messaging which requires 
@claude/memory/config/messaging#broker-settings.
```

### Conditional References
Reference different content based on context:
```markdown
For local development: @config/local/settings
For production: @config/production/settings#security
```

## Best Practices

### 1. Naming Conventions
- Use lowercase with hyphens for all paths
- Keep names descriptive but concise
- Group related content in subcategories

### 2. Reference Organization
```
Good:
@claude/agents/code/python
@claude/agents/code/javascript
@claude/agents/code/typescript

Avoid:
@claude/agents/python-code
@claude/agents/js-specialist
@claude/agents/typescript_expert
```

### 3. Section Anchors
- Use meaningful anchor names
- Keep anchors stable (avoid renaming)
- Document available anchors in files

### 4. Reference Documentation
Always document available references in your files:
```markdown
## Available References
- #overview - System overview
- #configuration - Configuration options
- #examples - Usage examples
- #troubleshooting - Common issues
```

### 5. Reference Validation
Validate references before using:
```javascript
// Check if reference exists
if (resolveReference("@claude/patterns/batch/executor")) {
  // Use the reference
}
```

## Reference Types

### Direct References
Point to specific files:
```
@commands/sparc/orchestrator
@claude/patterns/error/retry
```

### Wildcard References
Reference multiple files (for search/discovery):
```
@claude/agents/code/*          # All code specialists
@claude/workflows/*/automated       # All automated workflows
@claude/patterns/batch/*#examples   # All batch pattern examples
```

### Meta References
Reference metadata about the system:
```
@meta/version               # System version
@meta/capabilities          # Available capabilities
@meta/dependencies#required # Required dependencies
```

## Error Handling

### Invalid References
Handle missing or invalid references gracefully:
```javascript
try {
  const content = resolveReference("@claude/patterns/invalid/path");
} catch (error) {
  // Fallback to default or show error
  console.warn(`Reference not found: ${reference}`);
}
```

### Reference Suggestions
Provide suggestions for typos or similar references:
```
Reference "@paterns/batch/execute" not found.
Did you mean: @claude/patterns/batch/executor?
```

## Integration Examples

### In Commands
```javascript
// Load pattern from reference
const pattern = loadReference("@claude/patterns/validation/input");
applyPattern(pattern, userInput);
```

### In Workflows
```yaml
steps:
  - name: "Load Architecture"
    reference: "@claude/memory/architecture/current"
  - name: "Apply Pattern"
    reference: "@claude/patterns/microservices/api-gateway"
```

### In Documentation
```markdown
This implementation follows the patterns described in 
@claude/patterns/distributed/consensus with modifications for 
our specific use case. See @claude/workflows/consensus/custom 
for the complete workflow.
```

## Reference Index

### Quick Reference Table
| Category | Path Pattern | Example |
|----------|-------------|---------|
| Specialists | @claude/agents/[type]/[name] | @claude/agents/code/python |
| Commands | @commands/[group]/[command] | @commands/sparc/run |
| Patterns | @claude/patterns/[category]/[pattern] | @claude/patterns/batch/parallel |
| Workflows | @claude/workflows/[domain]/[workflow] | @claude/workflows/dev/tdd |
| Memory | @claude/memory/[namespace]/[key] | @claude/memory/config/api |
| Docs | @docs/[type]/[document] | @docs/api/reference |

## Extending the Reference System

### Adding New Categories
1. Create directory structure under `/shared/`
2. Follow naming conventions
3. Document in this reference guide
4. Update resolution logic if needed

### Custom Reference Handlers
```javascript
// Register custom reference handler
registerReferenceHandler("@custom", (path) => {
  // Custom resolution logic
  return resolveCustomPath(path);
});
```

## Troubleshooting

### Common Issues

1. **Reference Not Found**
   - Check spelling and path
   - Verify file exists
   - Check category is correct

2. **Anchor Not Found**
   - Verify anchor exists in target file
   - Check anchor spelling
   - Ensure # prefix is used

3. **Resolution Conflicts**
   - Use full paths for clarity
   - Avoid duplicate names
   - Use subcategories to organize

### Debug Mode
Enable reference resolution debugging:
```javascript
setReferenceDebug(true);
// Now all reference resolutions will be logged
```

## Summary

The AugmentedClaude reference system provides a powerful way to create interconnected documentation and code. By following these conventions and best practices, you can create maintainable, discoverable, and well-organized content that seamlessly integrates with the entire system.