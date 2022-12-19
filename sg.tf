
resource "aws_security_group" "web_alb_security_group" {
  name        = "Web-ALB-SG"
  description = "Web ALB Security Group - Allow external web traffic"
  vpc_id      = aws_vpc.msr_vpc.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 9080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
           Name = "${var.platform_name}-${var.application_name}-${var.Environment}-web_alb_sg"
    }
}



resource "aws_security_group" "ec2_public_security_group" {
  name        = "EC2-public-scg"
  description = "Internet reaching access for public ec2s"
  vpc_id      = aws_vpc.msr_vpc.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 9080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.Self-hosted-runner-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
            Name = "${var.platform_name}-${var.application_name}-${var.Environment}-ec2_public_sg"
    }
  depends_on = [aws_vpc.msr_vpc, aws_security_group.web_alb_security_group]
}


resource "aws_security_group" "Self-hosted-runner-sg" {
  name        = "self-hosted-runner-sg"
  description = "allow SSH pn runner SG resources to access private instance"
  vpc_id      = aws_vpc.msr_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
            Name" = "self-hosted-runner-sg-${var.platform_name}-${var.application_name}-${var.Environment}"
    }
  depends_on = [aws_vpc.msr_vpc]
}