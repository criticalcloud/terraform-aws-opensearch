resource "aws_security_group" "sg" {
  name        = "${var.domain_name}"
  description = "SG Opensearch Cluster"

  vpc_id = data.aws_vpc.vpc.id

  ingress {
    description = ""
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.subnet_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
