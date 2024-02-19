variable "image_name" {
  description = "The name of the Docker image for wielabel."
  type        = string
  default     = ""
}

variable "container_name" {
  description = "The name of the Docker container."
  type        = string
}

variable "internal_port" {
  description = "The internal port of the wielabel container."
  type        = number
  default     = 1880
}

variable "external_port" {
  description = "The port on the host that forwards to the internal port."
  type        = number
  default     = 1880
}