variable "region" {
  type        = string
  default     = "eu-west-3"
  description = "Région AWS"
}

variable "my_ip" {
  type        = string
  description = "Ton IP publique au format CIDR (ex. 82.12.34.56/32) : seule autorisée en SSH, API Kubernetes, Grafana et Prometheus"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/blazing-key.pub"
  description = "Chemin de ta clé SSH publique"
}

variable "instances" {
  type = map(string)
  default = {
    control-plane = "t3.medium"
    worker        = "t3.medium"
  }
  description = "Nom de la machine => type d'instance"
}
