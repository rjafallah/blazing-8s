variable "region" {
  type        = string
  default     = "eu-west-3"
  description = "Région AWS"
}

variable "my_ip" {
  type        = string
  description = "mon IP"
}

variable "public_key_path" {
  type        = string
  default     = "~/.ssh/blazing-key.pub"
  description = "Chemin de ta clé SSH publique"
}

variable "instances" {
  type = map(string)
  default = {
    control-plane = "c7i-flex.large"
    worker        = "c7i-flex.large"
  }
  description = "Nom de la machine => type d'instance"
}
