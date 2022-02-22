resource "aws_db_subnet_group" "database-subnet-group" {
  name         = "database subnets"
  subnet_ids   = [var.subnet_private_1, var.subnet_private_2]
  description  = "Subnets for Database Instance"
}

resource "aws_db_instance" "database-instance" {
  instance_class       =  "db.t2.micro"
  engine               = "mysql"
  engine_version       = "5.7"
  allocated_storage    = 10
  skip_final_snapshot  = true
  db_name                 = "${var.db_name}"
  username               = "${var.db_username}"
  password               = "${var.db_password}"
  vpc_security_group_ids  = ["${var.security_group}"]
  db_subnet_group_name = aws_db_subnet_group.database-subnet-group.name
  #multi_az             = false
}