variable "region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-north-1"
}

variable "project" {
  description = "Project name, used as a prefix for resource names"
  type        = string
  default     = "trdl"
}

variable "environment" {
  description = "Environment name. Also the GitHub environment name the deploy job uses."
  type        = string
  default     = "poc"
}

variable "github_repo" {
  description = "GitHub OIDC subject part, copied from the debug workflow output"
  type        = string

  validation {
    condition     = can(regex("/", var.github_repo))
    error_message = "github_repo must look like OWNER/REPO (or the OWNER@ID/REPO@ID form)."
  }
}

variable "cluster_version" {
  description = "EKS Kubernetes version. Use one in STANDARD_SUPPORT."
  type        = string

  validation {
    condition     = can(regex("^1\\.[0-9]+$", var.cluster_version))
    error_message = "cluster_version must look like 1.37, never a placeholder."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use"
  type        = number
  default     = 3
}

variable "single_nat_gateway" {
  description = "One shared NAT gateway (cheap, PoC) or one per AZ (production)"
  type        = bool
  default     = true
}

variable "node_instance_types" {
  description = "Worker instance types. Must be allowed by the account plan."
  type        = list(string)
  default     = ["t3.small"]
}

variable "node_min_size" {
  type    = number
  default = 3
}

variable "node_max_size" {
  type    = number
  default = 6
}

variable "node_desired_size" {
  type    = number
  default = 3
}

variable "ci_namespace" {
  description = "Kubernetes namespace the pipeline may edit"
  type        = string
  default     = "default"
}
