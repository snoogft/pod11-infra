# Pod11 Infrastructure
Repository for pod11 infrastructure project on GCP

## FAQ

### How should I write shell scripts?

Google shell style guide: https://google.github.io/styleguide/shellguide.html

### What to do if I am getting error "Attempted to load application default credentials"
```
Error: Attempted to load application default credentials since neither `credentials` nor `access_token` was set in the provider block.  No credentials loaded. To use your gcloud credentials, run 'gcloud auth application-default login'.  Original error: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.
```

You have to declare `GOOGLE_APPLICATION_CREDENTIALS` environment variable and point it to service account JSON key:
```
export GOOGLE_APPLICATION_CREDENTIALS="./pol-pod11-dev-01.json"
```

## Reminder

The Golden Rule of Terraform:
> The master branch of the live repository should be a 1:1
> representation of what’s actually deployed in production.


# Usage
If you would like to connect to Kubernetes cluster use following command to get kubeconfig
```

gcloud container clusters get-credentials dev-cluster --zone=europe-central2-a
```

# Anthos multi-cluster ingress config
After setting up cluster through Terraform you can check registered cluster using:
```
gcloud container hub memberships list
```

If you would like to add cluster as the Multi-cluster ingress config cluster you have to run following command:
```
gcloud alpha container hub ingress enable \
  --config-membership=projects/pol-pod11-dev-01/locations/global/memberships/${CLUSTER_1_NAME}
```

In order to disable ingress config cluster you have to run following command:
```
gcloud alpha container hub ingress disable
```