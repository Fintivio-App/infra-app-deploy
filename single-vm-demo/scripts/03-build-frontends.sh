#!/usr/bin/env bash
# 03 — Build the 13 frontend images locally from their demo-version branches.
# Frontend images bake the domain at build time, so they CANNOT be reused from
# Docker Hub (those point at *.fintivio.com). Backends, by contrast, are pulled as-is.
#
# Layout assumption: all repos are cloned (on branch demo-version) side-by-side under
# $REPO_ROOT. Defaults to the parent of infra-app-deploy.
set -euo pipefail
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a

REPO_ROOT="${REPO_ROOT:-$(cd ../.. && pwd)}"
DOCKERFILE="$(cd .. && pwd)/frontend/Dockerfile"   # infra-app-deploy/frontend/Dockerfile
TAG="${FRONTEND_IMAGE_TAG:-demo}"

UIS=(
  fintivio-main-ui fintivio-dashboard-ui fintivio-reports-ui fintivio-calendar-ui
  fintivio-accounts-ui fintivio-public-markets-ui fintivio-private-investments-ui
  fintivio-lifestyle-assets-ui fintivio-provider-management-ui fintivio-user-management-ui
  fintivio-entity-management-ui fintivio-family-management-ui fintivio-real-estate-ui
)

echo "==> REPO_ROOT=$REPO_ROOT   Dockerfile=$DOCKERFILE   tag=:$TAG"
[ -f "$DOCKERFILE" ] || { echo "!! frontend Dockerfile not found at $DOCKERFILE"; exit 1; }

for ui in "${UIS[@]}"; do
  ctx="$REPO_ROOT/$ui"
  [ -d "$ctx" ] || { echo "!! missing repo: $ctx (clone it on branch demo-version)"; exit 1; }
  br="$(git -C "$ctx" rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')"
  [ "$br" = "demo-version" ] || echo "   WARNING: $ui is on '$br', expected 'demo-version'"
  echo "==> Building $ui:$TAG (context $ctx)"
  docker build \
    -f "$DOCKERFILE" \
    --build-arg NODE_ENV=production \
    -t "$ui:$TAG" \
    "$ctx"
done
echo "==> All frontend images built:"
docker images --format '  {{.Repository}}:{{.Tag}}' | grep ":$TAG" | sort
