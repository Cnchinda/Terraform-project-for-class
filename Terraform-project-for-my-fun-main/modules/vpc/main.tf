
################################################################################
# ROOT MODULE
################################################################################


################################################################################
# LOCALS BLOCK
################################################################################

locals {
  vpc_id = aws_vpc.this.id
}

################################################################################
# CREATING VPC
################################################################################

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames 
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "${var.component_name}-vpc"
  }
}

################################################################################
# CREATING INTERNET GATEWAY
################################################################################

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.component_name}-igw"
  }
}

################################################################################
# CREATING PUBLIC SUBNETS USING COUNT
################################################################################

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnetcidr) # "6"

  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnetcidr[count.index]
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

################################################################################
# CREATING PRIVATE SUBNETS USING COUNT
################################################################################

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnetcidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.private_subnetcidr[count.index]
  availability_zone =  element(var.availability_zone, count.index)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

################################################################################
# CREATING DATABASE SUBNETS USING COUNT
################################################################################

resource "aws_subnet" "database_subnets" {
  count = length(var.database_subnetcidr)

  vpc_id            = local.vpc_id
  cidr_block        = var.database_subnetcidr[count.index]
  availability_zone = element(var.availability_zone, count.index)

  tags = {
    Name = "database-subnet-${count.index + 1}"
  }
}

################################################################################
# CREATING ROUTE TABLES FOR PUBLIC SUBNETS
################################################################################

resource "aws_route_table" "public_routable" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.component_name}-public-rt"
  }
}

################################################################################
# CREATING PUBLIC ROUTE TABLES ASSOCIATED WITH ?
################################################################################

resource "aws_route_table_association" "public_routetable_association" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_routable.id
}

################################################################################
# CREATING DEFAULT ROUTE TABLES 
################################################################################

resource "aws_default_route_table" "defaultroutetable" {

  default_route_table_id = aws_vpc.this.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = try(aws_nat_gateway.this[0].id, "") 
  }
}

################################################################################
# CREATING A NAT GATEWAY
################################################################################ 

resource "aws_nat_gateway" "this" {
 count = length(var.public_subnetcidr) > 0 ? 1 : 0

  depends_on = [aws_internet_gateway.igw]

  allocation_id = try(aws_eip.eip[0].id, "")
  subnet_id     = try(aws_subnet.public_subnet[0].id, "")

  tags = {
    Name = "${var.component_name}-natgateway"
  }
}

################################################################################
# CREATING A AN  ELASTICIP
################################################################################ 

resource "aws_eip" "eip" {
   count = length(var.public_subnetcidr) > 0 ? 1 : 0

  depends_on = [aws_internet_gateway.igw]
  # domain = true

}

