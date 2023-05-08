
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-1"  
}

variable "environment" {
  description = "Enviroment Variable used as a prefix"
  type = string
  default = "dev"
}

variable "business_division" {
  description = "Business Division in the large organization this infrastructure belongs"
  type = string
  default = "HR"
}