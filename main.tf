resource "aws_instance" "demo_ins" {
  ami             = "ami-021aaf3749be66813"
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.demo_key.key_name
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name = "demo-ins"
  }
}

resource "aws_key_pair" "demo_key" {
  key_name   = "demo-key"
  public_key = file("demo-key.pub")
}

resource "aws_default_vpc" "default_vpc" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "demo_sg" {
  name        = "SG-DEMO"
  description = "SG for HTTP, HTTPS and SSH"
  vpc_id      = aws_default_vpc.default_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    description = "ssh sg"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DEMO-SG"
  }
}