Plataforma CI/CD central — Workflows reutilizables y automatización DevOps
📌 Descripción
Este repositorio contiene la plataforma central de CI/CD utilizada por todos los servicios del proyecto Acme Tasks.
Aquí es donde tú, como DevOps, debes implementar:

Workflows reutilizables de CI y CD

Scripts de automatización para build y deploy

Documentación interna de la plataforma

Buenas prácticas de estandarización para todos los repos

Este repo actúa como un “punto único de verdad” para la automatización del proyecto.

📁 Estructura del repositorio
Código
platform-ci-cd/
  .github/
    workflows/
      ci-reusable.yml      # lo implementas tú
      cd-reusable.yml      # lo implementas tú
  scripts/
    build_and_push.sh      # lo implementas tú
    helm_deploy.sh         # lo implementas tú
  docs/
    ci_design.md           # documentas tu diseño
    cd_design.md           # documentas tu diseño
  .gitignore
  README.md
🎯 Objetivo del repositorio
Tu misión es construir:

✔ Workflow reutilizable de CI
Debe permitir:

Construir imágenes Docker

Subirlas a un registry (local o remoto)

Devolver un image_tag como output

✔ Workflow reutilizable de CD
Debe permitir:

Desplegar servicios con Helm

Seleccionar entorno (dev, prod, etc.)

Usar kubeconfig como secret

Validar inputs

✔ Scripts de automatización
build_and_push.sh → build + push de imágenes

helm_deploy.sh → despliegue Helm estándar

🧪 Cómo probar tus workflows
Ve a frontend-app o backend-app

Ejecuta un push a main

Observa cómo llaman a tus workflows reutilizables

Comprueba que:

Se construye la imagen

Se sube al registry

Se despliega en Kubernetes

📝 Documentación interna
Debes documentar:

Inputs y outputs de cada reusable

Variables estándar

Reglas de naming

Ejemplos de uso

🧰 Requisitos previos
Docker

Kubernetes local (kind/minikube/k3d)

Helm

GitHub Actions

Registry local (localhost:5000)
