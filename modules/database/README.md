# Connecting to Cloud SQL from an application in Kubernetes Engine


## Introduction

This shows how to connect an application in Kubernetes Engine to
a Cloud SQL instance using the Cloud SQL Proxy container as a sidecar container.
You will deploy a [Kubernetes Engine](https://cloud.google.com/kubernetes-engine/) (Kubernetes Engine)
cluster and a [Cloud SQL](https://cloud.google.com/sql/docs/) Postgres instance
and use the [Cloud SQL Proxy container](https://gcr.io/cloudsql-docker/gce-proxy:1.11)
to allow communication between them.
This module creates a [Google Cloud SQL](https://cloud.google.com/sql/) cluster.
The cluster is managed by Google, automating backups, replication, patches, and updates.

This module helps you run [PostgreSQL](https://cloud.google.com/sql/docs/postgres/) databases in [Google Cloud](https://cloud.google.com/).

## Cloud SQL Architecture

![Cloud SQL Architecture](https://github.com/gruntwork-io/terraform-google-sql/blob/master/_docs/cloud-sql.png "Cloud SQL Architecture")

## Features

- Deploy a fully-managed relational database
- Supports PostgreSQL
- Optional failover instances
- Optional read replicas



### Cloud SQL Proxy

The Cloud SQL Proxy allows you to offload the burden of creating and
maintaining a connection to your Cloud SQL instance to the Cloud SQL Proxy
process. Doing this allows your application to be unaware of the connection
details and simplifies your secret management. The Cloud SQL Proxy comes
pre-packaged by Google as a Docker container that you can run alongside your
application container in the same Kubernetes Engine pod.

## Architecture

The application and its sidecar container are deployed in a single Kubernetes
(k8s) pod running on the only node in the Kubernetes Engine cluster. The
application communicates with the Cloud SQL instance via the Cloud SQL Proxy
process listening on localhost.

The k8s manifest builds a single-replica Deployment object with two containers,
pgAdmin and Cloud SQL Proxy. There are two secrets installed into the Kubernetes
Engine cluster: the Cloud SQL instance connection information and a service
account key credentials file, both used by the Cloud SQL Proxy containers Cloud
SQL API calls.

The application doesn't have to know anything about how to connect to Cloud
SQL, nor does it have to have any exposure to its API. The Cloud SQL Proxy
process takes care of that for the application. It's important to note that the
Cloud SQL Proxy container is running as a 'sidecar' container in the pod.

![Application in Kubernetes Engine using a Cloud SQL Proxy sidecar container to communicate
with a Cloud SQL Proxy instance](docs/architecture-diagram.png)


## Deployment

Deployment is fully automated. The cloudbuild
takes the following parameters, in order:
* A username for your Cloud SQL instance
* A username for the pgAdmin console

The cloudbuild takes requires from secret menager:
* USER_PASSWORD - the password to login to the Postgres instance


## Inputs
| Name | Description | Type |
|------|-------------|:------:|
| project | 	The project ID to host the cluster in (required) | `string` |
| name | 	The name of the database (required) | `string` |
| region | 	The region to host the database in (optional if zonal db / required if regional) | `string` |
| network | 	The VPC network to host the database in (required) | `string` |
| private_network | 	The private network to host the database in (required) | `string` |
| reserved_peering_range | 	The name of the networks that can connect to a given VPC network using VPC Network Peering. | `string` |
| engine | 	The PosgreSQl version | `string` |
| machine_type| 	The type of VM | `bool` |
| master_user_password | 	The password for database user | `string` |
| master_user_name | 	The name of the database user | `bool` |
| master_user_host | 	The host of master user| `bool` |
| dependencies | 	List of master authorized networks. If none are provided, disallow external access (except the cluster node IPs, which GKE automatically whitelists). | `list(object({ cidr_block = string, display_name = string }))` |

## Outputs
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| master_instance_name | The name of the database instance | `any` | n/a | yes |
| master_ip_addresses | All IP addresses of the instance as list of maps, see https://www.terraform.io/docs/providers/google/r/sql_database_instance.html#ip_address-0-ip_address | `list(string)` | n/a | yes |
| master_private_ip | The private IPv4 address of the master instance| `any` | n/a | yes |
| master_instance | Self link to the master instance | `string` | `"us-west1"` | no |
| master_proxy_connection | Instance path for connecting with Cloud SQL Proxy. Read more at https://cloud.google.com/sql/docs/mysql/sql-proxy | `string` | `"us-west1-a"` | no |
| master_instance | Self link to the master instance | `string` | `"us-west1"` | no |
| db_name| Name of the default database | `string` | `"us-west1"` | no |
| db | Self link to the default database | `string` | `"us-west1"` | no |
| master_user_name | The username part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_name so you don't check it into source control.| `string` | `"us-west1"` | no |
| master_user_password | The password part for the default user credentials, i.e. 'master_user_name'@'master_user_host' IDENTIFIED BY 'master_user_password'. This should typically be set as the environment variable TF_VAR_master_user_password so you don't check it into source control. | `string` | `"us-west1"` | no |


### Resolution

You cannot reuse an instance name for up to a week after you have deleted an
instance.
https://cloud.google.com/sql/docs/mysql/delete-instance

**This is not an officially supported Google product**
