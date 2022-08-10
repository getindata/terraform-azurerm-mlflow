# Example, compulsory input variable


variable "resource_group" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Location for all of the resources. Falls back to the Resource Group's default."
  type        = string
  default     = null
}

variable "db_admin_username" {
  description = "Database Server root username"
  type        = string
  default     = "mlflow_root"
}

variable "db_max_size_gb" {
  description = "Max database size in GB"
  type        = number
  default     = 4
}

variable "db_backup_type" {
  description = "Storage account type used to store backups for this database. One of: Geo, GeoZone, Local, Zone"
  type        = string
  default     = "Local"
}

variable "storage_sku" {
  description = "Azure Storage Account SKU. See https://docs.microsoft.com/en-us/rest/api/storagerp/srp_sku_types"
  type        = string
  default     = "Standard_GRS"
}

variable "mlflow_docker_image" {
  description = "MLflow docker image. See https://github.com/getindata/mlflow-docker"
  type        = string
  default     = "marrrcin/mlflow-azure:latest"
}

variable "cpu" {
  description = "Container App CPU requirements"
  type        = number
  default     = 0.75
}

variable "memory" {
  description = "Container App memory requirements"
  type        = string
  default     = "1.5Gi"
}

variable "min_replicas" {
  description = "Min number of Container App replicas"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Max number of Container App replicas"
  type        = number
  default     = 1
}