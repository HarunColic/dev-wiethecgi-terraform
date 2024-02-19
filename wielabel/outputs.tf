output "container_ip" {
  value       = docker_container.wielabel_container.ip_address
  description = "The IP address of the wielabel container."
}