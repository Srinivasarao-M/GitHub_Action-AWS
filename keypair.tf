resource "tls_private_key" "privateKey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name   = "${var.Environment}-${var.application_name}-pub"
  public_key = tls_private_key.privateKey.public_key_openssh
}
