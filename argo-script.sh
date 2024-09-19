#!/bin/bash


if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <Namespace y path> <Rama del repo>"
    exit 1
fi


# Variables
ARGOCD_SERVER="openshift-gitops-server-openshift-gitops.apps.cluster-g87nx.sandbox2191.opentlc.com"      # URL del servidor ArgoCD
ARGOCD_USERNAME="admin"                # Usuario de ArgoCD
ARGOCD_PASSWORD="3OiIoM6wzQXLJt7vsApdxfh9Cyk4PNlY"             # Contraseña de ArgoCD
APPLICATION_NAME="$1"       # Nombre de la aplicación en ArgoCD
REPO_URL="https://github.com/Patricio-Mondragon/demo-argo-cd.git" # URL del repositorio Git
REPO_PATH="$1"  # Path dentro del repo donde está la app
DEST_NAMESPACE="$1"          # Namespace en OpenShift donde se desplegará la app
DEST_SERVER="https://kubernetes.default.svc" # El clúster de OpenShift
BRANCH="$2" #Rama de la cual se tomará el path


# Autenticación en ArgoCD
argocd login $ARGOCD_SERVER --username $ARGOCD_USERNAME --password $ARGOCD_PASSWORD --insecure

# Crear la aplicación en ArgoCD
argocd app create $APPLICATION_NAME \
    --repo $REPO_URL \
    --path $REPO_PATH \
    --dest-server $DEST_SERVER \
    --dest-namespace $DEST_NAMESPACE \
    --revision $BRANCH

# Sincronizar la aplicación para desplegarla en el clúster de OpenShift
argocd app sync $APPLICATION_NAME
