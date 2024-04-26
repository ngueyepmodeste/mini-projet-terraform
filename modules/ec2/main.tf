
data "aws_ami" "ubuntu_bionic" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]  # Owner ID for Ubuntu AMIs in AWS
}
resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ubuntu_bionic.id
  instance_type = var.instance_type
  key_name      = var.paire_key
  tags = {
    Name = var.instance_name
  }
  security_groups = [var.sg_name]

  root_block_device {
  delete_on_termination = true
 }
provisioner "local-exec" {
    command = "echo PUBLIC_IP: ${aws_instance.myec2.public_ip}  >> ip_ec2.txt"
  }

  provisioner "remote-exec" {
    inline = [" sudo apt-get update -y", "sudo apt-get upgrate -y", "sudo apt-get install -y nginx" ,
      "sudo systemctl start nginx", "sudo systemctl enable nginx", "sudo systemctl status nginx "
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("./${var.paire_key}.pem")
      host        = self.public_ip
    }
  }

}