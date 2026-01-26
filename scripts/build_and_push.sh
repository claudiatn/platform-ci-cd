#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="$1"
VERSION="$2"
ACTOR="$3"
GHCR_PAT="$4"

IMAGE="ghcr.io/${ACTOR}/${IMAGE_NAME}:${VERSION}"

BUILD_CONTEXT="${GITHUB_WORKSPACE}"

echo "🔐 Login en GHCR"
echo "$GHCR_PAT" | docker login ghcr.io -u "$ACTOR" --password-stdin

echo "🐳 Construyendo imagen: $IMAGE"
docker build -t "$IMAGE" "$BUILD_CONTEXT"

echo "📤 Publicando imagen"
docker push "$IMAGE"

echo "tag=$IMAGE" >> "$GITHUB_OUTPUT"
echo "$VERSION" > artifact.txt

