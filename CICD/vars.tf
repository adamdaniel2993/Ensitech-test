variable "environment" {
  type = string
  default = "test"
}

variable "tenant" {
  type = string
  default = "ensitech"
}

variable "vpc_cird_block" {
  type = string
  default = "172.32.0.0/16"
}