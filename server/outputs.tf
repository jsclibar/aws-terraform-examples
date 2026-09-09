# Expõe a chave privada gerada pelo Terraform.
# O atributo `sensitive = true` evita exibição acidental em saídas padrão.
output "key_pair_private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}