provider "google" {
  project     = var.project_id
  credentials = file("${path.module}/auth/authfile.json")
}

provider "google-beta" {
  project     = var.project_id
  credentials = file("${path.module}/auth/authfile.json")
}

terraform {
  required_version = ">= 0.14"
  # backend "gcs" {
  #   bucket  = "your-bucket-here-tfstate"
  #   prefix  = "project/project-state"
  # }
}
