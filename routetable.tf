resource "aws_route_table" "web_public_route_table" {
  vpc_id = aws_vpc.msr_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
          Name = "${var.platform_name}-${var.application_name}-${var.Environment}-web_public_route_table"
    }
  depends_on = [aws_vpc.ceq_vpc, aws_internet_gateway.igw]
}

resource "aws_route_table_association" "web_public_route_table_association" {
  count          = length(var.web_public_subnet_cidr)
  subnet_id      = element(aws_subnet.web_public_subnets.*.id, count.index)
  route_table_id = aws_route_table.web_public_route_table.id
  depends_on     = [aws_subnet.web_public_subnets, aws_route_table.web_public_route_table]
}

resource "aws_route_table" "app_private_route_table" {
  vpc_id = aws_vpc.msr_vpc.id
  route {

  }
  tags = {
           Name = "${var.platform_name}-${var.application_name}-${var.Environment}-app_private_route_table"
    }
  depends_on = [aws_vpc.ceq_vpc]
}

resource "aws_route_table_association" "app_private_route_table_association" {
  count          = length(var.app_private_subnet_cidr)
  subnet_id      = element(aws_subnet.app_private_subnets.*.id, count.index)
  route_table_id = aws_route_table.app_private_route_table.id
  depends_on     = [aws_subnet.app_private_subnets, aws_route_table.app_private_route_table]
}