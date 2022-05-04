resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true
  }

  master_user_options {
    master_user_name = var.master_user_name
    master_user_password = var.master_user_password
  }

  ebs_options {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
  
  vpc_opitions {
    subnet_ids = var.subnet_ids
  }
  
  domain_endpoint_options {
    custom_endpoint_certificate_arn = var.custom_endpoint_certificate_arn
    custom_endpoint_enabled = true
    custom_endpoint = var.custom_endpoint

  }
}


resource "aws_opensearch_domain_policy" "policy" {
  domain_name = var.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
              "AWS": "*"
            }
            "Action": "es:*"
            "Resource": "arn:aws:es:sa-east-1:656298508873:domain/${var.domain_name}/*"
        }
    ]
}
POLICIES
}