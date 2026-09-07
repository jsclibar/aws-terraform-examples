# Esse arquivo define o recurso de NAT Gateway que será criado na VPC. 
# O NAT Gateway é um serviço gerenciado da AWS que permite que instâncias em subnets privadas se comuniquem com a internet, 
# enquanto mantém essas instâncias privadas e não acessíveis diretamente da internet.

resource "aws_nat_gateway" "this" {

  allocation_id = aws_eip.this.id
  subnet_id     = aws_subnet.public[0].id # Aqui estamos associando o NAT Gateway à primeira subnet pública da lista de subnets públicas da VPC.

  # Aqui estamos concatenando o nome da VPC com o nome do NAT Gateway e a zona de disponibilidade da primeira subnet pública para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome do NAT Gateway será: <nome da VPC>-<nome do NAT Gateway>-<zona de disponibilidade da primeira subnet pública>

  tags = { Name = "${var.vpc.name}-${var.vpc.nat_gateway_name}-${aws_subnet.public[0].availability_zone}" }

  # O depends_on garante que o NAT Gateway só será criado após a criação do Internet Gateway, pois o NAT Gateway depende do Internet Gateway para funcionar corretamente.

  depends_on = [aws_internet_gateway.this]
}

# Aqui temos um exemplo de como criar múltiplos NAT Gateways, um para cada subnet pública da VPC.

/*

resource "aws_nat_gateway" "this" {
  count = length(aws_subnet.public)

  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = { Name = "${var.vpc.name}-${var.vpc.nat_gateway_name}-${aws_subnet.public[count.index].availability_zone}" }

  depends_on = [aws_internet_gateway.this]
}

*/