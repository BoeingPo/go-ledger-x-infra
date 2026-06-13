variable "vps_ip" {
  description = "Public IP address of the ReadyIDC VPS"
  type        = string
}

variable "ssh_user" {
  description = "SSH username (usually root or ubuntu)"
  type        = string
  default     = "root"
}

variable "ssh_private_key_path" {
  description = "Path to your SSH private key, e.g. ~/.ssh/id_rsa. Leave empty if using ssh_password instead."
  type        = string
  default     = ""
}

variable "ssh_password" {
  description = "SSH password for the VPS. Leave empty if using ssh_private_key_path instead."
  type        = string
  default     = ""
  sensitive   = true
}

variable "k3s_version" {
  description = "k3s version to install, e.g. v1.30.0+k3s1"
  type        = string
  default     = "v1.30.0+k3s1"
}

variable "argocd_gitops_repo" {
  description = "HTTPS URL of go-ledger-x-gitops repo, e.g. https://github.com/BoeingPo/go-ledger-x-gitops"
  type        = string
}

variable "domain" {
  description = "Public domain for API services, e.g. api.yourdomain.com. DNS A record must point to vps_ip."
  type        = string
  default     = ""
}

variable "argocd_domain" {
  description = "Subdomain for ArgoCD UI, e.g. argocd.yourdomain.com. Leave empty to use kubectl port-forward instead."
  type        = string
  default     = ""
}

variable "headlamp_domain" {
  description = "Subdomain for Headlamp UI, e.g. headlamp.yourdomain.com."
  type        = string
  default     = ""
}
