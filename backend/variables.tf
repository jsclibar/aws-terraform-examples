# Variáveis da stack `backend`.
# A ideia é que essas variáveis sejam utilizadas para configurar o backend remoto do Terraform 
#e a role assumida para provisionar recursos na conta alvo. 

# Região onde os recursos desta stack serão provisionados.
variable "region" {
  type    = string
  default = "us-east-1"
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

# Variáveis para as tags aplicadas automaticamente aos recursos compatíveis com o provider AWS.
variable "tags" {
  type = map(string)
  default = {
    "Project"     = "not-so-simple-ecommerce"
    "Environment" = "production"
  }
}

# Variáveis para o backend remoto do Terraform.
variable "remote_backend" {
  type = object({
    bucket = string
  })

  default = {
    bucket = "jsclibar-nsse-remote-terraform-state-files"
  }
}