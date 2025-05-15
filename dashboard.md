
# ðŸ“˜ Kubernetes Dashboard Deployment Guide

This guide walks you through the steps to deploy the **Kubernetes Dashboard**, create a service account for secure access, and generate a token to log in.

---

## ðŸš€ Step-by-Step Instructions

### ðŸ”¹ 1. Install Kubernetes Dashboard

Run the official installation command:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
```

---

### ðŸ”¹ 2. Create a Service Account

Create a service account YAML file:

ðŸ“„ `dashboard-user.yaml`
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

### ðŸ”¹ 3. Create a ClusterRoleBinding

ðŸ“„ `dashboard-clusterrolebinding.yaml`
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

### ðŸ”¹ 4. Generate Login Token

Generate the access token for the dashboard:

```bash
kubectl -n kubernetes-dashboard create token dashboard-user
```

Copy this token. You will need it to log in.

---

### ðŸ”¹ 5. Access the Dashboard

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

### âœ… Optional: Read-Only Access

If you want to create a read-only user, modify the service account and role binding accordingly using `view` instead of `cluster-admin`.

---

## ðŸ§¼ Cleanup

To remove the Dashboard and associated accounts:

```bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete serviceaccount dashboard-user -n kubernetes-dashboard
kubectl delete clusterrolebinding dashboard-user
```

---

## ðŸ›¡ï¸ Security Note

Never use `cluster-admin` in production unless necessary. Create scoped `Role` or `ClusterRole` objects for fine-grained access control.