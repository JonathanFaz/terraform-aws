## DevOps

This exercise use terraform to create a VPC and 2 privates subnets, one RDS instance and two ec2 instance one public and another private.

This application deploy a nodejs app https://github.com/JonathanFaz/terraform-aws-app

## Improvements

* Store secrets in AWS Secrets Manager 
* Use CI/CD to deploy infraesctructure
* Use ansible to install requirements


## Deploy

Configure your aws cli or set the following environment vars:

```sh
$ export AWS_ACCESS_KEY_ID="[ACCESS_KEY]"
$ export AWS_SECRET_ACCESS_KEY="[SECRET_KEY]"

# then setup terraform
$ terraform init

# check the plan
$ terraform plan

# use apply to create infraesctructure
$ terraform apply

# use apply to delete infraesctructure
$ terraform destroy
```

## Q&A
* **Como expondrias tu aplicación a internet?**
Adjuntando a tu subnet un "Internet Gateway" y una ip publica en caso de querer tambien darle un dominio podemos utilizar route53 
* **Que utilizarias para escalar tu apliación de manera dinamica?**
Ya que la aplicacion esta dockerizada podria utilizar ECS para poder escalar. tambien podriamos exponer el endpoint via lambda
* **Como le darias acceso a un desarrollador a la base de datos?**
Para no exponer la base de datos publicamente se le daria acceso a una instancia dentro de la vpc que pueda comunicarse con la bd, podriamos incluso limitar el acceso via ip para que solo su ip se pueda conectar y cuidando los permisos del usuario developer

