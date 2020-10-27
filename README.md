# aws-eks

Applying:
terraform apply -var-file dev.tfvars -var-file terraform.tfvars

AWS set the cluster config for kubeconfig:
aws eks --region sa-east-1 update-kubeconfig --name training-eks-tsoutello

Checking the cluster and the resources:
aws eks list-clusters
kubectl get all
kubectl get svc
