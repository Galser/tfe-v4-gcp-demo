output "instance_id" {
  value = aws_instance.ptfe.id
}

output "public_ip" {
  value = aws_instance.ptfe.public_ip
}