terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
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
    private_key = file(var.ssh_private_key_path)
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
