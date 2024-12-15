# terraform/main.tf
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "webapp" {
  name         = "webapp:${var.app_version}"
  build {
    context = "../app"
    tag  = ["webapp:${var.app_version}"]
  }
}

resource "docker_container" "webapp" {
  image = docker_image.webapp.image_id
  name  = "webapp-${var.app_version}"
  ports {
    internal = 5000
    external = var.app_port
  }
  env = [
    "APP_VERSION=${var.app_version}"
  ]
}

/*
output "container_id" {
  value = docker_container.webapp.id
}

output "container_name" {
  value = docker_container.webapp.name
}
*/