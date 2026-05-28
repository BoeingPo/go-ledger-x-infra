output "argocd_url" {
  description = "ArgoCD UI — port-forward to access: kubectl port-forward svc/argocd-server -n argocd 8080:443"
  value       = "https://${var.vps_ip} (after port-forward or NodePort)"
}

output "kubeconfig_note" {
  description = "How to get kubeconfig from the server"
  value       = "scp ${var.ssh_user}@${var.vps_ip}:/etc/rancher/k3s/k3s.yaml ~/.kube/config && sed -i 's/127.0.0.1/${var.vps_ip}/g' ~/.kube/config"
}
