provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  #instance_tenancy = "default"

  tags = {
    Name = "My VPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "Subnet 1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "Subnet 2"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_rta_subnet1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table_association" "public_rta_subnet2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Name = "My IGW"
  }
}

resource "aws_security_group" "load_balancer_sg" {
  name_prefix = "load_balancer_sg"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Load Balancer SG"
  }
}


resource "aws_security_group" "compute_sg" {
  name_prefix = "compute_sg"
  vpc_id      = aws_vpc.my_vpc.id


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Compute SG"
  }
}

resource "aws_instance" "compute1" {
  ami                    = "ami-044415bb13eee2391"
  instance_type          = "t2.micro"
  key_name               = "demok8s"
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.compute_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo service nginx start
              EOF


  tags = {
    Name = "Compute 1"
  }
}

resource "aws_instance" "compute2" {
  ami                    = "ami-044415bb13eee2391"
  instance_type          = "t2.micro"
  key_name               = "demok8s"
  subnet_id              = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.compute_sg.id]
  user_data              = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo service nginx start
              EOF
  tags = {
    Name = "Compute 2"
  }
}

resource "aws_lb" "lb" {
  name               = "my-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]


  tags = {
    Name = "My LB"
  }
}


resource "aws_lb_target_group" "target_group" {
  name_prefix = "group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"


  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }


  tags = {
    Name = "My Target Group"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    target_group_arn = aws_lb_target_group.target_group.arn
    type             = "forward"
  }
}

output "load_balancer_dns_name" {
  value = aws_lb.lb.dns_name
}
