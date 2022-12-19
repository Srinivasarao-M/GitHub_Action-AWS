resource "aws_iam_instance_profile" "ssm-profile" {
  name = "ssm-profile"
  role = "SSM-CONNECT-PROFILE"
}

resource "aws_instance" "webec2" {
  count = var.web_servers_count #length(var.web_public_subnet_cidr)

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_public_security_group.id]
  iam_instance_profile   =  aws_iam_instance_profile.ssm-profile.name
  # subnet_id              = aws_subnet.web_public_subnets[count.index].id
  subnet_id = (count.index % 2) == 0 ? aws_subnet.web_public_subnets[0].id : aws_subnet.web_public_subnets[1].id
  key_name  = aws_key_pair.ec2_keypair.key_name

  tags = {
             Name = "${var.platform_name}-${var.application_name}-${var.Environment}-${format("web-%d", count.index + 1)}"
    }
    

  user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl start httpd.service
                systemctl enable httpd.service
                echo "Hi Friend I am public Web EC2!!!! : $(hostname -f)" > /var/www/html/index.html
                EOF

  depends_on = [aws_vpc.msr_vpc, aws_subnet.web_public_subnets, aws_security_group.ec2_public_security_group, aws_key_pair.ec2_keypair]
}