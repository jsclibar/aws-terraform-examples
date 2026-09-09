# Stack responsável pela camada base de rede.
# Ela cria a VPC, as subnets, o internet gateway, os NAT gateways e as rotas.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Backend remoto do Terraform para armazenar o estado da stack de rede e o lock do estado remoto.
  backend "s3" {
    bucket       = "jsclibar-nsse-remote-terraform-state-files"
    key          = "server/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

# Configuração do provider AWS para provisionar os recursos da stack de rede.
provider "aws" {
  region = var.region

  # Configuração de tags padrão que serão aplicadas a todos os recursos da stack de rede.

  default_tags {
    tags = var.tags
  }

  # Configuração da role assumida para provisionar recursos na conta alvo. A role deve ter permissões suficientes para criar os recursos da stack de rede.

  assume_role {
    role_arn    = var.assume_role.role_arn
    external_id = var.assume_role.external_id
  }
}
