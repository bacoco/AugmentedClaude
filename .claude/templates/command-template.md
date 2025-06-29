# Command Template

<!-- 
INSTRUCTIONS FOR USING THIS TEMPLATE:
1. Copy this template to the appropriate location in /commands/
2. Replace all placeholder text wrapped in [brackets]
3. Remove any optional sections that aren't needed
4. Ensure all specialist and pattern references use the @ notation
5. Follow the examples at the bottom for guidance
-->

# [Command Name] Command

## Purpose
<!-- REQUIRED: Describe what this command does in 1-2 sentences -->
[Brief description of the command's primary function and goal]

## Specialist Integration
<!-- REQUIRED: List which specialists this command uses -->
- **Primary**: [Main specialist responsible for execution]
- **Supporting**: [List of supporting specialists, comma-separated]

## Command Syntax
<!-- REQUIRED: Show how to invoke this command -->
```
@commands/[category]/[command-name].md [--required-params] [--optional-params]
```

## Parameters
<!-- REQUIRED: List all parameters with descriptions -->
- `--[param1]`: [Description of what this parameter does] (required/optional)
- `--[param2]`: [Description of what this parameter does] (required/optional)
- `--[param3]`: [Description of what this parameter does] (required/optional)

## Usage Examples
<!-- REQUIRED: Provide at least 2 examples showing different use cases -->

### [Example 1 Name]
```
@commands/[category]/[command-name].md --[param1]=value --[param2]=value
```
**Activates**: [Which specialists/workflows are triggered]
**Tools**: [Which MCP tools are used]
**Patterns**: [Which patterns are applied]

### [Example 2 Name]
```
@commands/[category]/[command-name].md --[param1]=value --[param3]=value
```
**Activates**: [Which specialists/workflows are triggered]
**Tools**: [Which MCP tools are used]
**Patterns**: [Which patterns are applied]

## Execution Workflow
<!-- REQUIRED: Detail the phases of execution -->

### Phase 1: [Phase Name]
1. **[Step Name]**
   - [Description of what happens]
   - [Any specialist activations]
   - [Memory or context usage]

2. **[Step Name]**
   - [Description of what happens]
   - Reference: [Any patterns or tools used]
   - [Expected outcomes]

### Phase 2: [Phase Name]
1. **[Step Name]**
   - [Description of what happens]
   - [Quality checks or validations]
   - [Integration points]

<!-- Add more phases as needed -->

## Integration Points
<!-- OPTIONAL: List how this command integrates with others -->
- **[Integration Type]**: [Description and command reference]
- **[Integration Type]**: [Description and command reference]
- **[Integration Type]**: [Description and command reference]

## Success Criteria
<!-- REQUIRED: Checklist of what constitutes successful execution -->
- [ ] [Criterion 1 - e.g., "Implementation matches specifications"]
- [ ] [Criterion 2 - e.g., "All tests pass"]
- [ ] [Criterion 3 - e.g., "Documentation generated"]
- [ ] [Criterion 4 - e.g., "Performance requirements met"]

## Memory & Context Usage
<!-- REQUIRED: List which memory and context files are used -->
- **[Context Type]**: @claude/memory/context/[file].md
- **[Context Type]**: @claude/memory/context/[file].md
- **[Session Data]**: @claude/memory/sessions/current-session.md#[section]
- **[Patterns]**: @claude/patterns/[category]/[pattern].md

## Error Handling & Fallbacks
<!-- OPTIONAL but RECOMMENDED: Define how errors are handled -->
- [Error Type] → [Fallback command or action]
- [Error Type] → [Specialist consultation]
- [Error Type] → [Recovery workflow]

## Advanced Features
<!-- OPTIONAL: List any advanced capabilities -->
- **[Feature Name]**: [Description of advanced feature]
- **[Feature Name]**: [Description of advanced feature]
- **[Feature Name]**: [Description of advanced feature]

---

## EXAMPLE: Completed Command Template

# Validate Command

## Purpose
Comprehensive validation command for ensuring code quality, security compliance, and architectural adherence across the codebase.

## Specialist Integration
- **Primary**: @claude/agents/technical/qa-tester.md
- **Supporting**: @claude/agents/technical/security.md, @claude/agents/cognitive/architect.md

## Command Syntax
```
@commands/core/validate.md [--type] [--scope] [--strict] [--fix]
```

## Parameters
- `--type`: Type of validation (code, security, architecture, all) (required)
- `--scope`: Scope of validation (file, module, project) (optional, default: project)
- `--strict`: Enable strict validation rules (optional)
- `--fix`: Automatically fix issues where possible (optional)

## Usage Examples

### Code Quality Validation
```
@commands/core/validate.md --type=code --scope=module --fix
```
**Activates**: Code quality checks, linting, complexity analysis
**Tools**: @claude/mcp-integration/sequential.md for analysis
**Patterns**: @claude/patterns/development/code-quality.md

### Security Validation
```
@commands/core/validate.md --type=security --strict
```
**Activates**: @claude/agents/technical/security.md
**Tools**: @claude/mcp-integration/context7.md for vulnerability lookup
**Patterns**: @claude/patterns/development/security-patterns.md

## Execution Workflow

### Phase 1: Analysis & Scanning
1. **Scope Determination**
   - Identify files and modules to validate
   - Load relevant validation rules
   - Initialize memory tracking

2. **Pattern Loading**
   - Reference: @claude/patterns/development/validation-patterns.md
   - Load type-specific rules and criteria
   - Configure validation parameters

### Phase 2: Validation Execution
1. **Run Validators**
   - Execute type-specific validation tools
   - Collect findings and metrics
   - Generate preliminary report

2. **Cross-Reference Standards**
   - Compare against architectural patterns
   - Check security compliance
   - Validate performance thresholds

## Integration Points
- **Testing**: Integrates with @commands/core/test.md
- **Building**: Pre-build validation via @commands/core/build.md
- **Deployment**: Pre-deployment gates via @commands/core/deploy.md

## Success Criteria
- [ ] No critical issues found
- [ ] Code quality score >= 85%
- [ ] Security vulnerabilities = 0
- [ ] Architecture compliance verified
- [ ] All automated fixes applied successfully

## Memory & Context Usage
- **Project Standards**: @claude/memory/context/project-standards.md
- **Validation History**: @claude/memory/sessions/current-session.md#validation-log
- **Patterns**: @claude/patterns/development/validation-patterns.md

## Error Handling & Fallbacks
- Validation failures → @commands/core/troubleshoot.md
- Security issues → @claude/agents/technical/security.md --emergency
- Architecture violations → @claude/agents/cognitive/architect.md review

## Advanced Features
- **Parallel Validation**: Validate multiple modules simultaneously
- **Custom Rules**: Define project-specific validation rules
- **CI/CD Integration**: Automatic validation in pipelines
- **Progressive Enhancement**: Fix issues incrementally