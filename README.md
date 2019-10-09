# boulder-istio
demos for "Adopting Istio, One YAML at a Time" -- 10/9/19


## 1 - install Istio

Install Istio 1.3.1

```
./install-istio.sh
```


Start with a small application: Install httpbin + sleep (2-service sample app). Also includes a 3rd service -- loadgen -- to generate traffic at httpbin.

```
kubectl apply -f httpbin-sleep.yaml
```

## 2 - mtls

Encrypt all traffic between httpbin and sleep

## 3 - authz

Enforce authz -- read-only, no POST/PUT -- between sleep and httpbin.

## 4 - path based routing

Deploy an httpecho service alongside httpbin.

## 5 - header manipulation

Add + remove httpecho response headers.

## 6 - ingress

Let's install a larger application with a frontend.

(Deploy app without Gateway/VS - show kiali / separate backends)

Add Gateway

Add VS

Open Frontend in browser

Show Kiali

## 7 - canary deployments with Flagger

deploy flagger + respy

set up progressive canary for frontend

use watch respy on `/version` endpoint for frontend