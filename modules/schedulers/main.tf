resource "google_cloud_scheduler_job" "job" {
  name             = var.name
  description      = var.description
  schedule         = var.schedule
  time_zone        = var.time_zone
  attempt_deadline = "320s"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    uri         = var.uri
    body        = base64encode("{\"foo\":\"bar\"}")
  }
}