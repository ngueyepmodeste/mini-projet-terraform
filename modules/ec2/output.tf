output "output_instance_id" {
  value = aws_instance.myec2.id
}
output "output_public_ip" {
  value = aws_instance.myec2.public_ip
}