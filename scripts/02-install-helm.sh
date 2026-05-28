#!/bin/bash
set -euo pipefail

echo "==> Installing Helm"

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

echo "==> Adding Helm repos"
helm repo add bitnami       https://charts.bitnami.com/bitnami
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add jetstack      https://charts.jetstack.io
helm repo update

echo "==> Helm ready"
