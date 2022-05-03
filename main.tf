resource "aws_opensearch_domain" "example" {
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
  
}