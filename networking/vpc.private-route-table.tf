# Esse arquivo define a tabela de rotas privada da VPC. 
# A tabela de rotas privada é responsável por direcionar o tráfego de saída das subnets privadas da VPC para a internet através do NAT Gateway associado à VPC.


resource "aws_route_table" "private" {

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  # Aqui estamos concatenando o nome da VPC com o nome da tabela de rotas privada e a zona de disponibilidade da subnet privada para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome da tabela de rotas privada será: <nome da VPC>-<nome da tabela de rotas privada>-<zona de disponibilidade da subnet privada>

  tags = { Name = "${var.vpc.name}-${var.vpc.private_route_table_name}" }
}

# Aqui uso o count para criar uma associação entre cada subnet privada e a tabela de rotas privada.
# Note que o count percorre a lista de subnets privadas criadas no recurso aws_subnet.private, então a quantidade de associações depende apenas da quantidade de subnets privadas.

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Aqui trabalhamos com dois NAT Gateways, um para cada subnet pública da VPC. 
# Cada NAT Gateway será associado a uma tabela de rotas privada, e cada tabela de rotas privada terá uma rota padrão apontando para o NAT Gateway correspondente.

/*

resource "aws_route_table" "private" {
  count = length(aws_subnet.private)

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = { Name = "${var.vpc.name}-${var.vpc.private_route_table_name}-${aws_subnet.private[count.index].availability_zone}" }
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

*/ 