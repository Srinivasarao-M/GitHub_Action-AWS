resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.msr_vpc.id
  tags = {
          Name = "${var.platform_name}-${var.application_name}-${var.Environment}-igw"
    }
  depends_on = [aws_vpc.msr_vpc]
}
