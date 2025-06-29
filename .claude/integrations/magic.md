# Magic UI Server MCP Integration

## Overview
The Magic UI Server provides advanced UI component generation, prototyping, and design capabilities through MCP (Model Context Protocol). It seamlessly integrates with AugmentedClaude's frontend-dev and ux-designer specialists to create interactive components and design systems.

## Core Capabilities

### Component Generation
```javascript
// Generate React components with Magic UI
const MagicUIGenerator = {
  // Create a complete component from description
  async generateComponent(description, options = {}) {
    const config = {
      framework: options.framework || 'react',
      styling: options.styling || 'styled-components',
      typescript: options.typescript !== false,
      testable: options.testable !== false,
      accessible: options.accessible !== false
    };
    
    return await magicUI.create({
      type: 'component',
      description,
      config
    });
  },
  
  // Generate component variations
  async generateVariations(baseComponent, variations) {
    const results = [];
    for (const variation of variations) {
      const variant = await magicUI.modify({
        base: baseComponent,
        changes: variation,
        preserveLogic: true
      });
      results.push(variant);
    }
    return results;
  },
  
  // Create responsive layouts
  async generateLayout(layoutSpec) {
    return await magicUI.create({
      type: 'layout',
      spec: layoutSpec,
      responsive: true,
      breakpoints: ['mobile', 'tablet', 'desktop', 'wide']
    });
  }
};
```

### UI Prototyping Workflows

#### 1. Rapid Prototyping
```javascript
class RapidPrototyper {
  constructor(magicServer) {
    this.magic = magicServer;
    this.components = new Map();
  }
  
  async createPrototype(concept) {
    // Generate wireframe
    const wireframe = await this.magic.generate({
      type: 'wireframe',
      concept: concept.description,
      pages: concept.pages || ['home', 'dashboard', 'settings']
    });
    
    // Convert to interactive prototype
    const prototype = await this.magic.enhance({
      wireframe,
      interactions: true,
      animations: true,
      mockData: true
    });
    
    // Add navigation flow
    const withNavigation = await this.addNavigation(prototype);
    
    return {
      wireframe,
      prototype: withNavigation,
      preview: await this.generatePreviewURL(withNavigation)
    };
  }
  
  async iterateDesign(prototype, feedback) {
    // Apply feedback to existing prototype
    const updated = await this.magic.iterate({
      prototype,
      feedback,
      preserveCore: true,
      enhanceUX: true
    });
    
    // Generate comparison view
    const comparison = await this.magic.compare({
      before: prototype,
      after: updated,
      highlightChanges: true
    });
    
    return { updated, comparison };
  }
  
  async addNavigation(prototype) {
    const navigation = await this.magic.generateNavigation({
      pages: prototype.pages,
      style: prototype.designSystem?.navigation || 'default',
      transitions: 'smooth'
    });
    
    return {
      ...prototype,
      navigation,
      routes: this.generateRoutes(prototype.pages)
    };
  }
}
```

#### 2. Design System Integration
```javascript
class DesignSystemBuilder {
  constructor(magicServer) {
    this.magic = magicServer;
    this.tokens = {};
    this.components = {};
  }
  
  async createDesignSystem(brand) {
    // Generate design tokens
    this.tokens = await this.magic.generateTokens({
      brand: brand.name,
      primaryColor: brand.primaryColor,
      mood: brand.mood || 'professional',
      accessibility: 'WCAG-AA'
    });
    
    // Create component library
    const componentTypes = [
      'Button', 'Input', 'Card', 'Modal',
      'Navigation', 'Table', 'Form', 'Alert'
    ];
    
    for (const type of componentTypes) {
      this.components[type] = await this.generateComponent(type);
    }
    
    // Generate documentation
    const docs = await this.generateDocumentation();
    
    return {
      tokens: this.tokens,
      components: this.components,
      documentation: docs,
      exportFormats: ['figma', 'sketch', 'css', 'js']
    };
  }
  
  async generateComponent(type) {
    const component = await this.magic.generateSystemComponent({
      type,
      tokens: this.tokens,
      variants: this.getVariantsForType(type),
      states: ['default', 'hover', 'active', 'disabled', 'loading'],
      sizes: ['small', 'medium', 'large']
    });
    
    // Add interaction patterns
    const withInteractions = await this.addInteractionPatterns(component, type);
    
    // Generate tests
    const tests = await this.generateComponentTests(withInteractions);
    
    return {
      component: withInteractions,
      tests,
      usage: await this.generateUsageExamples(type)
    };
  }
  
  getVariantsForType(type) {
    const variants = {
      Button: ['primary', 'secondary', 'ghost', 'danger'],
      Input: ['text', 'password', 'email', 'number', 'search'],
      Card: ['default', 'elevated', 'outlined', 'interactive'],
      Modal: ['default', 'fullscreen', 'drawer', 'confirmation']
    };
    return variants[type] || ['default'];
  }
  
  async generateDocumentation() {
    return await this.magic.generateDocs({
      system: {
        tokens: this.tokens,
        components: Object.keys(this.components)
      },
      format: 'interactive',
      examples: true,
      playground: true
    });
  }
}
```

### Interactive Component Testing
```javascript
class InteractiveComponentTester {
  constructor(magicServer) {
    this.magic = magicServer;
    this.testResults = [];
  }
  
  async testComponent(component, scenarios) {
    const results = [];
    
    for (const scenario of scenarios) {
      const result = await this.runScenario(component, scenario);
      results.push(result);
    }
    
    // Visual regression testing
    const visualTests = await this.runVisualTests(component);
    
    // Accessibility testing
    const a11yTests = await this.runAccessibilityTests(component);
    
    // Performance testing
    const perfTests = await this.runPerformanceTests(component);
    
    return {
      scenarios: results,
      visual: visualTests,
      accessibility: a11yTests,
      performance: perfTests,
      summary: this.generateTestSummary(results)
    };
  }
  
  async runScenario(component, scenario) {
    // Create test environment
    const env = await this.magic.createTestEnv({
      component,
      props: scenario.props,
      context: scenario.context
    });
    
    // Execute interactions
    const interactions = [];
    for (const action of scenario.actions) {
      const result = await env.execute(action);
      interactions.push({
        action,
        result,
        snapshot: await env.snapshot()
      });
    }
    
    // Verify outcomes
    const assertions = await this.verifyAssertions(env, scenario.expect);
    
    return {
      scenario: scenario.name,
      passed: assertions.every(a => a.passed),
      interactions,
      assertions
    };
  }
  
  async runVisualTests(component) {
    const viewports = [
      { width: 375, height: 667, name: 'mobile' },
      { width: 768, height: 1024, name: 'tablet' },
      { width: 1920, height: 1080, name: 'desktop' }
    ];
    
    const results = [];
    for (const viewport of viewports) {
      const screenshot = await this.magic.renderComponent({
        component,
        viewport,
        theme: 'light'
      });
      
      const comparison = await this.magic.compareVisual({
        current: screenshot,
        baseline: await this.getBaseline(component, viewport),
        threshold: 0.1
      });
      
      results.push({
        viewport: viewport.name,
        passed: comparison.difference < 0.1,
        difference: comparison.difference,
        areas: comparison.changedAreas
      });
    }
    
    return results;
  }
}
```

## Specialist Integration

### Frontend Developer Integration
```javascript
class FrontendDevMagicIntegration {
  constructor(magicServer, specialist) {
    this.magic = magicServer;
    this.specialist = specialist;
  }
  
  async enhanceComponent(componentCode) {
    // Analyze existing component
    const analysis = await this.specialist.analyzeComponent(componentCode);
    
    // Generate improvements via Magic
    const enhanced = await this.magic.enhance({
      code: componentCode,
      improvements: analysis.suggestions,
      maintainAPI: true,
      addFeatures: [
        'error-boundaries',
        'loading-states',
        'animations',
        'keyboard-navigation'
      ]
    });
    
    // Add TypeScript types if missing
    if (!analysis.hasTypes) {
      enhanced.types = await this.magic.generateTypes({
        component: enhanced.code,
        strict: true
      });
    }
    
    // Generate tests
    enhanced.tests = await this.generateComponentTests(enhanced);
    
    // Create storybook stories
    enhanced.stories = await this.generateStories(enhanced);
    
    return enhanced;
  }
  
  async generateStories(component) {
    return await this.magic.generateStories({
      component,
      scenarios: [
        'default',
        'with-all-props',
        'edge-cases',
        'interactive',
        'responsive'
      ],
      controls: true,
      docs: true
    });
  }
  
  async optimizeBundle(components) {
    // Analyze component dependencies
    const analysis = await this.magic.analyzeDependencies({
      components,
      findDuplicates: true,
      findUnused: true
    });
    
    // Generate optimized bundle
    const optimized = await this.magic.optimizeBundle({
      components,
      techniques: [
        'tree-shaking',
        'code-splitting',
        'lazy-loading',
        'css-extraction'
      ],
      targetSize: '50kb'
    });
    
    return {
      original: analysis.bundleSize,
      optimized: optimized.bundleSize,
      savings: analysis.bundleSize - optimized.bundleSize,
      techniques: optimized.appliedTechniques
    };
  }
}
```

### UX Designer Integration
```javascript
class UXDesignerMagicIntegration {
  constructor(magicServer, specialist) {
    this.magic = magicServer;
    this.specialist = specialist;
  }
  
  async createUserFlow(requirements) {
    // Generate user personas
    const personas = await this.specialist.generatePersonas(requirements);
    
    // Create user journey for each persona
    const journeys = [];
    for (const persona of personas) {
      const journey = await this.magic.generateUserJourney({
        persona,
        goals: requirements.goals,
        constraints: requirements.constraints
      });
      journeys.push(journey);
    }
    
    // Convert to interactive flow
    const flow = await this.magic.createInteractiveFlow({
      journeys,
      style: 'modern',
      annotations: true
    });
    
    // Generate UI mockups for each screen
    const mockups = await this.generateMockups(flow);
    
    return {
      personas,
      journeys,
      flow,
      mockups,
      prototype: await this.createPrototype(mockups)
    };
  }
  
  async generateMockups(flow) {
    const mockups = [];
    
    for (const screen of flow.screens) {
      const mockup = await this.magic.generateMockup({
        screen,
        fidelity: 'high',
        includeContent: true,
        includeInteractions: true
      });
      
      // Apply UX best practices
      const enhanced = await this.applyUXPrinciples(mockup);
      
      mockups.push(enhanced);
    }
    
    return mockups;
  }
  
  async applyUXPrinciples(mockup) {
    return await this.magic.enhanceUX({
      mockup,
      principles: [
        'visual-hierarchy',
        'gestalt-principles',
        'fitts-law',
        'hicks-law',
        'jakob-nielsen-heuristics'
      ],
      accessibility: 'WCAG-AAA',
      cognitive: 'reduce-load'
    });
  }
  
  async conductUsabilityTest(prototype, testUsers) {
    const results = [];
    
    for (const user of testUsers) {
      const session = await this.magic.startUsabilitySession({
        prototype,
        user,
        tasks: this.generateTestTasks(prototype),
        recording: true
      });
      
      // Track interactions
      const metrics = await session.collectMetrics([
        'time-on-task',
        'error-rate',
        'completion-rate',
        'satisfaction-score'
      ]);
      
      // Generate heatmaps
      const heatmaps = await session.generateHeatmaps();
      
      // Collect feedback
      const feedback = await session.collectFeedback();
      
      results.push({
        user,
        metrics,
        heatmaps,
        feedback,
        recommendations: await this.generateRecommendations(metrics, feedback)
      });
    }
    
    return {
      results,
      summary: await this.summarizeUsabilityTests(results),
      improvements: await this.prioritizeImprovements(results)
    };
  }
}
```

## Usage Examples

### Example 1: Creating a Dashboard Component
```javascript
// Initialize Magic UI
const magic = new MagicUIServer();
const frontendDev = new FrontendDevSpecialist();
const integration = new FrontendDevMagicIntegration(magic, frontendDev);

// Generate dashboard component
const dashboard = await magic.generateComponent(
  'Analytics dashboard with real-time charts, KPI cards, and filtering',
  {
    framework: 'react',
    styling: 'tailwind',
    typescript: true,
    features: [
      'real-time-updates',
      'responsive-grid',
      'dark-mode',
      'export-functionality'
    ]
  }
);

// Enhance with specialist knowledge
const enhanced = await integration.enhanceComponent(dashboard.code);

// Test the component
const tester = new InteractiveComponentTester(magic);
const testResults = await tester.testComponent(enhanced, [
  {
    name: 'Data updates',
    props: { data: mockData },
    actions: [
      { type: 'wait', duration: 1000 },
      { type: 'click', target: 'refresh-button' },
      { type: 'wait', duration: 500 }
    ],
    expect: {
      dataUpdated: true,
      loadingStateShown: true
    }
  }
]);
```

### Example 2: Design System Creation
```javascript
// Create design system
const designBuilder = new DesignSystemBuilder(magic);
const designSystem = await designBuilder.createDesignSystem({
  name: 'AugmentedUI',
  primaryColor: '#0066CC',
  mood: 'modern-professional'
});

// Export for different platforms
const exports = await magic.exportDesignSystem({
  system: designSystem,
  formats: ['figma', 'css-variables', 'react-components', 'style-dictionary']
});

// Generate implementation guide
const guide = await magic.generateImplementationGuide({
  system: designSystem,
  framework: 'react',
  includeExamples: true,
  includePlayground: true
});
```

### Example 3: UX Flow Design
```javascript
// Initialize UX integration
const uxDesigner = new UXDesignerSpecialist();
const uxIntegration = new UXDesignerMagicIntegration(magic, uxDesigner);

// Create user flow for e-commerce checkout
const checkoutFlow = await uxIntegration.createUserFlow({
  goals: ['Complete purchase', 'Minimize cart abandonment'],
  constraints: ['Mobile-first', '3-step maximum', 'Guest checkout option']
});

// Run usability tests
const testResults = await uxIntegration.conductUsabilityTest(
  checkoutFlow.prototype,
  [
    { id: 1, persona: 'first-time-buyer' },
    { id: 2, persona: 'returning-customer' },
    { id: 3, persona: 'mobile-user' }
  ]
);

// Apply improvements based on test results
const improved = await magic.applyImprovements({
  prototype: checkoutFlow.prototype,
  recommendations: testResults.improvements
});
```

## Best Practices

### Component Generation
1. **Start with clear requirements** - Provide detailed descriptions
2. **Use semantic naming** - Ensure generated components have meaningful names
3. **Include accessibility** - Always enable accessible features
4. **Generate tests** - Create tests alongside components
5. **Document usage** - Generate examples and documentation

### Design System Management
1. **Define tokens first** - Establish consistent design tokens
2. **Create variations** - Generate all necessary component variants
3. **Test combinations** - Verify components work together
4. **Version control** - Track design system changes
5. **Provide migration guides** - Help teams adopt updates

### Prototyping Workflow
1. **Iterate quickly** - Use rapid prototyping for exploration
2. **Test early** - Conduct usability tests on prototypes
3. **Gather feedback** - Collect user input throughout
4. **Document decisions** - Track design rationale
5. **Export assets** - Provide developer-ready resources

### Performance Optimization
1. **Lazy load components** - Generate code-split components
2. **Optimize images** - Use appropriate formats and sizes
3. **Minimize bundle size** - Remove unused code
4. **Cache effectively** - Implement proper caching strategies
5. **Monitor metrics** - Track component performance

## Advanced Features

### AI-Powered Design Suggestions
```javascript
// Get design suggestions based on content
const suggestions = await magic.suggestDesign({
  content: 'User profile page with activity feed',
  context: 'social-media-app',
  constraints: ['mobile-first', 'high-engagement']
});

// Apply suggestions automatically
const designed = await magic.applyDesignSuggestions({
  component: profilePage,
  suggestions: suggestions.top3,
  preserveStructure: true
});
```

### Automated Accessibility Enhancement
```javascript
// Enhance component accessibility
const accessible = await magic.enhanceAccessibility({
  component: originalComponent,
  level: 'WCAG-AAA',
  features: [
    'keyboard-navigation',
    'screen-reader-support',
    'high-contrast-mode',
    'focus-indicators',
    'skip-links'
  ]
});

// Generate accessibility report
const report = await magic.generateA11yReport({
  component: accessible,
  includeRemediation: true
});
```

### Design Token Management
```javascript
// Generate design tokens from brand guidelines
const tokens = await magic.generateTokensFromBrand({
  brandGuide: 'path/to/brand-guide.pdf',
  includeSemanticTokens: true
});

// Propagate token changes
const updated = await magic.propagateTokenChanges({
  tokens: updatedTokens,
  components: existingComponents,
  generateMigration: true
});
```

## Integration Points

### With SPARC Specialists
- **Orchestrator**: Coordinates Magic UI tasks in larger workflows
- **Coder**: Implements generated components in the codebase
- **Reviewer**: Reviews generated code for quality and standards
- **Tester**: Creates comprehensive test suites for components
- **Documenter**: Generates complete component documentation

### With Other MCP Servers
- **Sequential**: Uses multi-step reasoning for complex UI logic
- **Memory**: Stores design decisions and component history
- **Analytics**: Tracks component usage and performance

### With External Tools
- **Figma**: Import/export designs
- **Storybook**: Generate stories automatically
- **Jest**: Create test suites
- **Webpack**: Optimize bundles
- **CI/CD**: Integrate visual regression testing