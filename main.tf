module "networking" {
  source    = "./modules/networking"
}
module "db" {
  source    = "./modules/db"
  subnet_private_1  = module.networking.private_subnet_1
  subnet_private_2  = module.networking.private_subnet_2
  security_group    = module.networking.sg_mysql_id
  db_name        = "${var.db_name}"
  db_username    = "${var.db_username}"
  db_password    = "${var.db_password}"
}
module "ssh-key" {
  source    = "./modules/ssh"
}
module "ec2" {
  source                = "./modules/ec2"
  sg_pub_id             = module.networking.sg_pub_id
  sg_priv_id            = module.networking.sg_priv_id
  subnet_public_1       = module.networking.public_subnet_1
  subnet_private_1      = module.networking.private_subnet_2
  key_name              = module.ssh-key.key_name
  db_endpoint           = module.db.db_endpoint
  db_name               = "${var.db_name}"
  db_username           = "${var.db_username}"
  db_password           = "${var.db_password}"
}