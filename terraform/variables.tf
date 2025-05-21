variable "resource_group_name" {
  type        = string
  description = "Nombre del grupo de recursos"
}

variable "location" {
  type        = string
  description = "Ubicación de Azure"
  default     = "East US"
}