variable "project_id" {
  description = "GCP project ID the instance lives in."
  type        = string
}

variable "region" {
  description = "GCP region for the instance."
  type        = string
}

variable "name" {
  description = "Name of the Memorystore Redis instance."
  type        = string
}

variable "create" {
  description = "Whether this caller creates the Redis instance (true), or just reads back an instance created by another caller of this module in the same project (false). Exactly one caller sharing a given `name` should set this to true."
  type        = bool
  default     = true
}

variable "network_id" {
  description = "ID of the VPC network to attach the instance to via private service access (e.g. module.network.network_id from terraform.module.network). Only used when create = true."
  type        = string
  default     = null
}

variable "tier" {
  description = "Memorystore service tier: BASIC (single node) or STANDARD_HA (replica + failover). Only used when create = true."
  type        = string
  default     = "BASIC"
}

variable "memory_size_gb" {
  description = "Instance memory size in GB. Only used when create = true."
  type        = number
  default     = 1
}

variable "redis_version" {
  description = "Redis version for the instance. Only used when create = true."
  type        = string
  default     = "REDIS_7_2"
}

variable "redis_configs" {
  description = "Redis config overrides (e.g. maxmemory-policy). Only used when create = true."
  type        = map(string)
  default = {
    maxmemory-policy = "noeviction"
  }
}

variable "labels" {
  description = "Labels applied to the instance. Only used when create = true."
  type        = map(string)
  default     = {}
}
