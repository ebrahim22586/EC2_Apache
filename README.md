for usage : 
git clone https://github.com/ebrahim22586/EC2_Apache.git 
cd EC2_Apache   
Initialize Terraform
Initialize Terraform to install the necessary providers.
bash
Copy code
terraform init
Apply Terraform Configuration
Apply the configuration to set up the AWS resources:
bash
Copy code
terraform apply
Confirm the action by typing yes when prompted.
Access Your Apache Web Server
After the Terraform scripts execute successfully.
you should be able to access the web page by navigating to the public IP address of the EC2 instance.
This IP can be found in the Terraform outputs.
