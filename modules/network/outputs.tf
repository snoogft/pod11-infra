output "network" {
  value       = module.vpc.network
  description = "The VPC resource being created"
}
output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}
output "subnets" {
  value       = module.subnets.subnets
  description = "The created subnet resources"
}