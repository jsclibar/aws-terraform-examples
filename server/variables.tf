# Variáveis da stack `networking`.

# Região onde os recursos desta stack serão provisionados.
variable "region" {
  type    = string
  default = "us-east-1"
}


# Variáveis de tags que serão aplicadas a todos os recursos desta stack.
variable "tags" {
  type = map(string)
  default = {
    Name        = "not-so-simple-ecommerce"
    Environment = "production"
  }
}

# Variáveis para a role assumida para provisionar recursos na conta alvo.
variable "assume_role" {
  type = object({
    role_arn    = string
    external_id = string
  })

  default = {
    role_arn    = "arn:aws:iam::637423180547:role/terraform-role"
    external_id = "807b653f-61b7-403a-a2f5-b909b1e4dee2"
  }
}

variable "ec2_resources" {
  # Agrupa nomes dos recursos básicos de EC2/IAM usados em vários arquivos da stack.
  type = object({
    key_pair_name                = string
    instance_profile             = string
    instance_role                = string
    ssh_security_group           = string
    ssh_source_ip                = string
    control_plane_security_group = string
    worker_security_group        = string
  })

  default = {
    key_pair_name                = "nsse-production-key-pair"
    instance_profile             = "nsse-production-instance-profile"
    ssh_security_group           = "allow-ssh"
    ssh_source_ip                = "187.8.87.82/32"
    instance_role                = "nsse-production-instance-role"
    control_plane_security_group = "nsse-production-control-plane-security-group"
    worker_security_group        = "nsse-production-worker-security-group"
  }
}

variable "vpc_resources" {
  type = object({
    vpc = string
  })

  default = {
    vpc = "nsse-vpc"
  }
}