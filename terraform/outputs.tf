output "public_ips" {
  value       = { for name, i in aws_instance.node : name => i.public_ip }
  description = "IP publiques (SSH, accès à l'appli)"
}

output "private_ips" {
  value       = { for name, i in aws_instance.node : name => i.private_ip }
  description = "IP privées (communication entre les noeuds)"
}
