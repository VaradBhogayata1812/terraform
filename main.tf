terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

data "google_compute_address" "flaskapp_ip" {
  name   = "flaskapp"
  region = "europe-north1"
}

data "google_compute_address" "nginx_ip" {
  name   = "nginx"
  region = "europe-north1"
}

resource "google_compute_instance" "flask_instance" {
  name         = "flaskapp"
  machine_type = "e2-medium"
  zone         = "europe-north1-a"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = data.google_compute_address.flaskapp_ip.address
      network_tier = "STANDARD"
    }
  }

 tags = ["http-server"]
}

resource "google_compute_instance" "nginx_instance" {
  name         = "nginx2"
  machine_type = "e2-medium"
  zone         = "europe-north1-a"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = data.google_compute_address.nginx_ip.address
      network_tier = "STANDARD"
    }
  }

 tags = ["http-server"]
}
