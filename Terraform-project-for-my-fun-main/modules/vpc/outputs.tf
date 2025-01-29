

################################################################################
# ROOT MODULE
################################################################################

output "vpc_id" {
    value = "aws_vpc.this.id"
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id  # Or however you're defining your public subnets
}

output "private_subnets" {
  value = aws_subnet.private_subnets.*.id  # Or however you're defining your public subnets
}

output "database_subnets" {
  value = aws_subnet.database_subnets.*.id  # Or however you're defining your public subnets
}

