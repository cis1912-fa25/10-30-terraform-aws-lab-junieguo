terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# Create ECR repository for our Docker image
resource "aws_ecr_repository" "webapp" {
  name                 = "terraform-webapp-${var.pennkey}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "terraform-webapp-${var.pennkey}"
  }
}

# Output the ECR repository URL
output "ecr_repository_url" {
  description = "ECR repository URL for Docker images"
  value       = aws_ecr_repository.webapp.repository_url
}