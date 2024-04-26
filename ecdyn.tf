provider "aws" {
  region     = "us-east-1"
}
module "ec2" {
  source = "./modules/ec2"
  instance_name = "ec_modeste"
  instance_type = "t1.micro"
  paire_key = "jenkins_key"
  ip_public = module.eip.output_eip
  sg_name = module.security_group.output_sg_name

}

module "security_group" {
  source = "./modules/security_group"
  security_group_name = "my_sg"
}
module "eip" {
  source = "./modules/eip"
}
module "volumeEBS" {
  source = "./modules/volumeEBS"
  taille_ebs = "10"
}
#attachement du volume ebs a l'instance ec2
resource "aws_volume_attachment" "ebs_attachment" {
  device_name = "/dev/sdf"
  instance_id = module.ec2.output_instance_id
  volume_id   = module.volumeEBS.output_vol_id
}
# Association du groupe de sécurité à l'EIP
resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2.output_instance_id
  allocation_id = module.eip.output_eip_id

}
