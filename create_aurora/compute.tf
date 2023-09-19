resource "aws_security_group" "ec2_security_group" {
  name        = "my-security-group"
  description = "My security group for EC2 instance"

  vpc_id = aws_vpc.aurora.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_instance" "bastion_host" {
  ami                    = "ami-04cb4ca688797756f"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
}