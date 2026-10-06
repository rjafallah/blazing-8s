# Dernière AMI Ubuntu 22.04 (éditeur Canonical)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "blazing" {
  key_name   = "blazing-key"
  public_key = file(pathexpand(var.public_key_path))
}

resource "aws_instance" "node" {
  for_each = var.instances

  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value
  key_name                    = aws_key_pair.blazing.key_name
  vpc_security_group_ids      = [aws_security_group.k8s.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "blazing-${each.key}"
    Project = "blazing-8s"
  }
}
