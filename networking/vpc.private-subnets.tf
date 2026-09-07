# Cria as subnets privadas da VPC.
# O `count` percorre a lista `var.vpc.private_subnets`, então a quantidade de subnets 
# depende apenas da quantidade de itens declarados na variável.

resource "aws_subnet" "private" {
  count = length(var.vpc.private_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.vpc.private_subnets[count.index].cidr_block
  availability_zone       = var.vpc.private_subnets[count.index].availability_zone
  map_public_ip_on_launch = var.vpc.private_subnets[count.index].map_public_ip_on_launch

  # Aqui estamos concatenando o nome da VPC com o nome da subnet para gerar o nome do recurso.
  # Seguindo o que foi definido nas variáveis, o nome da subnet será: <nome da VPC>-<nome da subnet>.

  tags = { Name = "${var.vpc.name}-${var.vpc.private_subnets[count.index].name}" }
}