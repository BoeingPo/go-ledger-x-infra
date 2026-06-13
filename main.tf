terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

locals {
  ssh_auth_valid = var.ssh_private_key_path != "" || var.ssh_password != ""
}

resource "null_resource" "ssh_auth_check" {
  count = local.ssh_auth_valid ? 0 : 1
  provisioner "local-exec" {
    command = "echo 'ERROR: provide either ssh_private_key_path or ssh_password in terraform.tfvars' && exit 1"
  }
}

# Bootstrap the ReadyIDC VPS: install k3s, Helm, ArgoCD, then seed the app-of-apps.
# Run once: terraform apply
# After that, ArgoCD owns all deployments — never run terraform apply again for day-to-day ops.

resource "null_resource" "k3s_bootstrap" {
  connection {
    type        = "ssh"
    host        = var.vps_ip
    user        = var.ssh_user
    private_key = var.ssh_private_key_path != "" ? file(var.ssh_private_key_path) : null
    password    = var.ssh_password != "" ? var.ssh_password : null
    timeout     = "5m"
  }

  provisioner "file" {
    source      = "${path.module}/scripts/"
    destination = "/tmp/ledgerx-scripts"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ledgerx-scripts/*.sh",
      "bash /tmp/ledgerx-scripts/01-install-k3s.sh ${var.k3s_version}",
      "bash /tmp/ledgerx-scripts/02-install-helm.sh",
      "bash /tmp/ledgerx-scripts/03-install-argocd.sh",
      "bash /tmp/ledgerx-scripts/04-bootstrap-argocd.sh ${var.argocd_gitops_repo}",
      "bash /tmp/ledgerx-scripts/05-get-kubeconfig.sh",
    ]
  }
}
