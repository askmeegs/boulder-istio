# boulder-istio
demos for "Adopting Istio, One YAML at a Time" -- 10/9/19

All these YAML files build on each other -- tells a story of adopting Istio starting with a small (then larger) application, in the order of adopting the following features: Telemetry, Security, Policy, Traffic Management.

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

Show Kiali

## 3 - authz

Enforce authz -- read-only, no POST/PUT -- between sleep and httpbin.

Before/after enforce:
```
curl -d "fall=awesome&pumpkins=great" -X POST httpbin:8000/anything
```

For authz, add headers:

```
curl -H "hello:world" -d "fall=awesome&pumpkins=great" -X POST httpbin:8000/anything
```

## 4 - path based routing

Deploy an httpecho service alongside httpbin.

```
kubectl apply -f echo.yaml
```

All requests to httpbin/echo get rerouted from httpbin to echo:

```
kubectl apply -f route-headers.yaml
```

Now curl httpbin with the path prefix -- request is forwarded to the echo service:

```
curl -H "hello:world" httpbin:8000/echo
```

## 5 - header manipulation

```
curl -I echo:80
```

Add + remove httpecho response headers:

```
kubectl apply -f add-remove-headers.yaml
```

```
curl -I echo:80
```

## 6 - ingress

Let's install a larger application with a frontend.

(Deploy app without Gateway/VS - show kiali / separate backends)

Add Gateway

Add VS

Open Frontend in browser

Show Kiali

## 7 - canary deployments with Flagger

deploy respy and frontend v2

show kiali > Versioned App Graph

use watch respy on `/version` endpoint for frontend -- show round robin (50/50)

split traffic 90/10:

```
kubectl apply -f split-traffic.yaml
```

show percentages in respy

show kiali requests percentage

