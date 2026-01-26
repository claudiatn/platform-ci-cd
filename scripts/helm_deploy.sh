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
helm upgrade --install $CHART ./helm \
             -f "platform-ci-cd/environments/$ENVIRONMENT/$CHART-values.yaml" \
             --namespace "$NAMESPACE-$ENVIRONMENT"
                         

echo "Comprobar despliegue"
kubectl get all -n "$NAMESPACE-$ENVIRONMENT
