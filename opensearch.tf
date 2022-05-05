resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count
    zone_awareness_enabled = false
  }

  cognito_options {
    role_arn = var.role_arn
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = false
    master_user_options {
    master_user_name = var.master_user_name
    master_user_password = var.master_user_password
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.volume_type
    volume_size = var.volume_size
  }
  
  domain_endpoint_options {
    custom_endpoint_enabled = true
    custom_endpoint = var.custom_endpoint

  }
  tags = {
    Name = var.domain_name
  }
}