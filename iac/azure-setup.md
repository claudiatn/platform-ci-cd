# Azure Setup – AKS + ACR (Terraform)

Este documento explica cómo crear:
1. Azure Container Registry (ACR)
2. Azure Kubernetes Service (AKS)
3. La conexión entre AKS y ACR usando **Terraform**.
---

## Prerrequisitos

- Terraform >= 1.5
- Azure CLI
- Login en Azure:

    az login

- Subscription seleccionada:

    az account set --subscription <SUBSCRIPTION_ID>



---

# 2️⃣ Modificar scripts para soportar ACR (Terraform-friendly)

### Helm values (ejemplo)

```yaml
image:
  repository: "{{ acr_login_server }}/{{ image_name }}"
  tag: "{{ image_tag }}"

### Ansible (sin secrets de pull)
vars:
  acr_login_server: "{{ acr_login_server }}"


✅ No se necesita imagePullSecrets si el rol AcrPull está bien asignado.



# 3️⃣ GitHub Actions con Terraform + ACR
Secrets requeridos
Secret	Descripción
AZURE_CLIENT_ID	App Registration
AZURE_TENANT_ID	Tenant
AZURE_SUBSCRIPTION_ID	Subscription

⚠️ No guardes secrets de ACR.


