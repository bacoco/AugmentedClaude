# Deployment Patterns

## Pattern Name & Overview

**Deployment Patterns** are strategies and practices for reliably delivering software from development to production. These patterns cover continuous integration/deployment, infrastructure management, release strategies, and operational excellence to ensure smooth, safe, and efficient software delivery.

## Problem Context (When to Use)

Apply deployment patterns when:
- Releasing software frequently with minimal risk
- Managing multiple environments (dev, staging, production)
- Scaling applications to handle varying loads
- Implementing zero-downtime deployments
- Ensuring consistent deployments across teams
- Managing configuration and secrets securely
- Rolling back deployments safely when issues occur

## Solution

Deployment patterns are organized into several categories:

1. **Release Strategies**: Blue-green, canary, rolling deployments
2. **Infrastructure Patterns**: Infrastructure as Code, immutable infrastructure
3. **Container Patterns**: Docker, Kubernetes orchestration
4. **CI/CD Patterns**: Automated pipelines and testing
5. **Configuration Management**: Environment-specific configurations
6. **Monitoring & Observability**: Deployment tracking and health checks
7. **Rollback Strategies**: Safe rollback mechanisms

## Implementation Guidelines

### 1. Release Strategies

#### Blue-Green Deployment
```yaml
# Kubernetes blue-green deployment
apiVersion: v1
kind: Service
metadata:
  name: app-service
spec:
  selector:
    app: myapp
    version: green  # Switch between blue/green
  ports:
    - port: 80
      targetPort: 8080

---
# Blue deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: app
        image: myapp:1.0.0
        ports:
        - containerPort: 8080
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
          initialDelaySeconds: 10
          periodSeconds: 5

---
# Green deployment (new version)
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: green
  template:
    metadata:
      labels:
        app: myapp
        version: green
    spec:
      containers:
      - name: app
        image: myapp:2.0.0
        ports:
        - containerPort: 8080
```

```javascript
// Blue-green deployment script
class BlueGreenDeployment {
  constructor(config) {
    this.config = config;
    this.kubectl = new KubernetesClient();
  }

  async deploy(newVersion) {
    try {
      // 1. Determine current active version
      const currentActive = await this.getCurrentActiveVersion();
      const newColor = currentActive === 'blue' ? 'green' : 'blue';

      console.log(`Current active: ${currentActive}, deploying to: ${newColor}`);

      // 2. Deploy new version to inactive environment
      await this.deployVersion(newColor, newVersion);

      // 3. Wait for new deployment to be ready
      await this.waitForDeploymentReady(newColor);

      // 4. Run smoke tests
      await this.runSmokeTests(newColor);

      // 5. Switch traffic to new version
      await this.switchTraffic(newColor);

      // 6. Monitor for issues
      await this.monitorDeployment(newColor);

      // 7. Clean up old version (optional)
      if (this.config.cleanupOldVersion) {
        await this.scheduleCleanup(currentActive, 30); // 30 minutes
      }

      console.log(`Successfully deployed ${newVersion} to ${newColor}`);
    } catch (error) {
      console.error('Deployment failed:', error);
      await this.rollback();
      throw error;
    }
  }

  async switchTraffic(targetColor) {
    // Update service selector
    await this.kubectl.patch('service', 'app-service', {
      spec: {
        selector: {
          app: 'myapp',
          version: targetColor
        }
      }
    });

    // Verify traffic switch
    await this.verifyTrafficSwitch(targetColor);
  }

  async rollback() {
    const currentActive = await this.getCurrentActiveVersion();
    const previousColor = currentActive === 'blue' ? 'green' : 'blue';
    
    console.log(`Rolling back to ${previousColor}`);
    await this.switchTraffic(previousColor);
  }
}
```

#### Canary Deployment
```javascript
// Canary deployment with progressive rollout
class CanaryDeployment {
  constructor(config) {
    this.stages = config.stages || [
      { percentage: 5, duration: 300 },    // 5% for 5 minutes
      { percentage: 25, duration: 600 },   // 25% for 10 minutes
      { percentage: 50, duration: 900 },   // 50% for 15 minutes
      { percentage: 100, duration: 0 }     // 100% (complete)
    ];
  }

  async deploy(newVersion) {
    const deployment = {
      version: newVersion,
      startTime: new Date(),
      currentStage: 0
    };

    try {
      // Deploy canary version
      await this.deployCanary(newVersion);

      // Progressive rollout
      for (const stage of this.stages) {
        console.log(`Canary stage: ${stage.percentage}% traffic`);
        
        // Update traffic split
        await this.updateTrafficSplit(stage.percentage);

        // Monitor metrics
        const metrics = await this.monitorCanary(stage.duration);

        // Check success criteria
        if (!this.meetsSuccessCriteria(metrics)) {
          throw new Error('Canary failed success criteria');
        }

        deployment.currentStage++;
      }

      // Finalize deployment
      await this.finalizeCanaryDeployment(newVersion);
      
    } catch (error) {
      console.error('Canary deployment failed:', error);
      await this.abortCanary();
      throw error;
    }
  }

  async updateTrafficSplit(percentage) {
    // Using Istio for traffic management
    const virtualService = {
      apiVersion: 'networking.istio.io/v1beta1',
      kind: 'VirtualService',
      metadata: {
        name: 'app-routing'
      },
      spec: {
        http: [{
          match: [{ uri: { prefix: '/' } }],
          route: [
            {
              destination: {
                host: 'app-service',
                subset: 'stable'
              },
              weight: 100 - percentage
            },
            {
              destination: {
                host: 'app-service',
                subset: 'canary'
              },
              weight: percentage
            }
          ]
        }]
      }
    };

    await this.kubectl.apply(virtualService);
  }

  meetsSuccessCriteria(metrics) {
    // Define success criteria
    const criteria = {
      errorRate: metrics.errorRate < 0.01,        // < 1% errors
      latencyP99: metrics.latencyP99 < 500,       // < 500ms P99
      cpuUsage: metrics.cpuUsage < 80,            // < 80% CPU
      memoryUsage: metrics.memoryUsage < 85       // < 85% memory
    };

    return Object.values(criteria).every(criterion => criterion);
  }

  async monitorCanary(durationSeconds) {
    const endTime = Date.now() + (durationSeconds * 1000);
    const metrics = {
      errorRate: 0,
      latencyP99: 0,
      cpuUsage: 0,
      memoryUsage: 0
    };

    while (Date.now() < endTime) {
      // Collect metrics from Prometheus
      const currentMetrics = await this.prometheus.query({
        errorRate: 'rate(http_requests_total{status=~"5.."}[1m])',
        latencyP99: 'histogram_quantile(0.99, http_request_duration_seconds)',
        cpuUsage: 'avg(container_cpu_usage_seconds_total)',
        memoryUsage: 'avg(container_memory_usage_bytes)'
      });

      // Update rolling averages
      Object.keys(metrics).forEach(key => {
        metrics[key] = (metrics[key] + currentMetrics[key]) / 2;
      });

      // Check for anomalies
      if (this.detectAnomaly(currentMetrics)) {
        throw new Error('Anomaly detected during canary deployment');
      }

      await new Promise(resolve => setTimeout(resolve, 10000)); // Check every 10s
    }

    return metrics;
  }
}
```

### 2. Infrastructure as Code

#### Terraform Infrastructure
```hcl
# infrastructure/main.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  
  backend "s3" {
    bucket = "terraform-state-bucket"
    key    = "production/terraform.tfstate"
    region = "us-west-2"
    encrypt = true
    dynamodb_table = "terraform-locks"
  }
}

# VPC and Networking
module "vpc" {
  source = "./modules/vpc"
  
  cidr_block = var.vpc_cidr
  availability_zones = var.availability_zones
  
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# EKS Cluster
module "eks" {
  source = "./modules/eks"
  
  cluster_name = "${var.project_name}-${var.environment}"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  
  node_groups = {
    general = {
      instance_types = ["t3.medium"]
      min_size       = 2
      max_size       = 10
      desired_size   = 3
    }
    
    compute = {
      instance_types = ["c5.xlarge"]
      min_size       = 0
      max_size       = 20
      desired_size   = 2
      
      taints = [{
        key    = "workload"
        value  = "compute"
        effect = "NoSchedule"
      }]
    }
  }
}

# RDS Database
module "database" {
  source = "./modules/rds"
  
  identifier     = "${var.project_name}-${var.environment}-db"
  engine         = "postgres"
  engine_version = "14.7"
  instance_class = var.db_instance_class
  
  allocated_storage     = 100
  max_allocated_storage = 1000
  
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.database_subnet_ids
  security_group_ids = [module.vpc.database_security_group_id]
  
  backup_retention_period = 30
  backup_window          = "03:00-04:00"
  maintenance_window     = "sun:04:00-sun:05:00"
  
  enabled_cloudwatch_logs_exports = ["postgresql"]
}

# Application Load Balancer
module "alb" {
  source = "./modules/alb"
  
  name            = "${var.project_name}-${var.environment}-alb"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  certificate_arn = var.ssl_certificate_arn
  
  health_check = {
    enabled             = true
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}
```

```javascript
// Infrastructure deployment automation
class InfrastructureDeployment {
  constructor(config) {
    this.terraform = new TerraformWrapper(config.terraformPath);
    this.ansible = new AnsibleWrapper(config.ansiblePath);
  }

  async deployInfrastructure(environment) {
    try {
      // 1. Validate configuration
      await this.validateConfiguration(environment);

      // 2. Plan infrastructure changes
      const plan = await this.terraform.plan({
        varFile: `environments/${environment}.tfvars`,
        out: 'tfplan'
      });

      // 3. Review and approve changes
      if (!await this.reviewPlan(plan)) {
        throw new Error('Infrastructure plan rejected');
      }

      // 4. Apply infrastructure changes
      await this.terraform.apply({
        planFile: 'tfplan',
        autoApprove: true
      });

      // 5. Get infrastructure outputs
      const outputs = await this.terraform.output();

      // 6. Configure deployed infrastructure
      await this.configureInfrastructure(outputs);

      // 7. Run smoke tests
      await this.runInfrastructureTests(outputs);

      return outputs;
    } catch (error) {
      console.error('Infrastructure deployment failed:', error);
      await this.rollbackInfrastructure();
      throw error;
    }
  }

  async configureInfrastructure(outputs) {
    // Generate Ansible inventory from Terraform outputs
    const inventory = this.generateAnsibleInventory(outputs);

    // Run Ansible playbooks
    await this.ansible.runPlaybook({
      playbook: 'site.yml',
      inventory: inventory,
      extraVars: {
        environment: this.environment,
        ...outputs
      }
    });
  }

  async validateConfiguration(environment) {
    // Terraform validation
    await this.terraform.validate();

    // Check for required variables
    const requiredVars = ['vpc_cidr', 'availability_zones', 'db_password'];
    const tfvars = await this.loadTfvars(environment);
    
    for (const varName of requiredVars) {
      if (!tfvars[varName]) {
        throw new Error(`Missing required variable: ${varName}`);
      }
    }

    // Validate against policies
    await this.validateAgainstPolicies(tfvars);
  }
}
```

### 3. Container Orchestration

#### Kubernetes Deployment Pipeline
```javascript
// Kubernetes deployment manager
class KubernetesDeployment {
  constructor(config) {
    this.namespace = config.namespace;
    this.kubectl = new KubernetesClient(config);
    this.helm = new HelmClient(config);
  }

  async deployApplication(app, version) {
    const deployment = {
      app,
      version,
      namespace: this.namespace,
      startTime: new Date()
    };

    try {
      // 1. Build and push container image
      const image = await this.buildAndPushImage(app, version);

      // 2. Update Helm values
      const values = await this.prepareHelmValues(app, version, image);

      // 3. Deploy using Helm
      await this.helm.upgrade({
        release: app,
        chart: `./charts/${app}`,
        values: values,
        namespace: this.namespace,
        wait: true,
        timeout: '10m'
      });

      // 4. Wait for rollout to complete
      await this.waitForRollout(app);

      // 5. Run post-deployment tests
      await this.runPostDeploymentTests(app, version);

      // 6. Update deployment record
      await this.recordDeployment(deployment);

      return deployment;
    } catch (error) {
      console.error('Kubernetes deployment failed:', error);
      await this.rollbackDeployment(app);
      throw error;
    }
  }

  async buildAndPushImage(app, version) {
    const dockerfile = `./apps/${app}/Dockerfile`;
    const image = `${this.config.registry}/${app}:${version}`;

    // Multi-stage Docker build
    const buildArgs = {
      APP_VERSION: version,
      BUILD_DATE: new Date().toISOString(),
      VCS_REF: await this.getGitCommit()
    };

    await this.docker.build({
      dockerfile,
      tag: image,
      buildArgs,
      cache: true,
      target: 'production'
    });

    // Security scan
    await this.scanImage(image);

    // Push to registry
    await this.docker.push(image);

    return image;
  }

  async prepareHelmValues(app, version, image) {
    const baseValues = await this.loadHelmValues(app);
    
    return {
      ...baseValues,
      image: {
        repository: image.split(':')[0],
        tag: version,
        pullPolicy: 'IfNotPresent'
      },
      replicaCount: this.calculateReplicas(app),
      resources: this.getResourceLimits(app),
      autoscaling: {
        enabled: true,
        minReplicas: 2,
        maxReplicas: 10,
        targetCPUUtilizationPercentage: 70
      },
      ingress: {
        enabled: true,
        className: 'nginx',
        annotations: {
          'cert-manager.io/cluster-issuer': 'letsencrypt-prod',
          'nginx.ingress.kubernetes.io/rate-limit': '100'
        },
        hosts: this.getIngressHosts(app)
      }
    };
  }

  async waitForRollout(app) {
    const maxWaitTime = 600; // 10 minutes
    const startTime = Date.now();

    while (Date.now() - startTime < maxWaitTime * 1000) {
      const status = await this.kubectl.rolloutStatus(
        'deployment',
        app,
        this.namespace
      );

      if (status.ready) {
        console.log(`Rollout completed for ${app}`);
        return;
      }

      // Check for failed pods
      const pods = await this.kubectl.getPods({
        labelSelector: `app=${app}`,
        namespace: this.namespace
      });

      const failedPods = pods.filter(pod => 
        pod.status.phase === 'Failed' ||
        pod.status.containerStatuses?.some(c => c.state.waiting?.reason === 'CrashLoopBackOff')
      );

      if (failedPods.length > 0) {
        throw new Error(`Deployment failed: ${failedPods.length} pods in failed state`);
      }

      await new Promise(resolve => setTimeout(resolve, 5000));
    }

    throw new Error('Rollout timeout exceeded');
  }
}
```

### 4. CI/CD Pipeline

#### GitOps Pipeline
```yaml
# .github/workflows/deploy.yml
name: Deploy to Production

on:
  push:
    branches: [main]
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment to deploy to'
        required: true
        default: 'staging'
        type: choice
        options:
          - staging
          - production

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: |
          npm run test:unit
          npm run test:integration
      
      - name: Run security scan
        run: npm audit --production

  build:
    needs: test
    runs-on: ubuntu-latest
    outputs:
      image: ${{ steps.image.outputs.image }}
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      
      - name: Log in to Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ vars.REGISTRY }}
          username: ${{ secrets.REGISTRY_USERNAME }}
          password: ${{ secrets.REGISTRY_PASSWORD }}
      
      - name: Build and push
        id: docker_build
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: |
            ${{ vars.REGISTRY }}/app:${{ github.sha }}
            ${{ vars.REGISTRY }}/app:latest
          cache-from: type=registry,ref=${{ vars.REGISTRY }}/app:buildcache
          cache-to: type=registry,ref=${{ vars.REGISTRY }}/app:buildcache,mode=max
      
      - name: Image output
        id: image
        run: echo "image=${{ vars.REGISTRY }}/app:${{ github.sha }}" >> $GITHUB_OUTPUT

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment: ${{ github.event.inputs.environment || 'staging' }}
    steps:
      - uses: actions/checkout@v3
      
      - name: Deploy to Kubernetes
        env:
          KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
          IMAGE: ${{ needs.build.outputs.image }}
        run: |
          echo "$KUBE_CONFIG" | base64 -d > kubeconfig
          export KUBECONFIG=kubeconfig
          
          # Update deployment
          kubectl set image deployment/app app=$IMAGE -n ${{ vars.NAMESPACE }}
          
          # Wait for rollout
          kubectl rollout status deployment/app -n ${{ vars.NAMESPACE }}
          
          # Run smoke tests
          ./scripts/smoke-tests.sh ${{ vars.APP_URL }}
```

```javascript
// Advanced CI/CD orchestrator
class CICDPipeline {
  constructor(config) {
    this.stages = config.stages || [
      'checkout',
      'test',
      'build',
      'security-scan',
      'deploy-staging',
      'integration-tests',
      'deploy-production'
    ];
    this.config = config;
  }

  async executePipeline(trigger) {
    const execution = {
      id: crypto.randomUUID(),
      trigger,
      startTime: new Date(),
      stages: []
    };

    try {
      for (const stageName of this.stages) {
        const stage = {
          name: stageName,
          startTime: new Date(),
          status: 'running'
        };

        execution.stages.push(stage);

        try {
          // Execute stage
          const result = await this.executeStage(stageName, execution);
          
          stage.result = result;
          stage.status = 'success';
          stage.endTime = new Date();

          // Check if we should continue
          if (!this.shouldContinue(stageName, result)) {
            break;
          }
        } catch (error) {
          stage.status = 'failed';
          stage.error = error.message;
          stage.endTime = new Date();
          
          // Handle stage failure
          await this.handleStageFailure(stageName, error, execution);
          throw error;
        }
      }

      execution.status = 'success';
      execution.endTime = new Date();
      
      // Notify success
      await this.notifyPipelineComplete(execution);
      
    } catch (error) {
      execution.status = 'failed';
      execution.endTime = new Date();
      execution.error = error.message;
      
      // Notify failure
      await this.notifyPipelineFailure(execution);
      throw error;
    }

    return execution;
  }

  async executeStage(stageName, execution) {
    switch (stageName) {
      case 'checkout':
        return await this.checkoutCode();
      
      case 'test':
        return await this.runTests();
      
      case 'build':
        return await this.buildArtifacts();
      
      case 'security-scan':
        return await this.runSecurityScans();
      
      case 'deploy-staging':
        return await this.deployToEnvironment('staging');
      
      case 'integration-tests':
        return await this.runIntegrationTests('staging');
      
      case 'deploy-production':
        return await this.deployToProduction();
      
      default:
        throw new Error(`Unknown stage: ${stageName}`);
    }
  }

  async deployToProduction() {
    // Blue-green deployment to production
    const deployment = new BlueGreenDeployment(this.config.production);
    
    // Get approval if needed
    if (this.config.requireApproval) {
      const approved = await this.requestApproval({
        environment: 'production',
        changes: await this.getChanges()
      });
      
      if (!approved) {
        throw new Error('Production deployment not approved');
      }
    }
    
    // Deploy with monitoring
    const result = await deployment.deploy(this.version);
    
    // Monitor for issues
    await this.monitorProduction(30 * 60); // 30 minutes
    
    return result;
  }

  async runSecurityScans() {
    const scanners = [
      this.runDependencyCheck(),
      this.runSAST(),
      this.runContainerScan(),
      this.runLicenseCheck()
    ];

    const results = await Promise.all(scanners);
    
    // Check for critical vulnerabilities
    const criticalIssues = results
      .flatMap(r => r.vulnerabilities || [])
      .filter(v => v.severity === 'CRITICAL');
    
    if (criticalIssues.length > 0) {
      throw new Error(`Found ${criticalIssues.length} critical security issues`);
    }
    
    return results;
  }
}
```

### 5. Configuration Management

#### Secrets Management
```javascript
// Secure secrets management
class SecretsManager {
  constructor(provider) {
    this.provider = provider; // AWS Secrets Manager, HashiCorp Vault, etc.
  }

  async deploySecrets(environment) {
    const secrets = await this.loadSecretDefinitions(environment);
    
    for (const secret of secrets) {
      // Rotate if needed
      if (await this.shouldRotate(secret)) {
        await this.rotateSecret(secret);
      }
      
      // Deploy to Kubernetes
      await this.deployToKubernetes(secret, environment);
    }
  }

  async deployToKubernetes(secret, environment) {
    const k8sSecret = {
      apiVersion: 'v1',
      kind: 'Secret',
      metadata: {
        name: secret.name,
        namespace: environment
      },
      type: 'Opaque',
      data: {}
    };

    // Fetch secret value from provider
    const secretValue = await this.provider.getSecret(secret.path);
    
    // Encode secret data
    for (const [key, value] of Object.entries(secretValue)) {
      k8sSecret.data[key] = Buffer.from(value).toString('base64');
    }
    
    // Apply to cluster
    await this.kubectl.apply(k8sSecret);
  }

  async rotateSecret(secret) {
    // Generate new secret value
    const newValue = await this.generateSecretValue(secret.type);
    
    // Update in provider
    await this.provider.updateSecret(secret.path, newValue);
    
    // Update applications using this secret
    await this.updateApplications(secret);
    
    // Log rotation
    await this.auditLog.record({
      action: 'secret_rotated',
      secret: secret.name,
      timestamp: new Date()
    });
  }
}

// Environment configuration
class ConfigurationManager {
  constructor() {
    this.configs = new Map();
  }

  async loadConfiguration(environment) {
    // Base configuration
    const baseConfig = await this.loadFile('config/base.yaml');
    
    // Environment-specific overrides
    const envConfig = await this.loadFile(`config/${environment}.yaml`);
    
    // Merge configurations
    const config = this.mergeConfigs(baseConfig, envConfig);
    
    // Validate configuration
    await this.validateConfig(config, environment);
    
    // Interpolate variables
    const interpolated = await this.interpolateVariables(config, environment);
    
    return interpolated;
  }

  async deployConfiguration(environment) {
    const config = await this.loadConfiguration(environment);
    
    // Create ConfigMaps
    for (const [name, data] of Object.entries(config.configMaps || {})) {
      await this.kubectl.apply({
        apiVersion: 'v1',
        kind: 'ConfigMap',
        metadata: {
          name,
          namespace: environment
        },
        data
      });
    }
    
    // Update application deployments
    await this.updateDeployments(config, environment);
  }
}
```

### 6. Monitoring and Observability

#### Deployment Monitoring
```javascript
// Comprehensive deployment monitoring
class DeploymentMonitor {
  constructor(config) {
    this.prometheus = new PrometheusClient(config.prometheus);
    this.grafana = new GrafanaClient(config.grafana);
    this.alertManager = new AlertManagerClient(config.alertManager);
  }

  async setupDeploymentMonitoring(deployment) {
    // Create deployment-specific dashboard
    const dashboard = await this.createDeploymentDashboard(deployment);
    
    // Set up alerts
    await this.configureAlerts(deployment);
    
    // Start monitoring
    const monitor = this.startContinuousMonitoring(deployment);
    
    return {
      dashboardUrl: dashboard.url,
      monitor
    };
  }

  async createDeploymentDashboard(deployment) {
    const dashboard = {
      title: `Deployment: ${deployment.app} v${deployment.version}`,
      panels: [
        this.createRequestRatePanel(),
        this.createErrorRatePanel(),
        this.createLatencyPanel(),
        this.createResourceUsagePanel(),
        this.createPodStatusPanel(),
        this.createLogPanel()
      ],
      annotations: [
        {
          datasource: 'prometheus',
          enable: true,
          expr: `deployment_version{app="${deployment.app}"}`,
          tagKeys: 'version',
          titleFormat: 'Deployment'
        }
      ]
    };

    return await this.grafana.createDashboard(dashboard);
  }

  async configureAlerts(deployment) {
    const alerts = [
      {
        name: `${deployment.app}_high_error_rate`,
        expr: `rate(http_requests_total{app="${deployment.app}",status=~"5.."}[5m]) > 0.05`,
        duration: '5m',
        severity: 'critical',
        annotations: {
          summary: 'High error rate detected',
          description: `Error rate is above 5% for ${deployment.app}`
        }
      },
      {
        name: `${deployment.app}_high_latency`,
        expr: `histogram_quantile(0.95, http_request_duration_seconds{app="${deployment.app}"}) > 1`,
        duration: '5m',
        severity: 'warning',
        annotations: {
          summary: 'High latency detected',
          description: `95th percentile latency is above 1s for ${deployment.app}`
        }
      },
      {
        name: `${deployment.app}_pod_restart`,
        expr: `increase(kube_pod_container_status_restarts_total{pod=~"${deployment.app}-.*"}[1h]) > 5`,
        duration: '0s',
        severity: 'warning',
        annotations: {
          summary: 'Pod restarting frequently',
          description: `Pod {{$labels.pod}} has restarted more than 5 times in the last hour`
        }
      }
    ];

    for (const alert of alerts) {
      await this.prometheus.createAlert(alert);
    }
  }

  startContinuousMonitoring(deployment) {
    const interval = setInterval(async () => {
      try {
        const metrics = await this.collectMetrics(deployment);
        
        // Check deployment health
        const health = this.assessHealth(metrics);
        
        if (health.status === 'unhealthy') {
          await this.handleUnhealthyDeployment(deployment, health);
        }
        
        // Store metrics for historical analysis
        await this.storeMetrics(deployment, metrics);
        
      } catch (error) {
        console.error('Monitoring error:', error);
      }
    }, 30000); // Every 30 seconds

    return {
      stop: () => clearInterval(interval)
    };
  }

  assessHealth(metrics) {
    const checks = {
      errorRate: metrics.errorRate < 0.01,
      latency: metrics.p95Latency < 500,
      availability: metrics.availability > 0.99,
      podHealth: metrics.healthyPods / metrics.totalPods > 0.8
    };

    const failedChecks = Object.entries(checks)
      .filter(([_, passed]) => !passed)
      .map(([check]) => check);

    return {
      status: failedChecks.length === 0 ? 'healthy' : 'unhealthy',
      failedChecks,
      metrics
    };
  }
}
```

### 7. Rollback Strategies

#### Automated Rollback
```javascript
// Intelligent rollback system
class RollbackManager {
  constructor(config) {
    this.config = config;
    this.deploymentHistory = new DeploymentHistory();
  }

  async rollback(deployment, reason) {
    console.log(`Initiating rollback for ${deployment.app}: ${reason}`);

    try {
      // 1. Find previous stable version
      const targetVersion = await this.findRollbackTarget(deployment);

      if (!targetVersion) {
        throw new Error('No stable version found for rollback');
      }

      // 2. Create rollback plan
      const plan = await this.createRollbackPlan(deployment, targetVersion);

      // 3. Execute rollback
      await this.executeRollback(plan);

      // 4. Verify rollback success
      await this.verifyRollback(plan);

      // 5. Notify stakeholders
      await this.notifyRollback(deployment, targetVersion, reason);

      // 6. Create incident report
      await this.createIncidentReport(deployment, reason);

      return {
        success: true,
        targetVersion,
        duration: Date.now() - plan.startTime
      };

    } catch (error) {
      console.error('Rollback failed:', error);
      await this.handleRollbackFailure(deployment, error);
      throw error;
    }
  }

  async findRollbackTarget(deployment) {
    // Get deployment history
    const history = await this.deploymentHistory.getHistory(deployment.app);

    // Find last stable version
    for (const version of history.reverse()) {
      if (version.id === deployment.id) continue;

      const stability = await this.assessVersionStability(version);
      if (stability.isStable) {
        return version;
      }
    }

    return null;
  }

  async createRollbackPlan(currentDeployment, targetVersion) {
    return {
      app: currentDeployment.app,
      currentVersion: currentDeployment.version,
      targetVersion: targetVersion.version,
      strategy: this.determineRollbackStrategy(currentDeployment),
      steps: [
        { name: 'backup-current-state', critical: true },
        { name: 'prepare-target-version', critical: true },
        { name: 'switch-traffic', critical: true },
        { name: 'verify-functionality', critical: true },
        { name: 'cleanup-failed-version', critical: false }
      ],
      startTime: Date.now()
    };
  }

  async executeRollback(plan) {
    for (const step of plan.steps) {
      try {
        console.log(`Executing rollback step: ${step.name}`);
        
        switch (step.name) {
          case 'backup-current-state':
            await this.backupCurrentState(plan);
            break;
          
          case 'prepare-target-version':
            await this.prepareTargetVersion(plan);
            break;
          
          case 'switch-traffic':
            await this.switchTraffic(plan);
            break;
          
          case 'verify-functionality':
            await this.verifyFunctionality(plan);
            break;
          
          case 'cleanup-failed-version':
            await this.cleanupFailedVersion(plan);
            break;
        }
        
        step.status = 'completed';
        step.completedAt = new Date();
        
      } catch (error) {
        step.status = 'failed';
        step.error = error.message;
        
        if (step.critical) {
          throw new Error(`Critical rollback step failed: ${step.name}`);
        }
      }
    }
  }

  determineRollbackStrategy(deployment) {
    // Choose strategy based on deployment type and criticality
    if (deployment.type === 'blue-green') {
      return 'instant-switch';
    } else if (deployment.type === 'canary') {
      return 'gradual-rollback';
    } else {
      return 'rolling-update';
    }
  }
}
```

## Code Examples

### Complete Deployment System

```javascript
// Unified deployment orchestrator
class DeploymentOrchestrator {
  constructor(config) {
    this.config = config;
    this.pipeline = new CICDPipeline(config);
    this.infrastructure = new InfrastructureDeployment(config);
    this.kubernetes = new KubernetesDeployment(config);
    this.monitor = new DeploymentMonitor(config);
    this.rollback = new RollbackManager(config);
  }

  async deployApplication(request) {
    const deployment = {
      id: crypto.randomUUID(),
      app: request.app,
      version: request.version,
      environment: request.environment,
      strategy: request.strategy || 'blue-green',
      startTime: new Date(),
      status: 'in-progress'
    };

    try {
      // Pre-deployment checks
      await this.runPreDeploymentChecks(deployment);

      // Deploy infrastructure changes if needed
      if (request.infrastructureChanges) {
        await this.deployInfrastructure(deployment);
      }

      // Deploy application
      const result = await this.deployApp(deployment);

      // Set up monitoring
      const monitoring = await this.monitor.setupDeploymentMonitoring(deployment);

      // Run post-deployment validation
      await this.validateDeployment(deployment);

      deployment.status = 'success';
      deployment.endTime = new Date();
      deployment.result = result;
      deployment.monitoring = monitoring;

      // Record successful deployment
      await this.recordDeployment(deployment);

      return deployment;

    } catch (error) {
      deployment.status = 'failed';
      deployment.error = error.message;
      deployment.endTime = new Date();

      // Attempt automatic rollback
      if (this.config.autoRollback) {
        try {
          await this.rollback.rollback(deployment, error.message);
          deployment.rollbackStatus = 'success';
        } catch (rollbackError) {
          deployment.rollbackStatus = 'failed';
          deployment.rollbackError = rollbackError.message;
        }
      }

      // Record failed deployment
      await this.recordDeployment(deployment);

      throw error;
    }
  }

  async runPreDeploymentChecks(deployment) {
    const checks = [
      this.checkDependencies(deployment),
      this.checkResourceAvailability(deployment),
      this.checkSecurityCompliance(deployment),
      this.checkDeploymentWindow(deployment)
    ];

    const results = await Promise.all(checks);
    const failures = results.filter(r => !r.passed);

    if (failures.length > 0) {
      throw new Error(`Pre-deployment checks failed: ${failures.map(f => f.reason).join(', ')}`);
    }
  }

  async deployApp(deployment) {
    switch (deployment.strategy) {
      case 'blue-green':
        return await this.deployBlueGreen(deployment);
      
      case 'canary':
        return await this.deployCanary(deployment);
      
      case 'rolling':
        return await this.deployRolling(deployment);
      
      default:
        throw new Error(`Unknown deployment strategy: ${deployment.strategy}`);
    }
  }

  async validateDeployment(deployment) {
    // Health checks
    await this.waitForHealthy(deployment);

    // Smoke tests
    await this.runSmokeTests(deployment);

    // Performance validation
    await this.validatePerformance(deployment);

    // Security validation
    await this.validateSecurity(deployment);
  }

  async waitForHealthy(deployment, timeout = 300) {
    const startTime = Date.now();
    
    while (Date.now() - startTime < timeout * 1000) {
      const health = await this.checkHealth(deployment);
      
      if (health.status === 'healthy') {
        return health;
      }
      
      await new Promise(resolve => setTimeout(resolve, 5000));
    }
    
    throw new Error('Deployment did not become healthy within timeout');
  }
}

// Example usage
const orchestrator = new DeploymentOrchestrator({
  environment: 'production',
  autoRollback: true,
  monitoring: {
    prometheus: { url: 'http://prometheus:9090' },
    grafana: { url: 'http://grafana:3000' },
    alertManager: { url: 'http://alertmanager:9093' }
  }
});

// Deploy application
await orchestrator.deployApplication({
  app: 'api-service',
  version: 'v2.1.0',
  environment: 'production',
  strategy: 'canary',
  infrastructureChanges: false
});
```

## Benefits & Trade-offs

### Benefits
- **Reliability**: Automated deployments reduce human error
- **Speed**: Fast, consistent deployments enable rapid iteration
- **Rollback Capability**: Quick recovery from failed deployments
- **Scalability**: Handle deployments across multiple environments
- **Visibility**: Complete deployment tracking and monitoring
- **Compliance**: Audit trails and approval workflows

### Trade-offs
- **Complexity**: Deployment systems require significant setup
- **Infrastructure Cost**: Additional tooling and resources needed
- **Learning Curve**: Teams need training on deployment tools
- **Maintenance**: Deployment pipelines require ongoing updates
- **Debugging**: Complex pipelines can be hard to troubleshoot
- **Lock-in**: Tool-specific configurations may create vendor lock-in

## Common Pitfalls

1. **Missing Rollback Plan**: Not preparing for deployment failures
2. **Insufficient Testing**: Deploying without adequate validation
3. **Poor Secret Management**: Hardcoding or exposing secrets
4. **No Monitoring**: Deploying without observability
5. **Manual Processes**: Relying on error-prone manual steps
6. **Configuration Drift**: Environments becoming inconsistent
7. **Inadequate Documentation**: Missing deployment procedures

## Integration with AugmentedClaude Specialists

### DevOps Engineer
- Designs and implements deployment pipelines
- Manages infrastructure as code
- Monitors deployment health

### Site Reliability Engineer
- Ensures deployment reliability and performance
- Implements monitoring and alerting
- Manages incident response

### Security Engineer
- Implements security scanning in pipelines
- Manages secrets and certificates
- Ensures compliance requirements

### Release Manager
- Coordinates deployment schedules
- Manages deployment approvals
- Tracks deployment metrics

## Related Patterns

- **GitOps**: Git as single source of truth
- **Progressive Delivery**: Gradual feature rollouts
- **Chaos Engineering**: Testing system resilience
- **Service Mesh**: Advanced traffic management
- **Feature Flags**: Runtime feature control
- **Database Migrations**: Schema version management

## Best Practices

1. **Deployment Pipeline**
   ```yaml
   stages:
     - name: build
       steps:
         - test
         - security-scan
         - build-image
         - push-image
     
     - name: staging
       steps:
         - deploy
         - smoke-test
         - integration-test
     
     - name: production
       steps:
         - approval
         - canary-deploy
         - monitor
         - full-deploy
   ```

2. **Environment Parity**
   - Keep environments as similar as possible
   - Use same deployment tools across environments
   - Automate environment provisioning

3. **Deployment Checklist**
   - Pre-deployment health check
   - Database migration status
   - Feature flag configuration
   - Monitoring dashboard ready
   - Rollback plan documented
   - Stakeholders notified

4. **Post-Deployment**
   - Monitor key metrics for anomalies
   - Keep deployment window open
   - Document any issues encountered
   - Update runbooks if needed

5. **Continuous Improvement**
   - Regular deployment retrospectives
   - Automate manual processes
   - Measure deployment metrics
   - Optimize pipeline performance

These patterns enable reliable, efficient, and safe software deployment at scale while maintaining system stability and team productivity.