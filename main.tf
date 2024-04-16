provider "aws" {
    region = "us-east-1"
    access_key = ""
    secret_key = ""
}


############################################# Step1: Networking ################################################

# Renaming default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "HC VPC"
  }
}

# Create public subnet in az-1a
resource "aws_subnet" "PubSub" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.100.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet-tf"
  }
}

# Create private subnet A in az-1a
resource "aws_subnet" "PRVSubA" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.150.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "PrivateSubnetA-tf"
  }
}

# Create private subnet B in az-1b (HA)
resource "aws_subnet" "PRVSubB" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.200.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "PrivateSubnetB-tf"
  }
}

# Create public route table for external traffic
resource "aws_route_table" "PubRT" {
  vpc_id = aws_default_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0ca98738c84ef448c"
  }

  tags = {
    Name = "PublicRouteTable-tf"
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "b" {
  subnet_id = aws_subnet.PubSub.id
  route_table_id = aws_route_table.PubRT.id
}

# Create private route table for web severs traffic
resource "aws_route_table" "PRVRT" {
  vpc_id = aws_default_vpc.default.id

  tags = {
    Name = "PrivateRouteTable-tf"
  }
}

resource "aws_route" "example" {
  route_table_id            = aws_route_table.PRVRT.id
  destination_cidr_block    = "0.0.0.0/0"  # The CIDR block for which you want to route traffic
  network_interface_id      = aws_network_interface.port2.id
}

# Associate private subnet A & B with pprivate route table
resource "aws_route_table_association" "a" {
  subnet_id = aws_subnet.PRVSubA.id 
  route_table_id = aws_route_table.PRVRT.id
}

resource "aws_route_table_association" "c" {
  subnet_id = aws_subnet.PRVSubB.id 
  route_table_id = aws_route_table.PRVRT.id
}


############################################# Step2: Infrastructure ################################################

# Create Web App security group
resource "aws_security_group" "WebApp-sg" {
 name        = "WebApp-sg-tf"
 description = "Allow traffic to web server"
 vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Database traffic"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 tags = {
    Name = "WebApp-sg-tf"
 }
}

# Create Fortigate security group
resource "aws_security_group" "FG-sg" {
 name        = "FG-sg-tf"
 description = "Allow traffic to fortigate"
 vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 541
    to_port     = 541
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "FG-sg-tf"
  }
}


# Create network interface
## Port1 interface of fortigate
resource "aws_network_interface" "port1" {
  subnet_id       = aws_subnet.PubSub.id
  private_ips     = ["172.31.100.207"]
  security_groups = [aws_security_group.WebApp-sg.id, aws_security_group.FG-sg.id]
  source_dest_check = false

  tags = {
    Name = "port1"
  }
}

## Port2 interface of Fortigate
resource "aws_network_interface" "port2" {
  subnet_id       = aws_subnet.PRVSubA.id
  private_ips     = ["172.31.150.10"]
  security_groups = [aws_security_group.WebApp-sg.id, aws_security_group.FG-sg.id]
  source_dest_check = false

  tags = {
    Name = "port2"
  }
}

# ENI for Docker "WebApp" EC2
resource "aws_network_interface" "WebApp-ENI" {
  subnet_id       = aws_subnet.PRVSubA.id
  private_ips     = ["172.31.150.100"]
  security_groups = [aws_security_group.WebApp-sg.id]

  tags = {
    Name = "WebApp-ENI"
  }
}

# Elastic ip association for port1 interface
resource "aws_eip" "EIP" {
  vpc = true
  
}

resource "aws_eip_association" "a" {
  network_interface_id = aws_network_interface.port1.id
  allocation_id = aws_eip.EIP.id
}

# Create fortigate EC2
resource "aws_instance" "fgt" {
  //it will use region, architect, and license type to decide which ami to use for deployment
  ami               = "ami-025a1fb5c3f0440c8"
  instance_type     = "t3.small"
  availability_zone = "us-east-1a"
  key_name          = "DemoTF"

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.port1.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.port2.id
    device_index         = 1
  }

  tags = {
    Name = "FortiGateEC2"
  }
}

# Create reverse SSH connection EC2
resource "aws_instance" "Bastion-Host" {
  ami               = "ami-07d9b9ddc6cd8dd30"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "DemoTF"
  subnet_id         = aws_subnet.PubSub.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.WebApp-sg.id]

  tags = {
    Name = "BastionHost-tf"
  }
}

# Create Web App EC2
resource "aws_instance" "WebApp-EC2" {
  ami               = "ami-07d9b9ddc6cd8dd30"
  instance_type     = "t3.large"
  availability_zone = "us-east-1a"
  key_name          = "DemoTF"

  network_interface {
    network_interface_id = aws_network_interface.WebApp-ENI.id
    device_index = 0
  }

  tags = {
    Name = "WebApp-tf"
  }
}

# Create application load balancer
resource "aws_lb" "HC-ALB" {
  name               = "HC-ALB-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.WebApp-sg.id]
  subnets            = [aws_subnet.PRVSubA.id, aws_subnet.PRVSubB.id]
  enable_deletion_protection = false
}

# Create target group
resource "aws_lb_target_group" "HC-ALB-tg" {
  name     = "HC-ALB-tg-tf"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_default_vpc.default.id
  
  health_check {
    enabled = true
    healthy_threshold = 5
    interval = 30
    timeout = 5
    unhealthy_threshold = 6
    matcher = "200-499"
    path = "/"
  }
}

# Register WebApp EC2 to the target group
resource "aws_lb_target_group_attachment" "attach" {
  target_group_arn = aws_lb_target_group.HC-ALB-tg.arn
  target_id        = aws_instance.WebApp-EC2.id
  port             = 80
}

# Attach target group to the ALB
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.HC-ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.HC-ALB-tg.arn
  }
}
