#!/bin/bash

WORKDIR="/Users/mokeefe"
ISTIO_VERSION=1.3.2

kubectl create namespace istio-system

kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)

helm template ${WORKDIR}/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -
sleep 20

kubectl get crds | grep 'istio.io\|certmanager.k8s.io' | wc -l

sleep 2

helm template ${WORKDIR}/istio-${ISTIO_VERSION}/install/kubernetes/helm/istio --name istio --namespace istio-system \
--set prometheus.enabled=true \
--set tracing.enabled=true \
--set kiali.enabled=true --set kiali.createDemoSecret=true \
--set "kiali.dashboard.jaegerURL=http://jaeger-query:16686" \
--set "kiali.dashboard.grafanaURL=http://grafana:3000" \
--set grafana.enabled=true \
--set global.proxy.accessLogFile="/dev/stdout" \
--set sidecarInjectorWebhook.enabled=true > istio.yaml

# install istio
kubectl apply -f istio.yaml

# kiali + istioctl dashboard aren't playing nice today
kubectl expose deployment -n istio-system kiali --port 20001 --name kiali2 --type LoadBalancer