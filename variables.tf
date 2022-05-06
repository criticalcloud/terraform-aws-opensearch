variable "domain_name" {
    default = ""
}

variable "engine_version" {
    default = "OpenSearch_1.2"
}

variable "instance_type" {
    default = "t3.small.search"
}

variable "instance_count" {
    default = 1
}

variable "master_user_name" {
    default = "admin"
}

variable "master_user_password" {
    default = ""
}

variable "volume_size" {
    default = 30
}

variable "custom_endpoint" {
    default = ""
}

variable "cert_arn" {
  default = ""
}

variable "vpc_name" {
    default = ""
}

variable "subnet_cidr" {
  type = list
  default = [""]
}

variable "tags" {
    type = map
    default = {}
}