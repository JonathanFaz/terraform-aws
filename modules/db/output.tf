output "db_endpoint" {
  value = "${aws_db_instance.database-instance.endpoint}"
}

output "db_id" {
  value = "${aws_db_instance.database-instance.id}"
}
