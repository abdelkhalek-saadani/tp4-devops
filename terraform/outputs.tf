output "container_id" {
  description = "ID of the deployed Docker container"
  value       = docker_container.webapp.id
}

output "container_name" {
  description = "Name of the deployed Docker container"
  value       = docker_container.webapp.name
}

output "container_image" {
  description = "Image used for the container"
  value       = docker_container.webapp.image
}

output "container_ports" {
  description = "Ports exposed by the container"
  value = {
    internal = docker_container.webapp.ports[0].internal
    external = docker_container.webapp.ports[0].external
  }
}

output "app_url" {
  description = "URL to access the application"
  value       = "http://localhost:${var.app_port}"
}

output "app_version" {
  description = "Version of the deployed application"
  value       = var.app_version
}