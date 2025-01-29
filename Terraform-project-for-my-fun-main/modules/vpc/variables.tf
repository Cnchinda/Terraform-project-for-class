

################################################################################
# ROOT MODULE
################################################################################

variable "component_name" {
    type = string
    description = "Please enter the name of the component"
}

variable "vpc_cidr" {
    type = string
    description = "vpc cidr for the network"
}

# OP
variable "enable_dns_hostnames" {
    type = bool
    description = "enable dns hostnames"
    default = true
}

# OP
variable "enable_dns_support" {
    type = bool
    description = "enable dns hostnames"
    default = true
}

variable "public_subnetcidr" {
    type = list
    description = "public subnetcidr for the network"
    default = []
}

variable "private_subnetcidr" {
    type = list
    description = "privare subnetcidr for the network"
    default = []
}

variable "database_subnetcidr" {
    type = list
    description = "database subnetcidr for the network"
    default = []
}

variable "availability_zone" {
    type = list
    description = "availability zone for the network"
    default = []
}