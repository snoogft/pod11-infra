variable "project" {
  description = "Id of the project"
}

variable "region" {
  description = "Region for a subnet-01"
}

variable "zone" {
  description = "Zone for a subnet-01"
}

variable "zone_2" {
  description = "Zone_2 for a subnet-01"
}

variable "cluster_name" {
  description = "GKE cluster name"
}

variable "jwt_pub" {
  description = "JWT pub"
  default     = "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQ0lqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FnOEFNSUlDQ2dLQ0FnRUE0R3ZaTlNrajVpaVdiMkRaTTJmQwp4NWJHR1lnd2FLNFNNc3lJOEs4b0ZRZXBMMTNZUk9YS3c1UytsRUxIOUFldFRkY1RBZGtiQ3p5YXBTZGszUHF3CnhoQ2FmNGtudktlUmk3NmNzRzZtYzBrcngxR0l0WTY1WCtOcTBxYVJ2TGRPT2JGUUdtSUh4NzV6a1o2NTQrZnQKdm52Q1k1T1BqVjQ0TGt0dTF3bHJCbXIyMjVRU0ZiSWE4QTk2QlNwSnpLbTBhaEsrNnI4VnZ2T3ExQkhHWklJSwpLR1E3L3pMdXhQT24rYzN3Q0YwVlFZMjBZNFhvbytEVnQvKzBNSThPWnZkQXVhYjJVWHViK1Rpd0FnRzc2OHluCkpQaDdla2xMdGR0QTFCR2dsWG1vRVI0eHZoaFhRc09SdFRpNjBGWlBYN0MzVjFybFVlK3JVOUJZNkNscldsZUoKdGdCZjFYUi90Qm1MZGZCNFlWbkt0ekI3dkxDbE9LdWx0YWR1U1ZuZnY4QzB1ejF6UEJaSXdYbnNWTzdYeVNWUApBSkJUOFBWR1Iza2JnOW5FRGsvclZsS1lNSW5EU084U0hOeUtPK2s2cFRobWFtb3FNQkpCQ3BjQytHMVVQVXFZCmV1Szh3NjZaU3BLV2ZQY3RtWWViUHNraUpiS2VPckhWVTJEajd6emRpbUwyYmVocVN3U2kzekFrbFdmNEZTQXoKaC80enBENFdxM0lDd2NYbFBxYTU5T0IwcXFBQ3g1QW1FRmx2UXVVSTBxNndaNnZybEFZSytNZG00RHZGQVVsWApzNW1mbDZPRnZ0YkZTZHF1ckU2SXROVnlSVlFBbHpYV21oQzhHcldCSWh0MU9KTFdES081bHZabUpRL2xrN2JzClVyNCsyK05ObnNzTXBuTUI2QytJejZzQ0F3RUFBUT09Ci0tLS0tRU5EIFBVQkxJQyBLRVktLS0tLQo="
}

variable "workspace_env" {
  description = "Used workspace env"
}

variable "namespace" {
  description = "GKE namespace used by workload identity"
  default     = "default"
}

variable "k8s_sa_name" {
  description = "GKE service account name"
  default     = "boa-ksa"
}