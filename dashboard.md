
# Kubernetes Dashboard Deployment Guide

This guide walks you through the steps to deploy the **Kubernetes Dashboard**, create a service account for secure access, and generate a token to log in.

---

## Step-by-Step Instructions

### 1. Install Kubernetes Dashboard

Run the official installation command:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

---

### 2. Create a Service Account

Create a service account YAML file:

 `dashboard-user.yaml`
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: dashboard-user
  namespace: kubernetes-dashboard
```

Apply it:

```bash
kubectl apply -f dashboard-user.yaml
```

---

### 3. Create a ClusterRoleBinding

 `dashboard-clusterrolebinding.yaml`
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: dashboard-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: dashboard-user
  namespace: kubernetes-dashboard
```

Apply it:

```bash
kubectl apply -f dashboard-clusterrolebinding.yaml
```

---

### 4. Generate Login Token

Generate the access token for the dashboard:

```bash
kubectl -n kubernetes-dashboard create token dashboard-user
```

Copy this token. You will need it to log in.

---

### 5. Access the Dashboard

Start the proxy:

```bash
kubectl proxy
```

Access the Dashboard in your browser:

```
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
```

> If you're using a GitHub Codespace or remote machine, use the forwarded URL provided (e.g., `https://<your-codespace>.app.github.dev/`).

---

## 🔧 Accessing Kubernetes Dashboard in GitHub Codespaces

Accessing the Kubernetes Dashboard inside a GitHub Codespace requires a small workaround due to HTTPS enforcement and reverse proxy limitations.

---

### ✅ Recommended Setup: Use kubectl port-forward

Instead of using kubectl proxy (which may not work reliably in Codespaces), you can forward the dashboard service directly.

### 🧪 Steps

1. Start port forwarding in your Codespace terminal:

   ```bash
   kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8443:443


### Optional: Read-Only Access

If you want to create a read-only user, modify the service account and role binding accordingly using `view` instead of `cluster-admin`.

---

## Cleanup

To remove the Dashboard and associated accounts:

```bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete serviceaccount dashboard-user -n kubernetes-dashboard
kubectl delete clusterrolebinding dashboard-user
```

---

## Security Note

Never use `cluster-admin` in production unless necessary. Create scoped `Role` or `ClusterRole` objects for fine-grained access control.
