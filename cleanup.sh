#!/bin/bash

kubectl delete -f 1-install/
kubectl delete -f 2-mtls/
kubectl delete -f 3-authz/
kubectl delete -f 4-pathbased/
kubectl delete -f 5-headers/
kubectl delete -f 6-ingress/
kubectl delete -f 7-canary/
