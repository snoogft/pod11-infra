# bastion host with IAP tunneling

This module allow TCP forwarding using
[Identity-Aware Proxy (IAP) Tunneling](https://cloud.google.com/iap/docs/using-tcp-forwarding).

This module will:

- Create firewall rules to allow connections from IAP's TCP forwarding IP addresses to the TCP port
of Kubernetes cluster.
- Create IAM bindings to allow IAP from specified members.

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
=======
$ gcloud compute firewall-rules list --project my-project --filter="name=allow-ssh-from-iap-to-tunnel"
NAME                          NETWORK  DIRECTION  PRIORITY  ALLOW   DENY  DISABLED
allow-ssh-from-iap-to-tunnel  default  INGRESS    1000      tcp:22        False
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
