# Stack responsável por criar a infraestrutura base do backend remoto do Terraform.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "jsclibar-nsse-remote-terraform-state-files"
    key          = "backend/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
   # Região onde os recursos desta stack serão provisionados.
  region = var.region
    
    default_tags {
    # Essas tags são aplicadas automaticamente aos recursos compatíveis com o provider AWS.
    tags = var.tags
  }
  assume_role {
    # A stack assume uma role para provisionar na conta alvo sem usar credenciais fixas no código.
    role_arn    = var.assume_role.role_arn
    external_id = var.assume_role.external_id
  }
}
