output "network" {
  value       = module.vpc.network
  description = "The VPC resource being created"
}

output "network_2" {
  value       = module.vpc_2.network
  description = "The VPC_2 resource being created"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_2_name" {
  value       = module.vpc_2.network_name
  description = "The name of the VPC_2 being created"
}

output "subnets" {
  value       = module.subnets.subnets
  description = "The created subnet resources"
}

output "subnets_vpc_2" {
  value       = module.subnets_vpc_2.subnets
  description = "The created subnet resources"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "network_self_link_vpc_2" {
  value       = module.vpc_2.network_self_link
  description = "The URI of the VPC being created"
}