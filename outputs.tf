output "instance_id" {
  description = "ID of the shared Redis instance."
  value       = local.instance_id
}

output "instance_name" {
  description = "Name of the shared Redis instance."
  value       = local.instance_name
}

output "host" {
  description = "Private IP address of the Redis instance."
  value       = local.host
}

output "port" {
  description = "Port the Redis instance listens on."
  value       = local.port
}
