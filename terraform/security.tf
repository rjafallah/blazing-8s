# VPC par défaut : il contient déjà un subnet public, une Internet Gateway et la route vers Internet
data "aws_vpc" "default" {
  default = true
}

# ---------- Cluster Kubernetes (control plane + worker) ----------
resource "aws_security_group" "k8s" {
  name        = "blazing-k8s"
  description = "Noeuds Kubernetes"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_vpc_security_group_ingress_rule" "k8s_ssh" {
  security_group_id = aws_security_group.k8s.id
  description       = "SSH depuis mon IP"
  cidr_ipv4         = var.my_ip
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "k8s_api" {
  security_group_id = aws_security_group.k8s.id
  description       = "API Kubernetes depuis mon IP"
  cidr_ipv4         = var.my_ip
  ip_protocol       = "tcp"
  from_port         = 6443
  to_port           = 6443
}

resource "aws_vpc_security_group_ingress_rule" "k8s_nodeport" {
  security_group_id = aws_security_group.k8s.id
  description       = "NodePort de l'application"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 30000
  to_port           = 32767
}

resource "aws_vpc_security_group_ingress_rule" "k8s_internal" {
  security_group_id            = aws_security_group.k8s.id
  description                  = "Trafic entre les noeuds du cluster"
  referenced_security_group_id = aws_security_group.k8s.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_egress_rule" "k8s_all" {
  security_group_id = aws_security_group.k8s.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
