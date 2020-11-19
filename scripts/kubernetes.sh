#!/bin/bash

export TMP_LOG="log.txt"
export KUBECTL_CONFIG_FILE="/root/.kube/config"

function kubernetes_inspect() {

    echo "Kubectl version"
    kubectl version
    echo ""
    
    echo "Kube config $KUBECTL_CONFIG_FILE" 
    cat $KUBECTL_CONFIG_FILE
    echo ""
    
    echo "Kubernetes commands being executed ..."
    echo "" > $TMP_LOG
    
    echo "EKS SVC command" >>  $TMP_LOG
    kubectl get svc 1>> $TMP_LOG 2>&1
    echo "" >>  $TMP_LOG
    
    echo "EKS PODs command" >>  $TMP_LOG
    kubectl get pods --all-namespaces 1>> $TMP_LOG 2>&1
    echo "" >>  $TMP_LOG
    
    echo "EKS Config map" >>  $TMP_LOG
    kubectl describe configmap -n kube-system 1>> $TMP_LOG 2>&1
    echo "" >>  $TMP_LOG

    echo "Config view" >> $TMP_LOG
    kubectl config view --minify >> $TMP_LOG
    echo "" >>  $TMP_LOG

    echo "Config Map" >> $TMP_LOG
    kubectl get configmap aws-auth -n kube-system >> $TMP_LOG
    echo "" >>  $TMP_LOG

    echo "EKS Cluster role" >>  $TMP_LOG
    kubectl get clusterrole 1>> $TMP_LOG 2>&1
    echo "" >>  $TMP_LOG
    
    echo "EKS Cluster role admin" >>  $TMP_LOG
    kubectl describe clusterrole admin  >>  $TMP_LOG
    echo "" >>  $TMP_LOG

    echo "EKS get all"
    kubectl get all  >>  $TMP_LOG
    echo "" >>  $TMP_LOG

    echo "EKS Namespaces " >>  $TMP_LOG
    kubectl get namespace  >>  $TMP_LOG
    echo "" >>  $TMP_LOG

    echo "Kubernetes output"
    cat $TMP_LOG

}

function kubernetes_apply_pod() {

    echo ""
    echo "Applying POD ..."
    kubectl apply -f $1
    echo "POD applied"
    echo ""

}

function kubernetes_unset_aws_config() {

    echo "Unsetting AWS vars..."
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    echo "Unsetting AWS vars done !"

}

function kubernetes_init() {

    echo ""
    echo "Applying initial configuration..."
    # Create role binding
    kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=admin
    # Apply cluster role permission
    kubectl apply -f kubernetes/cluster_role_permission.yaml
    # Deploy the Metrics server (which is not enabled by default in EKS):
    kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
    # Deploy the Dashboard into your cluster:
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
    # Apply eks admin service
    kubectl apply -f kubernetes/eks-admin-service-account.yaml
    echo "Initial configuration applied !"
    echo ""

}