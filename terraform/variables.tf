# terraform/variables.tf
variable "app_version" {
  description = "Version of the application"
  type        = string
  default     = "v1.0.0"
}

variable "app_port" {
  description = "External port for the web application"
  type        = number
  default     = 5000
}