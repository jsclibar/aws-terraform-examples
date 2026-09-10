# O arquivo define a role e o instance profile para as instâncias EC2. 
# A role é necessária para que as instâncias possam assumir permissões específicas, 
# como acessar o SSM (AWS Systems Manager) para gerenciamento 
# remoto e execução de patching.

# Nesse trecho está sendo criada a trust policy que permite que a role 
# seja assumida por instâncias EC2.

# O data 'aws_iam_policy_document' é usado para gerar o documento JSON da trust policy,
# que é então referenciado na criação da role.

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Aqui está sendo criado o instance profile, que é um contêiner para a role.
# Na interface gráfica da AWS, não criamos o Instance Profile diretamente, 
# mas sim a Role, e o Instance Profile é criado automaticamente.

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.ec2_resources.instance_profile
  role = var.ec2_resources.instance_role
}

# Aqui que efetivamente criada a role do IAM que será associada ao instance profile.

resource "aws_iam_role" "instance_role" {
  name               = var.ec2_resources.instance_role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}