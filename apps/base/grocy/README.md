# Home Assistant

Inspired from <https://randombytes.substack.com/p/home-assistant-on-kubernetes>

Example Ingress:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grocy-ingress
  namespace: homeassistant
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: 'websecure'
    traefik.ingress.kubernetes.io/router.tls: 'true'
spec:
  rules:
    - host: grocy.harmony.arkane-systems.lan
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: grocy
                port:
                  number: 80
```