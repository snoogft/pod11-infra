output "bucket_name_tfstate" {
  description = "Name for created storage bucket for tfstate"
  value       = module.gcs_buckets.bucket.name
}

output "bucket_name_cloudbuild" {
  description = "Name for created storage bucket for cloudbuild"
  value       = module.gcs_buckets_cloudbuild.bucket.name
}