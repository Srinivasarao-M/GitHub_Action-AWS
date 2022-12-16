variable "platform_name" {
    default = "aws"
}

variable "Environment" {
    default = "dev"
}

variable "account" {
    default = "msr"
}

variable "application_name" {
    default = "msr-app"
}

variable "app_id" {
    default = "msr-app-dev"
}

variable "owner" {
    default = "MSR"
}

variable "enable_deletion_protection" {
  default = true
}

variable "region" {
    default = "us-east-1"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "availability_zone" {
    type    = list
    default = ["us-east-1a","us-east-1b"]
}

variable "web_public_subnet_names" {
    type    = list
    default = ["web_subnet_1a","web_subnet_1b"]
}

variable "web_public_subnet_cidr" {
    type    = list
    default = ["10.0.0.0/24","10.0.1.0/24"]
}

variable "app_private_subnet_names" {
    type    = list
    default = ["app_subnet_1a","app_subnet_1b"]
}

variable "app_private_subnet_cidr" {
    type    = list
    default = ["10.0.2.0/24","10.0.3.0/24"]
}