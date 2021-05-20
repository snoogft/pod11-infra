variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
}

variable "cloud_build_member_name" {
  description = "Email pointing on cloud build SA"
  type        = string
}

variable "project" {
  description = "Project ID where to set up the instance and IAP tunneling"
  type        = string
}
