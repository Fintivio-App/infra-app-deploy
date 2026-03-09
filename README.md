# Infra App Deploy

Dockerfiles and Helm charts for deploying all Fintivio microservices to Kubernetes (AKS). Organized by service type: frontend, Node.js backend, and Java backend.

## Directory Structure

```
infra-app-deploy/
├── frontend/
│   ├── Dockerfile          # Multi-stage: Node 22 Alpine → nginx Alpine
│   └── k8s/                # Helm chart "generic-app"
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
├── nodejs/
│   ├── .dockerignore
│   ├── Dockerfile          # Node 22 Alpine (single-stage)
│   └── k8s/                # Helm chart "generic-backend"
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
└── java/
    ├── Dockerfile          # Multi-stage: Gradle 8.11 + JDK 21 → Temurin JRE 21 Alpine
    └── k8s/                # Helm chart "generic-backend"
        ├── Chart.yaml
        ├── values.yaml
        └── templates/
```

## Dockerfiles

### Frontend
- **Build**: Node 22 Alpine with Corepack + TypeScript 5.9.3, runs `yarn build`
- **Runtime**: nginx Alpine serving static files on port 80
- **Build args**: `VITE_REMOTES_ORIGIN`, `VITE_HOST_ORIGIN`, `NODE_ENV`

### Node.js
- **Image**: Node 22 Alpine
- **Build**: `npm install` → `npm run build` → `npm run start`
- **SSH**: Copies `.rsa` key for private dependency access

### Java
- **Build**: Gradle 8.11 + JDK 21, runs `./gradlew clean build -x test`
- **Runtime**: Eclipse Temurin JRE 21 Alpine, non-root user (`spring:spring`)
- **Health**: `/actuator/health` every 30s
- **JVM**: Container-aware memory (75% max RAM), string optimization

## Helm Charts

All charts share the same pattern. Frontend uses `generic-app`, backends use `generic-backend`.

### Default Resource Limits

| Resource | Request | Limit |
|----------|---------|-------|
| CPU | 100m | 500m |
| Memory | 128Mi | 512Mi |

### Autoscaling (HPA)
- Disabled by default
- Min replicas: 1, Max: 3
- CPU target: 70% utilization
- Memory target: configurable

### Services
All Kubernetes Services use `ClusterIP` type:
- Frontend: port 80
- Backends: port 8080

### Secret Management (backends only)
- `secretEnv.enabled: true` creates a Kubernetes Secret
- Injected as environment variables via `envFrom`
- Used for DB credentials, API keys, Keycloak secrets

### Image Pull
- Frontend: no imagePullSecrets (public images)
- Backends: require `dockerhub` secret pre-created in cluster

## Services Deployed

### Frontend (12 UIs) — uses `frontend/`
main-ui (host), accounts-ui, calendar-ui, dashboard-ui, entity-management-ui, family-management-ui, lifestyle-assets-ui, private-investments-ui, provider-management-ui, public-markets-ui, reports-ui, user-management-ui

### Node.js Backends (11) — uses `nodejs/`
asset-management, calendar, client-management, dashboard, document, email, entity-management, family-management, lifestyle-assets, notifications, private-investments, user-management

### Java Backends (7) — uses `java/`
accounts, brokerage-sync, holding-snapshot-job, provider-management, public-markets, report-parser, reports

## Deployment Flow

1. GitHub Actions builds Docker image from the appropriate Dockerfile
2. Image pushed to Docker Hub
3. Helm chart deployed with environment-specific values override
4. Ingress routing managed separately in `infra-service` repo
