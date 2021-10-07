provider "google" {
  project     = var.project_id
  credentials = file(var.gcp_auth_file)
}

provider "google-beta" {
  project     = var.project_id
  credentials = file(var.gcp_auth_file)
}

terraform {
  required_version = ">= 0.13.5"
  # backend "gcs" {
  #   bucket  = "your-bucket-here-tfstate"
  #   prefix  = "project/project-state"
  # }
}
