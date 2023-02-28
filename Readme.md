## Automate the process of EC2 instance deployment using terraform as IaC and jenkins for CI/CD. 

Assuming we have a Jenkins setup, we have to create a pipeline and set up the AWS credentials as an environment variable.
Once this pipeline triggers it will create and deploy an ec2 instance.

### Terraform 
We have terraform code which consists of module which  includes networking components e.g. VPC,Subnets,internet gateway and on top of the description of desired ec2.
it has the remote backend as well.

### Jenkinsfile
Jenkins file which has multiple steps in the form of terraform commands which will create and deploy the ec2 instance.


