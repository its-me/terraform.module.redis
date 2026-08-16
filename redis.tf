# One caller (create = true) provisions the Memorystore instance. Every other caller
# sharing the same `name` in the same project (create = false) just reads it back via
# a data source, so multiple independently-applied configs can share one Redis instance.
#
# Memorystore has no notion of per-caller databases like Postgres does; callers isolate
# their keys by picking distinct Redis logical DB indexes (0-15) in their own connection
# string, e.g. redis://<host>:<port>/1.

resource "google_redis_instance" "this" {
  count = var.create ? 1 : 0

  name           = var.name
  project        = var.project_id
  region         = var.region
  tier           = var.tier
  memory_size_gb = var.memory_size_gb

  authorized_network      = var.network_id
  connect_mode            = "PRIVATE_SERVICE_ACCESS"
  redis_version           = var.redis_version
  transit_encryption_mode = "DISABLED"

  redis_configs = var.redis_configs

  labels = var.labels
}

data "google_redis_instance" "this" {
  count = var.create ? 0 : 1

  name    = var.name
  project = var.project_id
  region  = var.region
}

locals {
  instance_id   = var.create ? google_redis_instance.this[0].id : data.google_redis_instance.this[0].id
  instance_name = var.create ? google_redis_instance.this[0].name : data.google_redis_instance.this[0].name
  host          = var.create ? google_redis_instance.this[0].host : data.google_redis_instance.this[0].host
  port          = var.create ? google_redis_instance.this[0].port : data.google_redis_instance.this[0].port
}
