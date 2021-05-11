# Pod11 Infrastructure
Repository for pod11 infrastructure project on GCP

## FAQ

What to do if I am getting following error:
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
