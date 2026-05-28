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
  description = "Path to your SSH private key, e.g. ~/.ssh/id_rsa"
  type        = string
}

variable "k3s_version" {
  description = "k3s version to install, e.g. v1.30.0+k3s1"
  type        = string
  default     = "v1.30.0+k3s1"
}

variable "argocd_gitops_repo" {
  description = "HTTPS URL of go-ledger-x-gitops repo, e.g. https://github.com/boeing/go-ledger-x-gitops"
  type        = string
}
