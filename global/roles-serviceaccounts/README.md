# Roles & Service Accounts

This module consists of following submodules that create:

- adding required roles for human members
- adding required roles for cloud build member
- adding required roles for packer member

## Roles for human members

In order to give the possibility to human members for editing roles owner must give them `Project IAM Admin` role.

| Role name | ID | Description |
|------| ------|:--------:|
| Compute OS Admin Login | roles/compute.osAdminLogin | Access to log in to a Compute Engine instance as an administrator user.|
| IAP-secured Tunnel User | roles/iap.tunnelResourceAccessor | Access Tunnel resources which use Identity-Aware Proxy |

## Roles for cloud build member

| Role name | ID | Description |
|------| ------ | :--------:|
| Compute admin | roles/compute.admin  | Full control of all Compute Engine resources.|
| Compute Network Admin | roles/compute.networkAdmin | Full control of Compute Engine networking resources.|
| Kubernetes Engine Admin | roles/container.admin | Full management of Kubernetes Clusters and their Kubernetes API objects. |
| Role Administrator | roles/iam.roleAdmin | Access to administer all custom roles in the project.|
| Security Admin | roles/iam.securityAdmin | Security admin role, with permissions to get and set any IAM policy.|
| Service Account Admin | roles/iam.serviceAccountAdmin | Create and manage service accounts. |
| Service Account User | roles/iam.serviceAccountUser | Run operations as the service account. |
| Project IAM Admin | roles/resourcemanager.projectIamAdmin | Access and administer a project IAM policies. |
| Secret Manager Secret Accessor | roles/secretmanager.secretAccessor | Allows accessing the payload of secrets. |
| Service Management Administrator | roles/servicemanagement.admin | Full control of Google Service Management resources. |
| Storage Admin | roles/storage.admin | Full control of GCS resources. |
| GKE Hub Admin | roles/gkehub.admin | Full access to GKE Hub resources. |
