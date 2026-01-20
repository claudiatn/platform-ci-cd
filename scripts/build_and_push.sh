#!/usr/bin/env bash
set -euo pipefail

# Variables de entrada
IMAGE_NAME="$1"
VERSION="$2"
ACTOR="$3"
GHCR_PAT="$4"

IMAGE="ghcr.io/${ACTOR}/${IMAGE_NAME}:${VERSION}"

echo "🔐 Login en GHCR"
echo "$GHCR_PAT" | docker login ghcr.io -u "$ACTOR" --password-stdin

echo "🐳 Construyendo imagen: $IMAGE"
docker build -t "$IMAGE" .

echo "📤 Publicando imagen"
docker push "$IMAGE"

echo "✅ Imagen publicada correctamente"
echo "IMAGE_TAG=$IMAGE"
