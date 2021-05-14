# IAP Tunneling Example

This module will generate a bastion host vm compatible with [OS Login](https://cloud.google.com/compute/docs/oslogin/) and [IAP Tunneling](https://cloud.google.com/iap/) for given members that can be used to access Kubernetes Cluster.

This module will:

- Create a dedicated service account for the bastion host
- Create a GCE instance to be the bastion host
- Create a firewall rule to allow TCP:22 SSH access from the IAP to the bastion
- Necessary IAM bindings to allow IAP and OS Logins from specified members

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Cloud Identity-Aware Proxy API: `iap.googleapis.com`
- OS Login API: `oslogin.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

This module only sets up permissions for the bastion service account, not the users who need access. To allow access, grant one of the following instance access roles.

* `roles/compute.osLogin` Does not grant administrator permissions
* `roles/compute.osAdminLogin` Grants administrator permissions.

If the user does not share the same domain as the org the bastion is in, you will also need to grant that user `roles/compute.osLoginExternalUser`. This is to prevent external SSH access from being granted at the project level. See the [OS Login documentation](https://cloud.google.com/compute/docs/instances/managing-instance-access#configure_users) for more information.
## Usage

You can ssh to the VM instance with something similar to the following:

```
gcloud auth login
gcloud compute ssh instance-1 --zone us-central1-a --project my-project
```

You should now be logged in as a user that looks like `ext_me_example_com` with the prefix of `ext` indicating you have logged in with OS Login.
You should also notice the following line in standard out that indicates you are tunnelling through IAP instead of the public internet:

```
External IP address was not found; defaulting to using IAP tunneling.
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance | Name of the example VM instance to create and allow SSH from IAP. | `any` | n/a | yes |
| members | List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email} | `list(string)` | n/a | yes |
| project | Project ID where to set up the instance and IAP tunneling | `any` | n/a | yes |
| region | Region to create the subnet and example VM. | `string` | `"us-west1"` | no |
| zone | Zone of the example VM instance to create and allow SSH from IAP. | `string` | `"us-west1-a"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
