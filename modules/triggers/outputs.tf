output "trigger_id" {
  description = "Trigger ID value"
  value       = google_cloudbuild_trigger.build-trigger.trigger_id
}