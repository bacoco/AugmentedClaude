# Token Optimization Strategies for Claude

## Overview
Token optimization is crucial for maximizing Claude's efficiency and minimizing API costs. This guide provides comprehensive strategies for managing context windows, optimizing prompts, and implementing efficient processing patterns.

## Token Usage Fundamentals

### Understanding Tokens
- **Token Definition**: Roughly 4 characters or 0.75 words on average
- **Context Window**: Claude's maximum input/output capacity
- **Token Counting**: Use tiktoken or Claude's built-in counter
- **Cost Structure**: Input tokens vs output tokens pricing

### Token Limits by Model
```javascript
const TOKEN_LIMITS = {
  'claude-3-opus': 200000,
  'claude-3-sonnet': 200000,
  'claude-3-haiku': 200000,
  'claude-2.1': 200000,
  'claude-2': 100000,
  'claude-instant': 100000
};
```

## Context Window Management

### 1. Sliding Window Technique
```javascript
class ContextWindowManager {
  constructor(maxTokens = 150000) {
    this.maxTokens = maxTokens;
    this.buffer = [];
    this.tokenCount = 0;
  }

  addContext(content, priority = 1) {
    const tokens = this.countTokens(content);
    
    // Remove low-priority items if needed
    while (this.tokenCount + tokens > this.maxTokens) {
      this.removeLowPriorityItem();
    }
    
    this.buffer.push({
      content,
      tokens,
      priority,
      timestamp: Date.now()
    });
    
    this.tokenCount += tokens;
  }

  getContext() {
    // Sort by priority and recency
    return this.buffer
      .sort((a, b) => {
        if (a.priority !== b.priority) {
          return b.priority - a.priority;
        }
        return b.timestamp - a.timestamp;
      })
      .map(item => item.content)
      .join('\n\n');
  }

  removeLowPriorityItem() {
    const sorted = this.buffer.sort((a, b) => a.priority - b.priority);
    const removed = sorted.shift();
    this.tokenCount -= removed.tokens;
  }
}
```

### 2. Context Compression
```javascript
class ContextCompressor {
  // Remove redundant information
  static compress(text) {
    return text
      // Remove extra whitespace
      .replace(/\s+/g, ' ')
      // Remove comments in code
      .replace(/\/\*[\s\S]*?\*\//g, '')
      .replace(/\/\/.*/g, '')
      // Abbreviate common patterns
      .replace(/function/g, 'fn')
      .replace(/return/g, 'ret')
      .replace(/const/g, 'c')
      .replace(/let/g, 'l')
      .trim();
  }

  // Summarize long content
  static async summarize(longText, maxTokens = 1000) {
    const prompt = `Summarize the following in ${maxTokens} tokens or less, preserving key information:\n\n${longText}`;
    // Call Claude API for summarization
    return await claude.summarize(prompt);
  }

  // Extract key information
  static extractKeyInfo(text) {
    const patterns = {
      functions: /(?:function|const|let)\s+(\w+)\s*=/g,
      classes: /class\s+(\w+)/g,
      imports: /import\s+.+\s+from\s+['"](.+)['"]/g,
      errors: /error|exception|fail/gi
    };

    const extracted = {
      functions: [],
      classes: [],
      imports: [],
      errors: []
    };

    for (const [key, pattern] of Object.entries(patterns)) {
      let match;
      while ((match = pattern.exec(text)) !== null) {
        extracted[key].push(match[1] || match[0]);
      }
    }

    return extracted;
  }
}
```

### 3. Dynamic Context Loading
```javascript
class DynamicContextLoader {
  constructor() {
    this.contextCache = new Map();
    this.relevanceScores = new Map();
  }

  async loadRelevantContext(query, availableTokens) {
    // Score all available contexts
    const contexts = await this.getAllContexts();
    const scored = contexts.map(ctx => ({
      ...ctx,
      score: this.calculateRelevance(query, ctx.content)
    }));

    // Sort by relevance
    scored.sort((a, b) => b.score - a.score);

    // Load until token limit
    const loaded = [];
    let usedTokens = 0;

    for (const ctx of scored) {
      if (usedTokens + ctx.tokens <= availableTokens) {
        loaded.push(ctx);
        usedTokens += ctx.tokens;
      }
    }

    return loaded;
  }

  calculateRelevance(query, content) {
    // Simple keyword matching (can be enhanced with embeddings)
    const queryWords = query.toLowerCase().split(/\s+/);
    const contentWords = content.toLowerCase().split(/\s+/);
    
    let matches = 0;
    for (const word of queryWords) {
      if (contentWords.includes(word)) {
        matches++;
      }
    }
    
    return matches / queryWords.length;
  }
}
```

## Efficient Prompt Engineering

### 1. Prompt Templates
```javascript
const OPTIMIZED_PROMPTS = {
  // Concise instruction format
  task: (action, target) => `${action}: ${target}`,
  
  // Structured format for complex tasks
  complex: {
    role: 'You are a code assistant',
    task: 'Implement feature X',
    constraints: ['TypeScript', 'No external dependencies'],
    output: 'Provide code only'
  },
  
  // Compressed format for simple queries
  query: (q) => `Q: ${q}\nA:`,
  
  // Batch format for multiple operations
  batch: (operations) => operations.map((op, i) => `${i+1}. ${op}`).join('\n')
};

// Prompt compression function
function compressPrompt(prompt) {
  const abbreviations = {
    'please': 'pls',
    'function': 'fn',
    'variable': 'var',
    'return': 'ret',
    'implement': 'impl',
    'create': 'mk',
    'update': 'upd',
    'delete': 'del'
  };
  
  let compressed = prompt.toLowerCase();
  for (const [full, abbr] of Object.entries(abbreviations)) {
    compressed = compressed.replace(new RegExp(full, 'g'), abbr);
  }
  
  return compressed;
}
```

### 2. Few-Shot Optimization
```javascript
class FewShotOptimizer {
  static selectBestExamples(task, examples, maxExamples = 3) {
    // Score examples by relevance
    const scored = examples.map(ex => ({
      ...ex,
      score: this.calculateSimilarity(task, ex.input)
    }));
    
    // Select top examples within token budget
    return scored
      .sort((a, b) => b.score - a.score)
      .slice(0, maxExamples)
      .map(ex => ({
        input: this.compressExample(ex.input),
        output: this.compressExample(ex.output)
      }));
  }
  
  static compressExample(text) {
    // Remove unnecessary details
    return text
      .replace(/\s+/g, ' ')
      .replace(/[^\w\s\-\.]/g, '')
      .trim()
      .substring(0, 200); // Limit length
  }
  
  static formatExamples(examples) {
    return examples
      .map(ex => `In: ${ex.input}\nOut: ${ex.output}`)
      .join('\n---\n');
  }
}
```

### 3. Response Format Optimization
```javascript
const RESPONSE_FORMATS = {
  // JSON-only response
  json: {
    instruction: 'Respond only with valid JSON',
    example: '{"result": "value", "status": "success"}'
  },
  
  // Code-only response
  code: {
    instruction: 'Respond only with executable code, no explanations',
    example: 'function example() { return true; }'
  },
  
  // Structured response
  structured: {
    instruction: 'Use this exact format:\nSUMMARY: [brief]\nDETAILS: [list]\nCODE: [if applicable]',
    maxTokens: 500
  },
  
  // Minimal response
  minimal: {
    instruction: 'Answer in the fewest words possible',
    example: 'Yes/No/Unknown'
  }
};
```

## Batch Processing Optimization

### 1. Intelligent Batching
```javascript
class BatchProcessor {
  constructor(batchSize = 10, maxTokensPerBatch = 50000) {
    this.batchSize = batchSize;
    this.maxTokensPerBatch = maxTokensPerBatch;
    this.queue = [];
  }

  addTask(task) {
    const tokens = this.estimateTokens(task);
    this.queue.push({ task, tokens });
    
    if (this.shouldProcessBatch()) {
      return this.processBatch();
    }
  }

  shouldProcessBatch() {
    const totalTokens = this.queue.reduce((sum, item) => sum + item.tokens, 0);
    return this.queue.length >= this.batchSize || totalTokens >= this.maxTokensPerBatch;
  }

  async processBatch() {
    const batch = this.queue.splice(0, this.batchSize);
    const batchPrompt = this.createBatchPrompt(batch);
    
    const response = await claude.process(batchPrompt);
    return this.parseBatchResponse(response);
  }

  createBatchPrompt(batch) {
    const header = 'Process these tasks efficiently. Respond with numbered results:\n\n';
    const tasks = batch.map((item, i) => `${i+1}. ${item.task}`).join('\n');
    return header + tasks;
  }

  parseBatchResponse(response) {
    // Parse numbered responses
    const results = response.split(/\d+\.\s+/).filter(r => r.trim());
    return results;
  }
}
```

### 2. Parallel Processing
```javascript
class ParallelTokenOptimizer {
  static async processInParallel(tasks, maxConcurrent = 3) {
    const chunks = this.chunkByTokens(tasks);
    const results = [];
    
    // Process chunks with concurrency limit
    for (let i = 0; i < chunks.length; i += maxConcurrent) {
      const batch = chunks.slice(i, i + maxConcurrent);
      const batchResults = await Promise.all(
        batch.map(chunk => this.processChunk(chunk))
      );
      results.push(...batchResults);
    }
    
    return results;
  }

  static chunkByTokens(tasks, maxTokensPerChunk = 40000) {
    const chunks = [];
    let currentChunk = [];
    let currentTokens = 0;
    
    for (const task of tasks) {
      const tokens = this.estimateTokens(task);
      
      if (currentTokens + tokens > maxTokensPerChunk && currentChunk.length > 0) {
        chunks.push(currentChunk);
        currentChunk = [];
        currentTokens = 0;
      }
      
      currentChunk.push(task);
      currentTokens += tokens;
    }
    
    if (currentChunk.length > 0) {
      chunks.push(currentChunk);
    }
    
    return chunks;
  }
}
```

## Memory Usage Optimization

### 1. Selective Memory Storage
```javascript
class MemoryOptimizer {
  static storeSelectively(key, data) {
    // Compress before storing
    const compressed = this.compress(data);
    
    // Store only if valuable
    if (this.isValuable(compressed)) {
      return Memory.store(key, compressed);
    }
    
    return null;
  }

  static compress(data) {
    if (typeof data === 'string') {
      // Remove redundancy
      return data
        .replace(/\s+/g, ' ')
        .replace(/(\w+)\s+\1/g, '$1') // Remove duplicate words
        .trim();
    }
    
    if (typeof data === 'object') {
      // Remove null/undefined values
      return Object.entries(data)
        .filter(([_, v]) => v != null)
        .reduce((acc, [k, v]) => ({ ...acc, [k]: v }), {});
    }
    
    return data;
  }

  static isValuable(data) {
    // Check if data contains valuable information
    const valuable = [
      'error', 'solution', 'result', 'config',
      'architecture', 'decision', 'api', 'key'
    ];
    
    const text = JSON.stringify(data).toLowerCase();
    return valuable.some(keyword => text.includes(keyword));
  }
}
```

### 2. Memory Lifecycle Management
```javascript
class MemoryLifecycle {
  static async cleanupOldMemory(daysOld = 7) {
    const allKeys = await Memory.list();
    const now = Date.now();
    const threshold = daysOld * 24 * 60 * 60 * 1000;
    
    for (const key of allKeys) {
      const metadata = await Memory.getMetadata(key);
      if (now - metadata.timestamp > threshold) {
        await Memory.delete(key);
      }
    }
  }

  static async compactMemory() {
    const allData = await Memory.exportAll();
    const compacted = {};
    
    // Group similar data
    for (const [key, value] of Object.entries(allData)) {
      const category = this.categorize(key);
      if (!compacted[category]) {
        compacted[category] = {};
      }
      compacted[category][key] = value;
    }
    
    // Re-import compacted data
    await Memory.clear();
    for (const [category, data] of Object.entries(compacted)) {
      await Memory.store(category, data);
    }
  }
}
```

## Reference Compression Techniques

### 1. Code Reference Compression
```javascript
class CodeReferenceCompressor {
  static compressFileReference(filePath, content) {
    const summary = {
      path: filePath,
      exports: this.extractExports(content),
      imports: this.extractImports(content),
      functions: this.extractFunctionSignatures(content),
      classes: this.extractClassSignatures(content),
      size: content.length,
      hash: this.hash(content)
    };
    
    return JSON.stringify(summary);
  }

  static extractFunctionSignatures(content) {
    const regex = /(?:export\s+)?(?:async\s+)?function\s+(\w+)\s*\([^)]*\)/g;
    const signatures = [];
    let match;
    
    while ((match = regex.exec(content)) !== null) {
      signatures.push(match[0].replace(/\s+/g, ' '));
    }
    
    return signatures;
  }

  static expandReference(compressedRef) {
    const ref = JSON.parse(compressedRef);
    return `File: ${ref.path}
Exports: ${ref.exports.join(', ')}
Functions: ${ref.functions.join('\n')}
Classes: ${ref.classes.join(', ')}`;
  }
}
```

### 2. Documentation Compression
```javascript
class DocCompressor {
  static compressDocumentation(docs) {
    return {
      // Keep only essential sections
      summary: this.extractSection(docs, 'summary', 200),
      usage: this.extractSection(docs, 'usage', 300),
      params: this.extractParameters(docs),
      returns: this.extractReturns(docs),
      examples: this.compressExamples(docs)
    };
  }

  static extractSection(docs, section, maxLength) {
    const regex = new RegExp(`#+ ${section}([^#]+)`, 'i');
    const match = docs.match(regex);
    if (match) {
      return match[1].trim().substring(0, maxLength);
    }
    return '';
  }

  static compressExamples(docs) {
    const examples = docs.match(/```[\s\S]*?```/g) || [];
    // Keep only first 2 examples, compressed
    return examples
      .slice(0, 2)
      .map(ex => ex.replace(/\s+/g, ' ').substring(0, 100));
  }
}
```

## Performance Monitoring

### 1. Token Usage Tracking
```javascript
class TokenUsageMonitor {
  constructor() {
    this.usage = {
      total: 0,
      byModel: {},
      byTask: {},
      byHour: {}
    };
  }

  track(model, task, tokens) {
    this.usage.total += tokens;
    
    // Track by model
    if (!this.usage.byModel[model]) {
      this.usage.byModel[model] = 0;
    }
    this.usage.byModel[model] += tokens;
    
    // Track by task type
    if (!this.usage.byTask[task]) {
      this.usage.byTask[task] = 0;
    }
    this.usage.byTask[task] += tokens;
    
    // Track by hour
    const hour = new Date().getHours();
    if (!this.usage.byHour[hour]) {
      this.usage.byHour[hour] = 0;
    }
    this.usage.byHour[hour] += tokens;
  }

  getReport() {
    return {
      total: this.usage.total,
      average: this.usage.total / Object.keys(this.usage.byTask).length,
      mostExpensiveTask: this.getMostExpensive(this.usage.byTask),
      peakHour: this.getMostExpensive(this.usage.byHour),
      recommendations: this.generateRecommendations()
    };
  }

  generateRecommendations() {
    const recommendations = [];
    
    // Check for expensive tasks
    for (const [task, tokens] of Object.entries(this.usage.byTask)) {
      if (tokens > 10000) {
        recommendations.push(`Consider optimizing ${task} - uses ${tokens} tokens`);
      }
    }
    
    // Check for peak usage
    const peakHour = this.getMostExpensive(this.usage.byHour);
    recommendations.push(`Schedule heavy tasks outside peak hour: ${peakHour.key}`);
    
    return recommendations;
  }

  getMostExpensive(usage) {
    return Object.entries(usage)
      .sort(([, a], [, b]) => b - a)
      .map(([key, value]) => ({ key, value }))[0];
  }
}
```

### 2. Optimization Analytics
```javascript
class OptimizationAnalytics {
  static analyzeTokenEfficiency(input, output) {
    const metrics = {
      inputTokens: this.countTokens(input),
      outputTokens: this.countTokens(output),
      ratio: this.countTokens(output) / this.countTokens(input),
      quality: this.assessQuality(output),
      efficiency: null
    };
    
    // Calculate efficiency score
    metrics.efficiency = metrics.quality / metrics.ratio;
    
    return metrics;
  }

  static assessQuality(output) {
    let score = 0;
    
    // Check for completeness
    if (output.includes('```')) score += 20; // Contains code
    if (output.match(/\d+\./g)) score += 10; // Contains lists
    if (output.length > 100) score += 10; // Substantial response
    
    // Check for accuracy indicators
    if (!output.includes('I cannot')) score += 20;
    if (!output.includes('unclear')) score += 10;
    
    // Check for structure
    if (output.includes('\n')) score += 10; // Formatted
    if (output.match(/[A-Z][a-z]+:/)) score += 10; // Has sections
    
    return Math.min(score, 100);
  }
}
```

## Best Practices Summary

### Do's
1. **Always estimate tokens** before making API calls
2. **Compress context** when approaching limits
3. **Batch similar operations** for efficiency
4. **Monitor usage patterns** to identify optimization opportunities
5. **Use structured formats** to reduce token overhead
6. **Cache frequently used contexts** to avoid reprocessing
7. **Implement sliding windows** for long conversations
8. **Prioritize recent and relevant** information

### Don'ts
1. **Don't include unnecessary formatting** or whitespace
2. **Don't repeat information** already in context
3. **Don't use verbose prompt styles** when concise works
4. **Don't ignore token limits** until errors occur
5. **Don't store redundant data** in memory
6. **Don't process large batches** without chunking
7. **Don't forget to clean up** old context regularly

### Quick Reference Formulas
```javascript
// Estimate tokens from text
const estimateTokens = (text) => Math.ceil(text.length / 4);

// Calculate cost
const calculateCost = (inputTokens, outputTokens) => {
  const INPUT_RATE = 0.00001; // $0.01 per 1K tokens
  const OUTPUT_RATE = 0.00003; // $0.03 per 1K tokens
  return (inputTokens * INPUT_RATE + outputTokens * OUTPUT_RATE) / 1000;
};

// Determine optimal batch size
const optimalBatchSize = (avgTokensPerItem, maxContextTokens) => {
  return Math.floor(maxContextTokens * 0.8 / avgTokensPerItem);
};

// Context window utilization
const contextUtilization = (usedTokens, maxTokens) => {
  return (usedTokens / maxTokens * 100).toFixed(2) + '%';
};
```