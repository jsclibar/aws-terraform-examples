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

# Este objeto descreve a topologia inteira da VPC:
# nomes, CIDR e listas de subnets públicas/privadas.

variable "vpc" {
  type = object({
    name                     = string
    cidr_block               = string
    internet_gateway_name    = string
    nat_gateway_name         = string
    eip_name                 = string
    public_route_table_name  = string
    private_route_table_name = string

    # Variável que descreve as subnets públicas da VPC em uma lista de objetos. Cada objeto descreve uma subnet pública.

    public_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))

    private_subnets = list(object({
      name                    = string
      cidr_block              = string
      availability_zone       = string
      map_public_ip_on_launch = bool
    }))
  })

  default = {
    name                     = "nsse-vpc"
    cidr_block               = "10.0.0.0/24"
    internet_gateway_name    = "internet-igw"
    nat_gateway_name         = "nat-gateway"
    eip_name                 = "nat-gateway-eip"
    public_route_table_name  = "public-route-table"
    private_route_table_name = "private-route-table"

    # Subnets públicas da VPC. Cada objeto descreve uma subnet pública, com nome, CIDR, zona de disponibilidade e se deve mapear IP público ao ser lançada.
    # Observe que existem duas subnets públicas, uma em cada zona de disponibilidade da região us-east-1. A quantidade de subnets públicas depende apenas da quantidade de objetos declarados nesta lista. 

    public_subnets = [
      {
        name                    = "public-subnet-us-east-1a"
        cidr_block              = "10.0.0.0/27"
        availability_zone       = "us-east-1a"
        map_public_ip_on_launch = true
      },

      {
        name                    = "public-subnet-us-east-1b"
        cidr_block              = "10.0.0.64/27"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = true
      }
    ]

    private_subnets = [{
      name                    = "private-subnet-us-east-1a"
      cidr_block              = "10.0.0.32/27"
      availability_zone       = "us-east-1a"
      map_public_ip_on_launch = false
      },
      {
        name                    = "private-subnet-us-east-1b"
        cidr_block              = "10.0.0.96/27"
        availability_zone       = "us-east-1b"
        map_public_ip_on_launch = false
    }]
  }
}
