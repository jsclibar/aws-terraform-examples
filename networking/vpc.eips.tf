# Esse arquivo define o recurso de Elastic IP (EIP) que será associado ao NAT Gateway da VPC. 
# O EIP é um endereço IP público estático que pode ser associado a instâncias EC2 ou NAT Gateways, permitindo que eles tenham um endereço IP fixo na internet.


# Cria um Elastic IP (EIP) para o NAT Gateway da VPC.

resource "aws_eip" "this" {
  domain = "vpc"

  # Aqui estamos concatenando o nome da VPC com o nome do EIP para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome do EIP será: <nome da VPC>-<nome do EIP>-<zona de disponibilidade da subnet pública>
  # [0] é usado para pegar a primeira subnet pública da lista de subnets públicas, pois o NAT Gateway será criado nessa subnet.

  tags = { Name = "${var.vpc.name}-${var.vpc.eip_name}-${aws_subnet.public[0].availability_zone}" }
}


# Aqui temos um exemplo de como criar múltiplos EIPs, um para cada subnet pública da VPC.

/* 

resource "aws_eip" "nat_gateway" {
  count  = length(aws_subnet.public)
  domain = "vpc"

  tags = { Name = "${var.vpc.name}-${var.vpc.eip_name}-${aws_subnet.public[count.index].availability_zone}" }
}

*/