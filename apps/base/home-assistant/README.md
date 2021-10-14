# Home Assistant

Inspired from <https://randombytes.substack.com/p/home-assistant-on-kubernetes>

Exampel Ingress:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: homeassistant-ingress
  namespace: homeassistant
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: 'websecure'
    traefik.ingress.kubernetes.io/router.tls: 'true'
spec:
  rules:
    - host: ha.harmony.arkane-systems.lan
      http:
        paths:
          - pathType: Prefix
            path: /
            backend:
              service:
                name: homeassistant
                port:
                  number: 8123
```