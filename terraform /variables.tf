variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "Debian 12 AMI ID"
  default     = "ami-0779caf41f9ba54f0"  # Debian 12 (Bookworm) in us-east-1
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "Enter a key pair"
}
