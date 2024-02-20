resource "docker_image" "wielabel_image" {
  name = var.image_name
}

resource "docker_container" "wielabel_container" {
  name  = var.container_name
  image = docker_image.wielabel_image.latest
  ports {
    internal = var.internal_port
    external = var.external_port
  }
}


resource "google_cloud_run_service" "wielabel" {
  name     = "cloudrun-srv"
  location = "europe-west3"

  template {
    spec {
      containers {
        name = docker_container.wielabel_container.name
        image = docker_image.wielabel_image
        ports {
         container_port = docker_container.wielabel_container.ports
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_dns_managed_zone" "dev-wielabel" {
  name     = "dev.wielabel"
  dns_name = "dev.wielabel.wiethe.com"
}

resource "google_dns_record_set" "wielabel" {
  managed_zone = google_dns_managed_zone.dev-wielabel.name

  name    = "www.${google_dns_managed_zone.dev-wielabel.dns_name}"
  type    = "A"
  rrdatas = ["10.1.2.1", "10.1.2.2"]
  ttl     = 300
}