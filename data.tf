resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  availability_zones      = ["us-east-1b"]
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = "bar123456"
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot     = true
}

resource "aws_security_group" "aurora_security_group" {
  name        = "aurora-security-group"
  description = "Security group for Aurora MySQL"
  vpc_id      = aws_vpc.aurora.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id]
  }

}

