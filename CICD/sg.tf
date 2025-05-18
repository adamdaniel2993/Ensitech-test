##### Bastion Host

resource "aws_security_group" "ensitech_ec2_sg" {
  name        = "${var.tenant}-${var.environment}-ec2-sg"
  description = "Security group for ec2 ensitech test"
  vpc_id      = module.vpc.vpc_id

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  tags = {
    Name = "${var.tenant}-${var.environment}-rds-sg"
  }
}

resource "aws_security_group_rule" "external" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ensitech_ec2_sg.id
  cidr_blocks              = ["0.0.0.0/0"]

}