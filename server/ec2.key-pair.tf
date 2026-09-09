# Gera uma chave privada local durante o apply.
# A chave pública derivada dela é enviada para a AWS no recurso `aws_key_pair`.
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Registra na AWS a chave pública que poderá ser usada pelas instâncias EC2.
resource "aws_key_pair" "this" {
  key_name   = var.ec2_resources.key_pair_name
  public_key = tls_private_key.this.public_key_openssh
  tags       = merge(var.tags, { Name = var.ec2_resources.key_pair_name })
}