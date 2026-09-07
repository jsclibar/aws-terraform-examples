# Recurso raiz da rede.
# Todos os demais recursos da stack dependem direta ou indiretamente desta VPC.

resource "aws_vpc" "this" {
  cidr_block = var.vpc.cidr_block

  tags = { Name = var.vpc.name }
}