locals {
  name = "${var.project}-${var.environment}" # trdl-poc

  azs = slice(data.aws_availability_zones.available.names, 0, var.az_count)

  # 10.20.1.0/24, 10.20.2.0/24, ... and 10.20.101.0/24, ...
  private_subnets = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i + 1)]
  public_subnets  = [for i in range(var.az_count) : cidrsubnet(var.vpc_cidr, 8, i + 101)]

  tags = {
    project = var.project
    env     = var.environment
  }
}
