# Esse arquivo define as saídas (outputs) do módulo de rede, que podem ser usadas por outros módulos ou recursos que dependem da VPC e seus componentes.

output "vpc_id" {
  value = aws_vpc.this.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "nat_eip" {
  value = aws_eip.this.public_ip
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this[*].id
}

output "public_subnet_id" {
  value = aws_subnet.public[*].id
}

output "private_subnets_ids" {
  value = aws_subnet.private[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}