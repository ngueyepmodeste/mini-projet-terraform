output "output_eip_id" {
  value = aws_eip.myeip.id
}
output "output_eip" {
  value = aws_eip.myeip.public_ip
}