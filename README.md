### AUTO DEPLOYMENT WITH TERRAFORM, VPC, ANSIBLE & PACKER
The aim of this project is to auto deploy a three tier application comprised of the Front end, Backend(API server) and Database

### Technologies used
- [Packer](https://www.packer.io/) - This technology is used to make a packer AMI image on AWS
- [Ansible](www.ansible.com) - Ansible shall be used to provision the created packer AMI image
- [Terraform](https://www.terraform.io/)- Terraform shall help to plan, create and formulate an execution plan for the application
- [VPC](https://aws.amazon.com/vpc/) - Amazon VPC is used to set up security for the application
- [AWS](https://aws.amazon.com/)- AWS shall provide the platform to run the application

### How the application works
- Clone this repository by running `git clone https://github.com/mariamiah/FULL-STACK-DEPLOYMENT-WITH-TERRAFORM.git`
- Navigate into the cloned repository on terminal by typing `cd FULL-STACK-DEPLOYMENT-WITH-TERRAFORM`
- Create a .env file within this folder and provide both your AWS access key and security key in the format presented in the env.sample file
- Source the .env file by using `source .env` on the terminal
- Run the script by typing `./launch.sh`
- Type `yes` at the terraform plan prompt inorder to apply all the planned changes
- On completion of the script, check your AWS dashboard to ensure the VPC along with the corresponding subnets and instances have been created 