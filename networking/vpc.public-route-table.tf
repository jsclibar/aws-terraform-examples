# Este arquivo define a tabela de rotas pública da VPC. 
# A tabela de rotas pública é responsável por direcionar o tráfego de saída da VPC para a internet através do gateway de internet (Internet Gateway) associado à VPC.

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  # Aqui estamos concatenando o nome da VPC com o nome da tabela de rotas pública para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome da tabela de rotas pública será: <nome da VPC>-<nome da tabela de rotas pública>.

  tags = { Name = "${var.vpc.name}-${var.vpc.public_route_table_name}" }
}

# Aqui uso o count para criar uma associação entre cada subnet pública e a tabela de rotas pública.
# Note que o count percorre a lista de subnets públicas criadas no recurso aws_subnet.public, então a quantidade de associações depende apenas da quantidade de subnets públicas.

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}