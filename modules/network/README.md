# Terraform VPC Module

This module consists of following submodules that create:

- vpc network and optionally enables it as a Shared VPC host project
- subnets within vpc network
- custom VPC firewall rules


## Inputs for VPC network module

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| auto\_create\_subnetworks | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| delete\_default\_internet\_gateway\_routes | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| description | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| mtu | The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically. | `number` | `0` | no |
| network\_name | The name of the network being created | `any` | n/a | yes |
| project\_id | The ID of the project where this VPC will be created | `any` | n/a | yes |
| routing\_mode | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |
| shared\_vpc\_host | Makes this project a Shared VPC host if 'true' (default 'false') | `bool` | `false` | no |

## Inputs for Subnets module

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | The name of the network where subnets will be created | `any` | n/a | yes |
| project\_id | The ID of the project where subnets will be created | `any` | n/a | yes |
| secondary\_ranges | Secondary ranges that will be used in some of the subnets | `map(list(object({ range_name = string, ip_cidr_range = string })))` | `{}` | no |
| subnets | The list of subnets being created | `list(map(string))` | n/a | yes |

## Inputs for Firewall rules

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network\_name | Name of the network this set of firewall rules applies to. | `any` | n/a | yes |
| project\_id | Project id of the project that holds the network. | `any` | n/a | yes |
| rules | List of custom rule definitions (refer to variables file for syntax). | <pre>list(object({<br>    name                    = string<br>    description             = string<br>    direction               = string<br>    priority                = number<br>    ranges                  = list(string)<br>    source_tags             = list(string)<br>    source_service_accounts = list(string)<br>    target_tags             = list(string)<br>    target_service_accounts = list(string)<br>    allow = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    deny = list(object({<br>      protocol = string<br>      ports    = list(string)<br>    }))<br>    log_config = object({<br>      metadata = string<br>    })<br>  }))</pre> | `[]` | no |