#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="$1"
ENVIRONMENT="$2"
ACTOR="$3"
GHCR_PAT="$4"
CHART="$5"
PATH_CHART="$6"
IMAGE_TAG="$7"

BUILD_CONTEXT="${GITHUB_WORKSPACE}"

echo "CREATE NAMESPACE"
kubectl create namespace "$NAMESPACE-$ENVIRONMENT"


echo "CREATE GHCR-SECRET"
kubectl create secret docker-registry ghcr-secret \
            --docker-server=ghcr.io \
            --docker-username=$ACTOR \
            --docker-password=$GHCR_PAT \
            --namespace="$NAMESPACE-$ENVIRONMENT"

# Si viene vacío, usar ./helm 
if [ -z "$PATH_CHART" ]; 
   then FULL_PATH="./helm" 
   else FULL_PATH="./helm/$PATH_CHART"
fi 
 
echo "HELM LINT"
helm lint "$FULL_PATH"

echo "DEPLOY HELM"
if ! helm upgrade --install "$CHART" "$FULL_PATH" \
  -f "platform-ci-cd/environments/$ENVIRONMENT/$CHART-values.yaml" \
  --set image.tag="$IMAGE_TAG" \
  --namespace "$NAMESPACE-$ENVIRONMENT"; then

  echo "❌ ERROR: El despliegue falló. Ejecutando rollback..."

  LAST_REVISION=$(helm history "$CHART" -n "$NAMESPACE-$ENVIRONMENT" | awk 'NR==2{print $1}')
  helm rollback "$CHART" "$LAST_REVISION" -n "$NAMESPACE-$ENVIRONMENT"

  exit 1
fi

echo "Comprobar despliegue"
kubectl get all -n "$NAMESPACE-$ENVIRONMENT"
