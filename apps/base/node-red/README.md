# Node-Red

Inspired from https://randombytes.substack.com/p/home-assistant-on-kubernetes

Example Ingress for overlay:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: node-red-ingress
  namespace: automation
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: 'websecure'
    traefik.ingress.kubernetes.io/router.tls: 'true'
spec:
  rules:
    - host: node.harmony.arkane-systems.lan
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: node-red
                port:
                  number: 1880
```