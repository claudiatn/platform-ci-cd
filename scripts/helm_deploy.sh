#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="$1"
ENVIRONMENT="$2"
ACTOR="$3"
GHCR_PAT="$4"
CHART="$5"

BUILD_CONTEXT="${GITHUB_WORKSPACE}"

echo "CREATE NAMESPACE"
kubectl create namespace "$NAMESPACE-$ENVIRONMENT"


echo "CREATE GHCR-SECRET"
kubectl create secret docker-registry ghcr-secret \
            --docker-server=ghcr.io \
            --docker-username=$ACTOR \
            --docker-password=$GHCR_PAT \
            --namespace="$NAMESPACE-$ENVIRONMENT"

echo "DEPLOY HELM"

if ! helm upgrade --install "$CHART" ./helm \
  -f "platform-ci-cd/environments/$ENVIRONMENT/$CHART-values.yaml" \
  --namespace "$NAMESPACE-$ENVIRONMENT"; then

  echo "❌ ERROR: El despliegue falló. Ejecutando rollback..."

  LAST_REVISION=$(helm history "$CHART" -n "$NAMESPACE-$ENVIRONMENT" | awk 'NR==2{print $1}')
  helm rollback "$CHART" "$LAST_REVISION" -n "$NAMESPACE-$ENVIRONMENT"

  exit 1
fi


echo "Comprobar despliegue"
kubectl get all -n "$NAMESPACE-$ENVIRONMENT"
