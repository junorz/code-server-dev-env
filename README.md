# Code server with development environment

Envionment list
- Node 16.14.2(with yarn enabled by default)
- Oracle JDK 17

# Usage
## Kubernetes example
- Deployment
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: code-server-deployment
spec:
  selector:
    matchLabels:
      app: code-server
  replicas: 1
  template:
    metadata:
      labels:
        app: code-server
    spec:
      volumes:
        - name: your-volume-name-here
          persistentVolumeClaim:
            claimName: your-pvc-name-here
      containers:
        - name: code-server
          image: junorz/code-server-dev-env:latest
          imagePullPolicy: Always
          securityContext:
            # set uid and gid you want, can not be root here.
            runAsUser: 1000
            runAsGroup: 1000
          env:
            - name: DOCKER_USER
              value: coder
          ports:
            - containerPort: 8080
          volumeMounts:
            # folders here must be the owner you set in securityContext
            - name: your-volume-name-here
              mountPath: /home/coder/.config
              subPath: code-server/.config
            - name: your-volume-name-here
              mountPath: /home/coder/project
              subPath: code-server/project
```
- Service
```
apiVersion: v1
kind: Service
metadata:
  name: code-server-service
  labels:
    app: code-server
spec:
  selector:
    app: code-server
  ports:
    - port: 80
      targetPort: 8080
```
- Ingress
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: code-server-ingress
spec:
  ingressClassName: nginx
  rules:
    - host: your.domain.here
      http:
        paths:
          - backend:
              service:
                name: code-server-service
                port:
                  number: 80
            path: /
            pathType: Prefix
```