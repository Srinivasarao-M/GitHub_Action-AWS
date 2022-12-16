resource "aws_vpc" "msr_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    Name= "${var.platform_name}-${var.application_name}-${var.Environment}-vpc"
}
  lifecycle {
    prevent_destroy = false
    ignore_changes  = [tags]
  }
}

