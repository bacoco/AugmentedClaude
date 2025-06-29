# Sequential Thinking Server MCP Integration

## Overview
The Sequential Thinking Server provides advanced multi-step reasoning, complex problem decomposition, and chain-of-thought workflows through MCP (Model Context Protocol). It enhances AugmentedClaude's cognitive specialists with sophisticated reasoning capabilities for tackling complex, multi-faceted problems.

## Core Capabilities

### Multi-Step Reasoning Engine
```javascript
class SequentialReasoner {
  constructor(server) {
    this.server = server;
    this.reasoningChain = [];
    this.context = new Map();
  }

  async solveComplex(problem, options = {}) {
    // Decompose the problem
    const steps = await this.decomposeProblem(problem);
    
    // Create reasoning chain
    const chain = await this.createReasoningChain(steps, {
      maxDepth: options.maxDepth || 10,
      branchingFactor: options.branchingFactor || 3,
      pruneUnlikely: options.pruneUnlikely !== false
    });
    
    // Execute reasoning steps
    const solution = await this.executeChain(chain);
    
    // Validate and refine
    const refined = await this.refinesSolution(solution, problem);
    
    return {
      solution: refined,
      reasoning: this.reasoningChain,
      confidence: this.calculateConfidence(refined),
      alternatives: await this.generateAlternatives(refined)
    };
  }

  async decomposeProblem(problem) {
    return await this.server.decompose({
      problem,
      strategy: 'recursive',
      granularity: 'fine',
      constraints: problem.constraints || [],
      dependencies: true
    });
  }

  async createReasoningChain(steps, config) {
    const chain = await this.server.buildChain({
      steps,
      type: 'directed-acyclic-graph',
      optimization: 'minimize-steps',
      parallel: this.identifyParallelSteps(steps),
      fallbacks: true
    });
    
    // Add checkpoints for long chains
    if (chain.length > 5) {
      this.addCheckpoints(chain);
    }
    
    return chain;
  }

  async executeChain(chain) {
    const results = [];
    
    for (const step of chain) {
      // Execute step with context
      const result = await this.executeStep(step, {
        previousResults: results,
        context: this.context
      });
      
      // Track reasoning
      this.reasoningChain.push({
        step: step.description,
        input: step.input,
        reasoning: result.reasoning,
        output: result.output,
        confidence: result.confidence
      });
      
      // Update context
      this.updateContext(step, result);
      
      // Check for early termination
      if (result.conclusive) {
        break;
      }
      
      results.push(result);
    }
    
    return this.synthesizeResults(results);
  }

  async executeStep(step, context) {
    return await this.server.reason({
      step,
      context: context.context,
      previousResults: context.previousResults,
      method: step.reasoningMethod || 'deductive',
      validateLogic: true
    });
  }
}
```

### Problem Decomposition Patterns
```javascript
class ProblemDecomposer {
  constructor(server) {
    this.server = server;
    this.decompositionStrategies = {
      'divide-conquer': this.divideAndConquer.bind(this),
      'top-down': this.topDown.bind(this),
      'bottom-up': this.bottomUp.bind(this),
      'functional': this.functional.bind(this),
      'temporal': this.temporal.bind(this)
    };
  }

  async decompose(problem, strategy = 'auto') {
    // Auto-select strategy if needed
    if (strategy === 'auto') {
      strategy = await this.selectStrategy(problem);
    }
    
    // Apply decomposition strategy
    const decomposer = this.decompositionStrategies[strategy];
    const subproblems = await decomposer(problem);
    
    // Analyze dependencies
    const dependencies = await this.analyzeDependencies(subproblems);
    
    // Optimize execution order
    const optimized = await this.optimizeOrder(subproblems, dependencies);
    
    return {
      strategy,
      subproblems: optimized,
      dependencies,
      estimatedComplexity: this.estimateComplexity(optimized)
    };
  }

  async divideAndConquer(problem) {
    const parts = await this.server.divide({
      problem,
      method: 'recursive',
      threshold: problem.threshold || 'atomic'
    });
    
    return parts.map(part => ({
      ...part,
      strategy: 'divide-conquer',
      canParallelize: true
    }));
  }

  async topDown(problem) {
    // Start from high-level goals
    const goals = await this.extractGoals(problem);
    const subgoals = [];
    
    for (const goal of goals) {
      const decomposed = await this.server.decomposeGoal({
        goal,
        method: 'hierarchical',
        maxDepth: 5
      });
      subgoals.push(...decomposed);
    }
    
    return subgoals;
  }

  async functional(problem) {
    // Decompose by function/capability
    const functions = await this.server.identifyFunctions({
      problem,
      granularity: 'fine'
    });
    
    return functions.map(fn => ({
      type: 'functional',
      function: fn.name,
      inputs: fn.inputs,
      outputs: fn.outputs,
      implementation: fn.steps
    }));
  }

  async analyzeDependencies(subproblems) {
    const graph = new Map();
    
    for (const problem of subproblems) {
      const deps = await this.server.findDependencies({
        problem,
        candidates: subproblems,
        types: ['data', 'logical', 'temporal']
      });
      
      graph.set(problem.id, deps);
    }
    
    return {
      graph,
      hasCycles: this.detectCycles(graph),
      criticalPath: this.findCriticalPath(graph)
    };
  }
}
```

### Chain-of-Thought Workflows
```javascript
class ChainOfThoughtProcessor {
  constructor(server) {
    this.server = server;
    this.thoughtChain = [];
  }

  async processWithCoT(task, options = {}) {
    // Initialize chain
    const chain = await this.initializeChain(task);
    
    // Process each thought step
    let current = chain.initial;
    const thoughts = [];
    
    while (!this.isComplete(current, task)) {
      // Generate next thought
      const thought = await this.generateThought(current, {
        task,
        previousThoughts: thoughts,
        strategy: options.strategy || 'exploratory'
      });
      
      // Validate thought
      const validated = await this.validateThought(thought);
      
      // Branch if needed
      if (validated.requiresBranching) {
        const branches = await this.exploreBranches(thought, options);
        thought.branches = branches;
      }
      
      thoughts.push(validated);
      current = validated.state;
      
      // Prune if chain too long
      if (thoughts.length > (options.maxLength || 20)) {
        thoughts = await this.pruneChain(thoughts);
      }
    }
    
    // Synthesize final answer
    return await this.synthesize(thoughts, task);
  }

  async generateThought(current, context) {
    const thought = await this.server.think({
      state: current,
      context,
      methods: ['deductive', 'inductive', 'abductive', 'analogical'],
      explore: context.strategy === 'exploratory'
    });
    
    // Add metadata
    thought.metadata = {
      confidence: this.assessConfidence(thought),
      novelty: this.assessNovelty(thought, context.previousThoughts),
      relevance: this.assessRelevance(thought, context.task)
    };
    
    return thought;
  }

  async validateThought(thought) {
    const validation = await this.server.validate({
      thought,
      checks: [
        'logical-consistency',
        'factual-accuracy',
        'relevance',
        'progress'
      ]
    });
    
    // Fix issues if possible
    if (!validation.isValid) {
      const fixed = await this.attemptFix(thought, validation.issues);
      return fixed || { ...thought, invalid: true };
    }
    
    return thought;
  }

  async exploreBranches(thought, options) {
    const branches = await this.server.branch({
      thought,
      strategies: ['what-if', 'alternative', 'contradiction'],
      maxBranches: options.maxBranches || 3,
      depth: options.branchDepth || 2
    });
    
    // Evaluate branches
    const evaluated = [];
    for (const branch of branches) {
      const score = await this.evaluateBranch(branch, thought);
      evaluated.push({ ...branch, score });
    }
    
    // Keep only promising branches
    return evaluated
      .sort((a, b) => b.score - a.score)
      .slice(0, options.keepBranches || 2);
  }

  async synthesize(thoughts, task) {
    // Extract key insights
    const insights = await this.extractInsights(thoughts);
    
    // Build coherent narrative
    const narrative = await this.server.buildNarrative({
      thoughts,
      insights,
      task,
      style: 'logical-flow'
    });
    
    // Generate final answer
    const answer = await this.server.synthesize({
      narrative,
      task,
      format: task.expectedFormat || 'comprehensive',
      includeReasoning: true
    });
    
    return {
      answer,
      reasoning: narrative,
      insights,
      confidence: this.calculateOverallConfidence(thoughts)
    };
  }
}
```

### Complex Problem Solving Patterns
```javascript
class ComplexProblemSolver {
  constructor(server) {
    this.server = server;
    this.strategies = new Map();
    this.solutions = [];
  }

  async solve(problem, constraints = {}) {
    // Analyze problem complexity
    const analysis = await this.analyzeComplexity(problem);
    
    // Select solving strategy
    const strategy = await this.selectStrategy(analysis, constraints);
    
    // Apply strategy with monitoring
    const solution = await this.applyStrategyWithMonitoring(
      strategy,
      problem,
      constraints
    );
    
    // Verify solution
    const verified = await this.verifySolution(solution, problem);
    
    // Optimize if needed
    if (constraints.optimize) {
      return await this.optimizeSolution(verified, constraints.optimizeCriteria);
    }
    
    return verified;
  }

  async analyzeComplexity(problem) {
    const metrics = await this.server.analyze({
      problem,
      metrics: [
        'computational-complexity',
        'logical-depth',
        'constraint-tightness',
        'solution-space-size',
        'uncertainty-level'
      ]
    });
    
    return {
      ...metrics,
      category: this.categorizeComplexity(metrics),
      recommendations: await this.getRecommendations(metrics)
    };
  }

  async selectStrategy(analysis, constraints) {
    // Get candidate strategies
    const candidates = await this.server.suggestStrategies({
      complexity: analysis,
      constraints,
      available: Array.from(this.strategies.keys())
    });
    
    // Score strategies
    const scored = [];
    for (const candidate of candidates) {
      const score = await this.scoreStrategy(candidate, analysis, constraints);
      scored.push({ strategy: candidate, score });
    }
    
    // Select best strategy
    const best = scored.reduce((a, b) => a.score > b.score ? a : b);
    
    // Customize strategy
    return await this.customizeStrategy(best.strategy, analysis, constraints);
  }

  async applyStrategyWithMonitoring(strategy, problem, constraints) {
    const monitor = this.createMonitor(constraints);
    
    // Initialize solver
    const solver = await this.server.createSolver({
      strategy,
      problem,
      monitor: monitor.id
    });
    
    // Solve with progress tracking
    let iteration = 0;
    let current = null;
    
    while (!solver.isComplete() && iteration < (constraints.maxIterations || 1000)) {
      // Execute step
      current = await solver.step();
      
      // Monitor progress
      const progress = await monitor.checkProgress(current);
      
      // Adjust if stuck
      if (progress.isStuck) {
        await this.adjustStrategy(solver, progress.reason);
      }
      
      // Check constraints
      if (!this.satisfiesConstraints(current, constraints)) {
        await solver.backtrack();
      }
      
      iteration++;
    }
    
    return {
      solution: current,
      iterations: iteration,
      strategy: strategy.name,
      metrics: await monitor.getMetrics()
    };
  }

  async verifySolution(solution, problem) {
    // Comprehensive verification
    const verification = await this.server.verify({
      solution,
      problem,
      checks: [
        'correctness',
        'completeness',
        'optimality',
        'robustness'
      ],
      generateProof: true
    });
    
    if (!verification.isValid) {
      // Attempt repair
      const repaired = await this.repairSolution(solution, verification.issues);
      if (repaired) {
        return await this.verifySolution(repaired, problem);
      }
      throw new Error(`Invalid solution: ${verification.issues.join(', ')}`);
    }
    
    return {
      ...solution,
      verification,
      proof: verification.proof
    };
  }
}
```

## Integration with Cognitive Specialists

### Researcher Integration
```javascript
class ResearcherSequentialIntegration {
  constructor(sequentialServer, researcher) {
    this.sequential = sequentialServer;
    this.researcher = researcher;
  }

  async deepResearch(topic, depth = 3) {
    // Create research plan
    const plan = await this.sequential.createResearchPlan({
      topic,
      depth,
      breadthFirst: depth <= 2,
      includeContradictions: true
    });
    
    // Execute research steps
    const findings = [];
    
    for (const step of plan.steps) {
      // Research current step
      const research = await this.researcher.investigate(step.query);
      
      // Analyze with sequential reasoning
      const analysis = await this.sequential.analyzeFindings({
        findings: research,
        context: findings,
        method: 'comparative-analysis'
      });
      
      // Generate follow-up questions
      const followUps = await this.sequential.generateFollowUps({
        analysis,
        maxQuestions: 5,
        prioritize: 'knowledge-gaps'
      });
      
      findings.push({
        step: step.description,
        research,
        analysis,
        followUps
      });
      
      // Add follow-ups to plan if depth allows
      if (step.depth < depth) {
        plan.steps.push(...followUps.map(q => ({
          query: q,
          depth: step.depth + 1,
          parent: step.id
        })));
      }
    }
    
    // Synthesize comprehensive report
    return await this.synthesizeResearch(findings, topic);
  }

  async synthesizeResearch(findings, topic) {
    return await this.sequential.synthesize({
      data: findings,
      topic,
      structure: 'hierarchical',
      includeSummary: true,
      includeConclusions: true,
      includeReferences: true,
      contradictions: 'highlight'
    });
  }
}
```

### Architect Integration
```javascript
class ArchitectSequentialIntegration {
  constructor(sequentialServer, architect) {
    this.sequential = sequentialServer;
    this.architect = architect;
  }

  async designSystem(requirements) {
    // Decompose requirements
    const decomposed = await this.sequential.decomposeRequirements({
      requirements,
      aspects: ['functional', 'non-functional', 'constraints', 'quality']
    });
    
    // Generate architecture alternatives
    const alternatives = [];
    
    for (let i = 0; i < 3; i++) {
      const architecture = await this.generateArchitecture(decomposed, i);
      
      // Evaluate with sequential reasoning
      const evaluation = await this.evaluateArchitecture(architecture, decomposed);
      
      alternatives.push({
        architecture,
        evaluation,
        score: evaluation.overallScore
      });
    }
    
    // Select and refine best architecture
    const best = alternatives.sort((a, b) => b.score - a.score)[0];
    
    // Refine with sequential optimization
    const refined = await this.refineArchitecture(best.architecture, decomposed);
    
    return {
      architecture: refined,
      alternatives,
      rationale: await this.generateRationale(refined, alternatives),
      implementation: await this.generateImplementationPlan(refined)
    };
  }

  async evaluateArchitecture(architecture, requirements) {
    const evaluation = await this.sequential.evaluate({
      subject: architecture,
      criteria: {
        functionalFit: this.assessFunctionalFit(architecture, requirements),
        scalability: this.assessScalability(architecture),
        maintainability: this.assessMaintainability(architecture),
        performance: this.assessPerformance(architecture),
        security: this.assessSecurity(architecture),
        cost: this.assessCost(architecture)
      },
      weights: requirements.priorityWeights || this.getDefaultWeights(),
      method: 'multi-criteria-decision-analysis'
    });
    
    return evaluation;
  }

  async refineArchitecture(architecture, requirements) {
    // Identify improvement areas
    const improvements = await this.sequential.identifyImprovements({
      architecture,
      requirements,
      focusAreas: ['bottlenecks', 'coupling', 'complexity', 'risks']
    });
    
    // Apply improvements iteratively
    let refined = architecture;
    
    for (const improvement of improvements) {
      const applied = await this.architect.applyImprovement(refined, improvement);
      
      // Verify improvement
      const verification = await this.sequential.verifyImprovement({
        before: refined,
        after: applied,
        expected: improvement.expectedBenefits
      });
      
      if (verification.isImproved) {
        refined = applied;
      }
    }
    
    return refined;
  }
}
```

### Debugger Integration
```javascript
class DebuggerSequentialIntegration {
  constructor(sequentialServer, debugger) {
    this.sequential = sequentialServer;
    this.debugger = debugger;
  }

  async debugComplex(issue) {
    // Create debugging strategy
    const strategy = await this.sequential.createDebuggingStrategy({
      issue,
      symptoms: issue.symptoms,
      context: issue.context,
      history: issue.history || []
    });
    
    // Execute debugging steps
    const investigations = [];
    let found = false;
    
    for (const step of strategy.steps) {
      // Perform investigation
      const result = await this.investigateStep(step, investigations);
      investigations.push(result);
      
      // Analyze with sequential reasoning
      const analysis = await this.sequential.analyzeEvidence({
        evidence: investigations,
        hypothesis: step.hypothesis,
        method: 'bayesian-inference'
      });
      
      // Check if root cause found
      if (analysis.confidence > 0.8) {
        found = true;
        break;
      }
      
      // Generate new hypotheses
      const newHypotheses = await this.sequential.generateHypotheses({
        evidence: investigations,
        previous: strategy.steps.map(s => s.hypothesis),
        maxNew: 3
      });
      
      // Add to strategy
      strategy.steps.push(...newHypotheses.map(h => ({
        hypothesis: h,
        tests: this.generateTests(h)
      })));
    }
    
    // Generate fix
    const fix = await this.generateFix(investigations, issue);
    
    return {
      rootCause: this.identifyRootCause(investigations),
      fix,
      investigations,
      confidence: this.calculateConfidence(investigations)
    };
  }

  async investigateStep(step, previousInvestigations) {
    // Run tests for hypothesis
    const testResults = [];
    
    for (const test of step.tests) {
      const result = await this.debugger.runTest(test);
      testResults.push(result);
      
      // Early termination if conclusive
      if (result.conclusive) {
        break;
      }
    }
    
    // Analyze results with sequential reasoning
    const analysis = await this.sequential.analyzeTestResults({
      results: testResults,
      hypothesis: step.hypothesis,
      context: previousInvestigations
    });
    
    return {
      hypothesis: step.hypothesis,
      tests: testResults,
      analysis,
      conclusion: analysis.conclusion
    };
  }
}
```

## Advanced Usage Patterns

### Multi-Modal Reasoning
```javascript
class MultiModalReasoner {
  constructor(sequentialServer) {
    this.server = sequentialServer;
  }

  async reasonWithMultipleModalities(problem) {
    // Process different modalities
    const modalities = await this.server.processModalities({
      problem,
      types: ['logical', 'spatial', 'temporal', 'causal', 'probabilistic']
    });
    
    // Integrate reasoning across modalities
    const integrated = await this.server.integrateModalities({
      modalities,
      method: 'cross-modal-attention',
      resolveConflicts: true
    });
    
    // Generate unified solution
    return await this.server.unifiedReasoning({
      integrated,
      outputFormat: 'comprehensive',
      includeModalityContributions: true
    });
  }
}
```

### Recursive Problem Solving
```javascript
class RecursiveSolver {
  constructor(sequentialServer) {
    this.server = sequentialServer;
    this.depth = 0;
    this.maxDepth = 10;
  }

  async solveRecursively(problem, baseCase = null) {
    // Check base case
    if (baseCase && await this.isBaseCase(problem, baseCase)) {
      return await this.solveBaseCase(problem);
    }
    
    // Check depth limit
    if (this.depth >= this.maxDepth) {
      return await this.approximateSolution(problem);
    }
    
    // Decompose problem
    const subproblems = await this.server.decomposeRecursive({
      problem,
      strategy: 'divide-and-conquer',
      similarity: 0.8
    });
    
    // Solve subproblems
    this.depth++;
    const solutions = [];
    
    for (const subproblem of subproblems) {
      const solution = await this.solveRecursively(subproblem, baseCase);
      solutions.push(solution);
    }
    
    this.depth--;
    
    // Combine solutions
    return await this.server.combineSolutions({
      solutions,
      method: problem.combinationMethod || 'merge',
      validate: true
    });
  }
}
```

### Adversarial Reasoning
```javascript
class AdversarialReasoner {
  constructor(sequentialServer) {
    this.server = sequentialServer;
  }

  async reasonAdversarially(position) {
    // Generate counter-arguments
    const counterArgs = await this.server.generateCounterArguments({
      position,
      strength: 'strongest',
      number: 5
    });
    
    // Defend against each counter-argument
    const defenses = [];
    
    for (const counter of counterArgs) {
      const defense = await this.server.defendPosition({
        original: position,
        attack: counter,
        methods: ['refutation', 'mitigation', 'acceptance-with-modification']
      });
      defenses.push(defense);
    }
    
    // Strengthen original position
    const strengthened = await this.server.strengthenPosition({
      original: position,
      defenses,
      anticipateObjections: true
    });
    
    // Test robustness
    const robustness = await this.testRobustness(strengthened);
    
    return {
      strengthened,
      vulnerabilities: robustness.weakPoints,
      confidence: robustness.score
    };
  }
}
```

## Performance Optimization

### Reasoning Cache
```javascript
class ReasoningCache {
  constructor() {
    this.cache = new Map();
    this.patterns = new Map();
  }

  async cacheReasoning(problem, solution, reasoning) {
    // Extract pattern
    const pattern = await this.extractPattern(problem, solution);
    
    // Store in cache
    this.cache.set(problem.hash, {
      solution,
      reasoning,
      pattern,
      timestamp: Date.now()
    });
    
    // Update pattern database
    if (!this.patterns.has(pattern.type)) {
      this.patterns.set(pattern.type, []);
    }
    this.patterns.get(pattern.type).push(pattern);
  }

  async checkCache(problem) {
    // Direct hit
    if (this.cache.has(problem.hash)) {
      return this.cache.get(problem.hash);
    }
    
    // Pattern matching
    const similarPattern = await this.findSimilarPattern(problem);
    if (similarPattern) {
      return await this.adaptSolution(similarPattern, problem);
    }
    
    return null;
  }
}
```

### Parallel Reasoning
```javascript
class ParallelReasoner {
  constructor(sequentialServer) {
    this.server = sequentialServer;
  }

  async reasonInParallel(problems) {
    // Identify independent problems
    const groups = await this.groupIndependentProblems(problems);
    
    // Process groups in parallel
    const results = await Promise.all(
      groups.map(group => this.processGroup(group))
    );
    
    // Merge results respecting dependencies
    return await this.mergeResults(results, problems);
  }

  async processGroup(group) {
    // Create reasoning pipeline
    const pipeline = await this.server.createPipeline({
      problems: group,
      optimization: 'maximize-parallelism',
      shareContext: true
    });
    
    // Execute pipeline
    return await pipeline.execute();
  }
}
```

## Best Practices

### Problem Decomposition
1. **Start with high-level analysis** - Understand the problem space
2. **Identify natural boundaries** - Find logical separation points
3. **Minimize dependencies** - Create independent subproblems
4. **Verify completeness** - Ensure no aspects are missed
5. **Plan for integration** - Consider how solutions combine

### Chain-of-Thought Design
1. **Make reasoning explicit** - Document each thought step
2. **Validate continuously** - Check logic at each step
3. **Branch when uncertain** - Explore multiple paths
4. **Prune aggressively** - Remove unproductive branches
5. **Synthesize carefully** - Combine insights coherently

### Performance Optimization
1. **Cache reasoning patterns** - Reuse similar solutions
2. **Parallelize when possible** - Process independent steps concurrently
3. **Set depth limits** - Prevent infinite recursion
4. **Monitor resource usage** - Track memory and time
5. **Use heuristics** - Guide search efficiently

### Integration Guidelines
1. **Leverage specialist strengths** - Use appropriate specialists
2. **Share context effectively** - Pass relevant information
3. **Validate across boundaries** - Ensure consistency
4. **Handle failures gracefully** - Provide fallbacks
5. **Document reasoning chains** - Enable debugging

## Example Workflows

### Example 1: Complex Algorithm Design
```javascript
// Initialize sequential reasoning
const sequential = new SequentialThinkingServer();
const architect = new ArchitectSpecialist();
const integration = new ArchitectSequentialIntegration(sequential, architect);

// Design distributed consensus algorithm
const requirements = {
  type: 'distributed-consensus',
  nodes: 1000,
  faultTolerance: 0.33,
  latency: '<100ms',
  throughput: '>10000 tps'
};

const design = await integration.designSystem(requirements);

// Verify correctness with sequential reasoning
const verification = await sequential.verifyAlgorithm({
  algorithm: design.architecture,
  properties: ['safety', 'liveness', 'fault-tolerance'],
  method: 'formal-verification'
});
```

### Example 2: Research Synthesis
```javascript
// Deep research on quantum computing
const researcher = new ResearcherSpecialist();
const researchIntegration = new ResearcherSequentialIntegration(sequential, researcher);

const synthesis = await researchIntegration.deepResearch(
  'Quantum computing applications in cryptography',
  depth = 4
);

// Generate actionable insights
const insights = await sequential.extractInsights({
  research: synthesis,
  focus: 'practical-applications',
  timeframe: '5-years'
});
```

### Example 3: Complex Debugging
```javascript
// Debug distributed system issue
const debugger = new DebuggerSpecialist();
const debugIntegration = new DebuggerSequentialIntegration(sequential, debugger);

const issue = {
  symptoms: ['intermittent-timeouts', 'data-inconsistency', 'memory-leaks'],
  context: { system: 'microservices', scale: 'large' },
  history: ['recent-deployment', 'traffic-spike']
};

const diagnosis = await debugIntegration.debugComplex(issue);

// Generate remediation plan
const plan = await sequential.createRemediationPlan({
  diagnosis,
  constraints: ['zero-downtime', 'gradual-rollout'],
  riskTolerance: 'low'
});
```