variable "instance_type" {
  type        = string
  description = "definit le type d'instance utilisé"
}
variable "instance_name" {
  type    = string
  description = "definition du nom de notre instance ec2_module"
}
variable "sg_name" {
  type = string
}
variable "paire_key" {
  type = string
  description = "paire de clé pour se connecter par ssh à mon EC2"
}
variable "ip_public" {
  type = string
  default = "ip public de mon instance ec2"
}