# Internet Gateway dá saída direta para a internet às subnets que apontam rota para ele.
# Neste projeto, ele é usado apenas pela route table pública.

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  # Aqui estamos concatenando o nome da VPC com o nome do IGW para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome do IGW será: <nome da VPC>-<nome do IGW>.

  tags = { Name = "${var.vpc.name}-${var.vpc.internet_gateway_name}" }
}