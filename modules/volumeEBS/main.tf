resource "aws_ebs_volume" "myvolume" {
  availability_zone = "us-east-1a"  # Remplacez par votre zone de disponibilité
  size              = var.taille_ebs  # Taille en GiB du volume EBS
}