helm install gcp-secretstore ./gcp-secret-store \
  --set namespace=atlas-dev \
  --set secretStoreName=gcp-secret-store \
  --set projectID=development-451212 \
  --set clusterName=atlas-dev-gke \   
  --set clusterLocation=us-central1-a \
  --set serviceAccountName=secret-sa \
  --set gcpServiceAccount=sa-gke-secretmanager@development-451212.iam.gserviceaccount.com



helm install gcp-secretstore ./gcp-secret-store \
  --set namespace=atlas-prod \
  --set secretStoreName=gcp-secret-store \
  --set projectID=production-453513 \
  --set clusterName=atlas-prod-gke \   
  --set clusterLocation=us-central1 \
  --set serviceAccountName=secret-sa \
  --set gcpServiceAccount=sa-gke-secretmanager@production-453513.iam.gserviceaccount.com



helm upgrade --install scaleway-secretstore . -n external-secrets 