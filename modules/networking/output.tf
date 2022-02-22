output "private_subnet_1" {
  value = aws_subnet.private-subnet-1.id
}
output "private_subnet_2" {
  value = aws_subnet.private-subnet-2.id
}
output "public_subnet_1" {
  value = aws_subnet.public-subnet-1.id
}

output "sg_pub_id" {
  value = aws_security_group.allow_ssh_pub.id
}
#output "vpc" {
#  value = module.vpc
#}
    
#output "sg_pub_id" {
#  value = aws_security_group.allow_ssh_pub.id
#}

output "sg_priv_id" {
  value = aws_security_group.allow_ssh_priv.id
}  

output "sg_mysql_id" {
  value = aws_security_group.mysql_sg.id
}