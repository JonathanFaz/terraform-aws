#!/bin/bash
# install git
sudo yum -y install git
sudo yum -y update
# install docker
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo chmod 666 /var/run/docker.sock
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# App deploy
cd /home/ec2-user
sudo git clone https://github.com/JonathanFaz/terraform-aws-app
echo "DB_PASS=${db_password}
DB_USER=${db_username}
DB_NAME=${db_name}
DB_URL=${db_endpoint}" >> /home/ec2-user/terraform-aws-app/.env
cd terraform-aws-app
source .env
/usr/local/bin/docker-compose up -d