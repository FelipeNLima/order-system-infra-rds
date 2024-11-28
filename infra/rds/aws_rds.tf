terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "banco_sg_products" {
    name        = "banco_sg_products"
    description = "Security Group for DB MySql"
      ingress {
      description = "MYSQL/Aurora"
      from_port   = 3306
      to_port     = 3306
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
      egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_db_instance" "banco" {
    allocated_storage    = 10
    db_name              = "dbMySqlProducts"
    identifier           = "dbproducts"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = "msproducts"
    password             = "Fiap24msproducts"
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    publicly_accessible  = true
    port                 = 3306
    vpc_security_group_ids = [aws_security_group.banco_sg_products.id]
    tags = {
      Name = "rdsDB"
    }
}