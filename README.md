# AWS EKS

## Terraform

**Planning**:
terraform plan -var-file dev.tfvars

**Applying**:
terraform apply -var-file dev.tfvars

**Destroying**:
terraform destroy -var-file dev.tfvars

**References**:

- https://www.terraform.io/docs/commands/index.html
- https://dzone.com/articles/terraform-cli-cheat-sheet

## AWS

**Set the cluster config for kubeconfig**:
aws eks --region sa-east-1 update-kubeconfig --name training-eks-tsoutello

**Checking the clusters**:
aws eks list-clusters

**References**:

- https://docs.aws.amazon.com/cli/latest/reference/eks/index.html

## Kubernetes commands

**Checking the resources**

- kubectl get all
- kubectl get svc
- kubectl get services

**References**:

- https://kubernetes.io/docs/reference/kubectl/cheatsheet/

