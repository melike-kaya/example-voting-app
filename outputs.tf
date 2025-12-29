locals {
  redshift_route_table_ids = aws_route_table.redshift[*].id
  public_route_table_ids   = aws_route_table.public[*].id
  private_route_table_ids  = aws_route_table.private[*].id
}

################################################################################
# VPC
################################################################################

output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.this[0].id, null)
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.this[0].arn, null)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.this[0].cidr_block, null)
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(aws_vpc.this[0].default_security_group_id, null)
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = try(aws_vpc.this[0].default_network_acl_id, null)
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = try(aws_vpc.this[0].default_route_table_id, null)
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = try(aws_vpc.this[0].instance_tenancy, null)
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = try(aws_vpc.this[0].enable_dns_support, null)
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = try(aws_vpc.this[0].enable_dns_hostnames, null)
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = try(aws_vpc.this[0].main_route_table_id, null)
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = try(aws_vpc.this[0].ipv6_association_id, null)
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = try(aws_vpc.this[0].ipv6_cidr_block, null)
}

output "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC"
  value       = compact(aws_vpc_ipv4_cidr_block_association.this[*].cidr_block)
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.this[0].owner_id, null)
}

output "vpc_block_public_access_exclusions" {
  description = "A map of VPC block public access exclusions"
  value       = { for k, v in aws_vpc_block_public_access_exclusion.this : k => v.id }
}

################################################################################
# DHCP Options Set
################################################################################

output "dhcp_options_id" {
  description = "The ID of the DHCP options"
  value       = try(aws_vpc_dhcp_options.this[0].id, null)
}

################################################################################
# Internet Gateway
################################################################################

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].id, null)
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.this[0].arn, null)
}

################################################################################
# Publiс Subnets
################################################################################

output "public_subnet_objects" {
  description = "A list of all public subnets, containing the full objects."
  value       = aws_subnet.public
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.public[*].ipv6_cidr_block)
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = local.public_route_table_ids
}

output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route"
  value       = try(aws_route.public_internet_gateway[0].id, null)
}

output "public_internet_gateway_ipv6_route_id" {
  description = "ID of the IPv6 internet gateway route"
  value       = try(aws_route.public_internet_gateway_ipv6[0].id, null)
}

output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = aws_route_table_association.public[*].id
}

output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = try(aws_network_acl.public[0].id, null)
}

output "public_network_acl_arn" {
  description = "ARN of the public network ACL"
  value       = try(aws_network_acl.public[0].arn, null)
}

################################################################################
# Private Subnets
################################################################################

output "private_subnet_objects" {
  description = "A list of all private subnets, containing the full objects."
  value       = aws_subnet.private
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private[*].cidr_block)
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.private[*].ipv6_cidr_block)
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = local.private_route_table_ids
}

output "private_nat_gateway_route_ids" {
  description = "List of IDs of the private nat gateway route"
  value       = aws_route.private_nat_gateway[*].id
}

output "private_ipv6_egress_route_ids" {
  description = "List of IDs of the ipv6 egress route"
  value       = aws_route.private_ipv6_egress[*].id
}

output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = aws_route_table_association.private[*].id
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = try(aws_network_acl.private[0].id, null)
}

output "private_network_acl_arn" {
  description = "ARN of the private network ACL"
  value       = try(aws_network_acl.private[0].arn, null)
}

################################################################################
# Outpost Subnets
################################################################################

output "outpost_subnet_objects" {
  description = "A list of all outpost subnets, containing the full objects."
  value       = aws_subnet.outpost
}

output "outpost_subnets" {
  description = "List of IDs of outpost subnets"
  value       = aws_subnet.outpost[*].id
}

output "outpost_subnet_arns" {
  description = "List of ARNs of outpost subnets"
  value       = aws_subnet.outpost[*].arn
}

output "outpost_subnets_cidr_blocks" {
  description = "List of cidr_blocks of outpost subnets"
  value       = compact(aws_subnet.outpost[*].cidr_block)
}

output "outpost_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of outpost subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.outpost[*].ipv6_cidr_block)
}

output "outpost_network_acl_id" {
  description = "ID of the outpost network ACL"
  value       = try(aws_network_acl.outpost[0].id, null)
}

output "outpost_network_acl_arn" {
  description = "ARN of the outpost network ACL"
  value       = try(aws_network_acl.outpost[0].arn, null)
}

################################################################################
# Database Subnets
################################################################################

output "database_subnet_objects" {
  description = "A list of all database subnets, containing the full objects."
  value       = aws_subnet.database
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = aws_subnet.database[*].id
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = aws_subnet.database[*].arn
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = compact(aws_subnet.database[*].cidr_block)
}

output "database_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.database[*].ipv6_cidr_block)
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = try(aws_db_subnet_group.database[0].id, null)
}

output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value       = try(aws_db_subnet_group.database[0].name, null)
}

output "database_route_table_ids" {
  description = "List of IDs of database route tables"
  # Refer to https://github.com/terraform-aws-modules/terraform-aws-vpc/pull/926 before changing logic
  value = length(aws_route_table.database[*].id) > 0 ? aws_route_table.database[*].id : aws_route_table.private[*].id
}

output "database_internet_gateway_route_id" {
  description = "ID of the database internet gateway route"
  value       = try(aws_route.database_internet_gateway[0].id, null)
}

output "database_nat_gateway_route_ids" {
  description = "List of IDs of the database nat gateway route"
  value       = aws_route.database_nat_gateway[*].id
}

output "database_ipv6_egress_route_id" {
  description = "ID of the database IPv6 egress route"
  value       = try(aws_route.database_ipv6_egress[0].id, null)
}

output "database_route_table_association_ids" {
  description = "List of IDs of the database route table association"
  value       = aws_route_table_association.database[*].id
}

output "database_network_acl_id" {
  description = "ID of the database network ACL"
  value       = try(aws_network_acl.database[0].id, null)
}

output "database_network_acl_arn" {
  description = "ARN of the database network ACL"
  value       = try(aws_network_acl.database[0].arn, null)
}

################################################################################
# Redshift Subnets
################################################################################

output "redshift_subnet_objects" {
  description = "A list of all redshift subnets, containing the full objects."
  value       = aws_subnet.redshift
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = aws_subnet.redshift[*].id
}

output "redshift_subnet_arns" {
  description = "List of ARNs of redshift subnets"
  value       = aws_subnet.redshift[*].arn
}

output "redshift_subnets_cidr_blocks" {
  description = "List of cidr_blocks of redshift subnets"
  value       = compact(aws_subnet.redshift[*].cidr_block)
}

output "redshift_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of redshift subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.redshift[*].ipv6_cidr_block)
}

output "redshift_subnet_group" {
  description = "ID of redshift subnet group"
  value       = try(aws_redshift_subnet_group.redshift[0].id, null)
}

output "redshift_route_table_ids" {
  description = "List of IDs of redshift route tables"
  value       = length(local.redshift_route_table_ids) > 0 ? local.redshift_route_table_ids : (var.enable_public_redshift ? local.public_route_table_ids : local.private_route_table_ids)
}

output "redshift_route_table_association_ids" {
  description = "List of IDs of the redshift route table association"
  value       = aws_route_table_association.redshift[*].id
}

output "redshift_public_route_table_association_ids" {
  description = "List of IDs of the public redshift route table association"
  value       = aws_route_table_association.redshift_public[*].id
}

output "redshift_network_acl_id" {
  description = "ID of the redshift network ACL"
  value       = try(aws_network_acl.redshift[0].id, null)
}

output "redshift_network_acl_arn" {
  description = "ARN of the redshift network ACL"
  value       = try(aws_network_acl.redshift[0].arn, null)
}

################################################################################
# Elasticache Subnets
################################################################################

output "elasticache_subnet_objects" {
  description = "A list of all elasticache subnets, containing the full objects."
  value       = aws_subnet.elasticache
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = aws_subnet.elasticache[*].id
}

output "elasticache_subnet_arns" {
  description = "List of ARNs of elasticache subnets"
  value       = aws_subnet.elasticache[*].arn
}

output "elasticache_subnets_cidr_blocks" {
  description = "List of cidr_blocks of elasticache subnets"
  value       = compact(aws_subnet.elasticache[*].cidr_block)
}

output "elasticache_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of elasticache subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.elasticache[*].ipv6_cidr_block)
}

output "elasticache_subnet_group" {
  description = "ID of elasticache subnet group"
  value       = try(aws_elasticache_subnet_group.elasticache[0].id, null)
}

output "elasticache_subnet_group_name" {
  description = "Name of elasticache subnet group"
  value       = try(aws_elasticache_subnet_group.elasticache[0].name, null)
}

output "elasticache_route_table_ids" {
  description = "List of IDs of elasticache route tables"
  value       = try(coalescelist(aws_route_table.elasticache[*].id, local.private_route_table_ids), [])
}

output "elasticache_route_table_association_ids" {
  description = "List of IDs of the elasticache route table association"
  value       = aws_route_table_association.elasticache[*].id
}

output "elasticache_network_acl_id" {
  description = "ID of the elasticache network ACL"
  value       = try(aws_network_acl.elasticache[0].id, null)
}

output "elasticache_network_acl_arn" {
  description = "ARN of the elasticache network ACL"
  value       = try(aws_network_acl.elasticache[0].arn, null)
}

################################################################################
# Intra Subnets
################################################################################

output "intra_subnet_objects" {
  description = "A list of all intra subnets, containing the full objects."
  value       = aws_subnet.intra
}

output "intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = aws_subnet.intra[*].id
}

output "intra_subnet_arns" {
  description = "List of ARNs of intra subnets"
  value       = aws_subnet.intra[*].arn
}

output "intra_subnets_cidr_blocks" {
  description = "List of cidr_blocks of intra subnets"
  value       = compact(aws_subnet.intra[*].cidr_block)
}

output "intra_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of intra subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.intra[*].ipv6_cidr_block)
}

output "intra_route_table_ids" {
  description = "List of IDs of intra route tables"
  value       = aws_route_table.intra[*].id
}

output "intra_route_table_association_ids" {
  description = "List of IDs of the intra route table association"
  value       = aws_route_table_association.intra[*].id
}

output "intra_network_acl_id" {
  description = "ID of the intra network ACL"
  value       = try(aws_network_acl.intra[0].id, null)
}

output "intra_network_acl_arn" {
  description = "ARN of the intra network ACL"
  value       = try(aws_network_acl.intra[0].arn, null)
}

################################################################################
# NAT Gateway
################################################################################

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat[*].id
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = var.reuse_nat_ips ? var.external_nat_ips : aws_eip.nat[*].public_ip
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.this[*].id
}

output "natgw_interface_ids" {
  description = "List of Network Interface IDs assigned to NAT Gateways"
  value       = aws_nat_gateway.this[*].network_interface_id
}

################################################################################
# Egress Only Gateway
################################################################################

output "egress_only_internet_gateway_id" {
  description = "The ID of the egress only Internet Gateway"
  value       = try(aws_egress_only_internet_gateway.this[0].id, null)
}

################################################################################
# Customer Gateway
################################################################################

output "cgw_ids" {
  description = "List of IDs of Customer Gateway"
  value       = [for k, v in aws_customer_gateway.this : v.id]
}

output "cgw_arns" {
  description = "List of ARNs of Customer Gateway"
  value       = [for k, v in aws_customer_gateway.this : v.arn]
}

output "this_customer_gateway" {
  description = "Map of Customer Gateway attributes"
  value       = aws_customer_gateway.this
}

################################################################################
# VPN Gateway
################################################################################

output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value       = try(aws_vpn_gateway.this[0].id, aws_vpn_gateway_attachment.this[0].vpn_gateway_id, null)
}

output "vgw_arn" {
  description = "The ARN of the VPN Gateway"
  value       = try(aws_vpn_gateway.this[0].arn, null)
}

################################################################################
# Default VPC
################################################################################

output "default_vpc_id" {
  description = "The ID of the Default VPC"
  value       = try(aws_default_vpc.this[0].id, null)
}

output "default_vpc_arn" {
  description = "The ARN of the Default VPC"
  value       = try(aws_default_vpc.this[0].arn, null)
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the Default VPC"
  value       = try(aws_default_vpc.this[0].cidr_block, null)
}

output "default_vpc_default_security_group_id" {
  description = "The ID of the security group created by default on Default VPC creation"
  value       = try(aws_default_vpc.this[0].default_security_group_id, null)
}

output "default_vpc_default_network_acl_id" {
  description = "The ID of the default network ACL of the Default VPC"
  value       = try(aws_default_vpc.this[0].default_network_acl_id, null)
}

output "default_vpc_default_route_table_id" {
  description = "The ID of the default route table of the Default VPC"
  value       = try(aws_default_vpc.this[0].default_route_table_id, null)
}

output "default_vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within Default VPC"
  value       = try(aws_default_vpc.this[0].instance_tenancy, null)
}

output "default_vpc_enable_dns_support" {
  description = "Whether or not the Default VPC has DNS support"
  value       = try(aws_default_vpc.this[0].enable_dns_support, null)
}

output "default_vpc_enable_dns_hostnames" {
  description = "Whether or not the Default VPC has DNS hostname support"
  value       = try(aws_default_vpc.this[0].enable_dns_hostnames, null)
}

output "default_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with the Default VPC"
  value       = try(aws_default_vpc.this[0].main_route_table_id, null)
}

################################################################################
# VPC Flow Log
################################################################################

output "vpc_flow_log_id" {
  description = "The ID of the Flow Log resource"
  value       = try(aws_flow_log.this[0].id, null)
}

output "vpc_flow_log_destination_arn" {
  description = "The ARN of the destination for VPC Flow Logs"
  value       = local.flow_log_destination_arn
}

output "vpc_flow_log_destination_type" {
  description = "The type of the destination for VPC Flow Logs"
  value       = var.flow_log_destination_type
}

output "vpc_flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
  value       = local.flow_log_iam_role_arn
}

output "vpc_flow_log_deliver_cross_account_role" {
  description = "The ARN of the IAM role used when pushing logs cross account"
  value       = try(aws_flow_log.this[0].deliver_cross_account_role, null)
}

################################################################################
# Static values (arguments)
################################################################################

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}



# EKS outputs 
################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = try(aws_eks_cluster.this[0].arn, null)

  depends_on = [
    aws_eks_access_entry.this,
    aws_eks_access_policy_association.this,
  ]
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = try(aws_eks_cluster.this[0].certificate_authority[0].data, null)

  depends_on = [
    aws_eks_access_entry.this,
    aws_eks_access_policy_association.this,
  ]
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = try(aws_eks_cluster.this[0].endpoint, null)

  depends_on = [
    aws_eks_access_entry.this,
    aws_eks_access_policy_association.this,
  ]
}

output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  value       = try(aws_eks_cluster.this[0].cluster_id, "")
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = try(aws_eks_cluster.this[0].name, "")

  depends_on = [
    aws_eks_access_entry.this,
    aws_eks_access_policy_association.this,
  ]
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = try(aws_eks_cluster.this[0].identity[0].oidc[0].issuer, null)
}

output "cluster_dualstack_oidc_issuer_url" {
  description = "Dual-stack compatible URL on the EKS cluster for the OpenID Connect identity provider"
  # https://github.com/aws/containers-roadmap/issues/2038#issuecomment-2278450601
  value = try(replace(replace(aws_eks_cluster.this[0].identity[0].oidc[0].issuer, "https://oidc.eks.", "https://oidc-eks."), ".amazonaws.com/", ".api.aws/"), null)
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = try(aws_eks_cluster.this[0].version, null)
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = try(aws_eks_cluster.this[0].platform_version, null)
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = try(aws_eks_cluster.this[0].status, null)
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = try(aws_eks_cluster.this[0].vpc_config[0].cluster_security_group_id, null)
}

output "cluster_service_cidr" {
  description = "The CIDR block where Kubernetes pod and service IP addresses are assigned from"
  value       = var.ip_family == "ipv6" ? try(aws_eks_cluster.this[0].kubernetes_network_config[0].service_ipv6_cidr, null) : try(aws_eks_cluster.this[0].kubernetes_network_config[0].service_ipv4_cidr, null)
}

output "cluster_ip_family" {
  description = "The IP family used by the cluster (e.g. `ipv4` or `ipv6`)"
  value       = try(aws_eks_cluster.this[0].kubernetes_network_config[0].ip_family, null)
}

output "cluster_control_plane_scaling_tier" {
  description = "The EKS Provisioned Control Plane scaling tier for the cluster"
  value       = try(aws_eks_cluster.this[0].control_plane_scaling_config[0].tier, null)
}

################################################################################
# Access Entry
################################################################################

output "access_entries" {
  description = "Map of access entries created and their attributes"
  value       = aws_eks_access_entry.this
}

output "access_policy_associations" {
  description = "Map of eks cluster access policy associations created and their attributes"
  value       = aws_eks_access_policy_association.this
}

################################################################################
# KMS Key
################################################################################

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.kms.key_arn
}

output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms.key_id
}

output "kms_key_policy" {
  description = "The IAM resource policy set on the key"
  value       = module.kms.key_policy
}

################################################################################
# Cluster Security Group
################################################################################

output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group"
  value       = try(aws_security_group.cluster[0].arn, null)
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group"
  value       = try(aws_security_group.cluster[0].id, null)
}

################################################################################
# Node Security Group
################################################################################

output "node_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the node shared security group"
  value       = try(aws_security_group.node[0].arn, null)
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = try(aws_security_group.node[0].id, null)
}

################################################################################
# IRSA
################################################################################

output "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  value       = try(replace(aws_eks_cluster.this[0].identity[0].oidc[0].issuer, "https://", ""), null)
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = try(aws_iam_openid_connect_provider.oidc_provider[0].arn, null)
}

output "cluster_tls_certificate_sha1_fingerprint" {
  description = "The SHA1 fingerprint of the public key of the cluster's certificate"
  value       = try(data.tls_certificate.this[0].certificates[0].sha1_fingerprint, null)
}

################################################################################
# IAM Role
################################################################################

output "cluster_iam_role_name" {
  description = "Cluster IAM role name"
  value       = try(aws_iam_role.this[0].name, null)
}

output "cluster_iam_role_arn" {
  description = "Cluster IAM role ARN"
  value       = try(aws_iam_role.this[0].arn, null)
}

output "cluster_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.this[0].unique_id, null)
}

################################################################################
# EKS Auto Node IAM Role
################################################################################

output "node_iam_role_name" {
  description = "EKS Auto node IAM role name"
  value       = try(aws_iam_role.eks_auto[0].name, null)
}

output "node_iam_role_arn" {
  description = "EKS Auto node IAM role ARN"
  value       = try(aws_iam_role.eks_auto[0].arn, null)
}

output "node_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = try(aws_iam_role.eks_auto[0].unique_id, null)
}

################################################################################
# EKS Addons
################################################################################

output "cluster_addons" {
  description = "Map of attribute maps for all EKS cluster addons enabled"
  value       = merge(aws_eks_addon.this, aws_eks_addon.before_compute)
}

################################################################################
# EKS Identity Provider
################################################################################

output "cluster_identity_providers" {
  description = "Map of attribute maps for all EKS identity providers enabled"
  value       = aws_eks_identity_provider_config.this
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = try(aws_cloudwatch_log_group.this[0].name, null)
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = try(aws_cloudwatch_log_group.this[0].arn, null)
}

################################################################################
# Fargate Profile
################################################################################

output "fargate_profiles" {
  description = "Map of attribute maps for all EKS Fargate Profiles created"
  value       = module.fargate_profile
}

################################################################################
# EKS Managed Node Group
################################################################################

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.eks_managed_node_group
}

output "eks_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by EKS managed node groups"
  value       = compact(flatten([for group in module.eks_managed_node_group : group.node_group_autoscaling_group_names]))
}

################################################################################
# Self Managed Node Group
################################################################################

output "self_managed_node_groups" {
  description = "Map of attribute maps for all self managed node groups created"
  value       = module.self_managed_node_group
}

output "self_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by self-managed node groups"
  value       = compact([for group in module.self_managed_node_group : group.autoscaling_group_name])
}

# ECR outoputs 

################################################################################
# Repository (Public and Private)
################################################################################

output "repository_name" {
  description = "Name of the repository"
  value       = try(aws_ecr_repository.this[0].name, aws_ecrpublic_repository.this[0].id, null)
}

output "repository_arn" {
  description = "Full ARN of the repository"
  value       = try(aws_ecr_repository.this[0].arn, aws_ecrpublic_repository.this[0].arn, null)
}

output "repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = try(aws_ecr_repository.this[0].registry_id, aws_ecrpublic_repository.this[0].registry_id, null)
}

output "repository_url" {
  description = "The URL of the repository"
  value       = try(aws_ecr_repository.this[0].repository_url, aws_ecrpublic_repository.this[0].repository_uri, null)
}