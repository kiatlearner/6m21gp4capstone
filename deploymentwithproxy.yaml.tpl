apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    run: emr-app  # Label for the Deployment
  name: emr-app # Name of Deployment
spec:
  replicas: 2
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 3
      maxUnavailable: 1
  selector:
    matchLabels:
      run: emr-app
      app: emr-app
  template: # Pod template
    metadata:
      labels:
        run: emr-app # Labels Pods from this Deployment
        app: emr-app
    spec: # Pod specification; each Pod created by this Deployment has this specification
      serviceAccountName: ksa-cloud-sql
      containers:
      - name: emr-app
        # Replace <LOCATION> with your Artifact Registry location (e.g., us-central1).
        # Replace <YOUR_PROJECT_ID> with your project ID.
        image: asia-southeast1-docker.pkg.dev/GOOGLE_CLOUD_PROJECT/emr-ar/emr-image:COMMIT_SHA
        # This app listens on port 8080 for web traffic by default.
        ports:
        - containerPort: 8080
#        env:
#        - name: PORT
#          value: "8080"
#        - name: INSTANCE_HOST
#          value: "127.0.0.1"
#        - name: DB_PORT
#          value: "3306"
#        - name: DB_USER
#          valueFrom:
#            secretKeyRef:
#              name: <YOUR-DB-SECRET>
#              key: username
#        - name: DB_PASS
#          valueFrom:
#            secretKeyRef:
#              name: <YOUR-DB-SECRET>
#              key: password
#        - name: DB_NAME
#          valueFrom:
#            secretKeyRef:
#              name: <YOUR-DB-SECRET>
#              key: database
      - name: cloud-sql-proxy
        # This uses the latest version of the Cloud SQL proxy
        # It is recommended to use a specific version for production environments.
        # See: https://github.com/GoogleCloudPlatform/cloudsql-proxy
        image: gcr.io/cloudsql-docker/gce-proxy:latest
        command:
          - "/cloud_sql_proxy"

          # If connecting from a VPC-native GKE cluster, you can use the
          # following flag to have the proxy connect over private IP
          # - "-ip_address_types=PRIVATE"

          # tcp should be set to the port the proxy should listen on
          # and should match the DB_PORT value set above.
          # Defaults: MySQL: 3306, Postgres: 5432, SQLServer: 1433
          - "-instances=glassy-sky-352905:asia-southeast1:emrdb=tcp:3306"
        securityContext:
          # The default Cloud SQL proxy image runs as the
          # "nonroot" user and group (uid: 65532) by default.
          runAsNonRoot: true

---

apiVersion: v1
kind: Service
metadata:
  name: neg-emr-svc
  annotations:
    cloud.google.com/neg: '{"ingress": true}' # Creates a NEG after an Ingress is created
spec:
  type: ClusterIP
  selector:
    run: emr-app # Selects Pods labelled run: emr-app
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 8080 # apache2 listening on 8080

---

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: neg-emr-ing
spec:
  defaultBackend:
    service:
      name: neg-emr-svc # Name of the Service targeted by the Ingress
      port:
        number: 80 # Should match the port used by the Service

