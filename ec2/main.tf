resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "WebServer"
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}