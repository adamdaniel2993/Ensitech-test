data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}


module "ensitech_ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.6"
  name          = "ensitech-ec2-test"
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.medium"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.ensitech_ec2_sg.id]
  key_name               = "test-key"
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo dnf update
              sudo dnf install nginx -y
              sudo systemctl start nginx
              EOF
  root_block_device = [
    {
      volume_size = 50
      volume_type = "gp3"
      encrypted   = true
    }
  ]
  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

output "instance_id" {
  description = "The ID of the created EC2 instance."
  value       = module.ensitech_ec2.id
}

output "public_ip" {
  description = "Public ip of created EC2 instance."
  value       = module.ensitech_ec2.public_ip
}

output "instance_arn" {
  description = "The ARN of the EC2 instance."
  value       = module.ensitech_ec2.arn
}

output "primary_network_interface_id" {
  description = "The ID of the primary network interface."
  value       = module.ensitech_ec2.primary_network_interface_id
}