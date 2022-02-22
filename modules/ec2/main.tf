// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


data "template_file" "user-init" {
   template = "${file("${path.module}/script.tpl")}"
  vars = {
    db_endpoint="${var.db_endpoint}"
    db_name="${var.db_name}"
    db_username="${var.db_username}"
    db_password="${var.db_password}"
  }
}
// Configure the EC2 instance in a public subnet

resource "aws_instance" "ec2_public" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.subnet_public_1
  vpc_security_group_ids      = [var.sg_pub_id]
  user_data                   = "${data.template_file.user-init.rendered}"
}


// Configure the EC2 instance in a private subnet
resource "aws_instance" "ec2_private" {
  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  #key_name                    = var.key_name
  subnet_id                   = var.subnet_private_1
  vpc_security_group_ids      = [var.sg_priv_id]
}