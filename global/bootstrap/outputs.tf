output "bucket_name" {
  description = "The created storage bucket"
  value       = module.gcs_buckets.bucket.name
}