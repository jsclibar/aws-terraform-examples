# Esse arquivo é responsável por buscar a VPC existente na AWS com base no 
# nome fornecido na variável vpc_resources.vpc. 
# Ele utiliza o recurso data "aws_vpc" para filtrar a VPC pelo nome da tag "Name".
# O resultado é armazenado no objeto data.aws_vpc.this, 
# que pode ser usado em outros recursos do Terraform para referenciar a VPC existente.

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_resources.vpc]
  }
}