resource "docker_image" "qa_image" {
  name = var.image_name
}

resource "docker_container" "qa_container" {
  name  = var.container_name
  image = docker_image.qa_image.latest
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}


resource "google_cloud_run_service" "qa" {
  name     = "cloudrun-srv"
  location = "europe-west3"

  template {
    spec {
      containers {
        name = docker_container.qa_container.name
        image = docker_image.qa_image
        ports {
         container_port = docker_container.qa.ports
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_dns_managed_zone" "dev-qa" {
  name     = "dev.qa"
  dns_name = "dev.qa.wiethe.com"
}

resource "google_dns_record_set" "qa" {
  managed_zone = google_dns_managed_zone.dev-qa.name

  name    = "www.${google_dns_managed_zone.dev-qa.dns_name}"
  type    = "A"
  rrdatas = ["10.1.2.1", "10.1.2.2"]
  ttl     = 300
}