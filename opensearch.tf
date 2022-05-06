resource "aws_opensearch_domain" "opensearch" {
  domain_name    = var.domain_name
  engine_version = var.engine_version

  cluster_config {
    instance_type = var.instance_type
    instance_count = var.instance_count
    zone_awareness_enabled = false
    dedicated_master_enabled = false
  }

  advanced_security_options {
    enabled = true
    internal_user_database_enabled = true
    
    master_user_options {
      master_user_name = var.master_user_name
      master_user_password = var.master_user_password
    }
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.volume_size
  }
  
  domain_endpoint_options {
    custom_endpoint_enabled = true
    custom_endpoint = var.custom_endpoint
    custom_endpoint_certificate_arn = var.cert_arn
    enforce_https = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  vpc_options {
    subnet_ids = [
      data.aws_subnets.subnets.ids[0] // EM PRODUCAO MAIS DE UMA SUBNET PRECISA SER ADICIONADA
    ]

    security_group_ids = [aws_security_group.sg.id]
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  auto_tune_options {
    desired_state = "DISABLED" //ATIVAR EM PRODUCAO | O TERRAFORM ESTA DANDO ERRO COM ELE ATIVO
    rollback_on_disable = "DEFAULT_ROLLBACK"
  }

  tags = var.tags

  access_policies = <<POLICY
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "es:*",
          "Principal": "*",
          "Effect": "Allow",
          "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain_name}/*"
        }
      ]
    }
  POLICY

}