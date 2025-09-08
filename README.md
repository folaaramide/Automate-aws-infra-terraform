# Automate End-to-End AWS Infrastructure with Terraform
## Project Overview
In this project, I automated the provisioning of a complete AWS infrastructure from scratch using Terraform. It was a hands-on experience that strengthened my understanding of cloud architecture, infrastructure-as-code (IaC), and automation best practices.

The infrastructure includes:

VPC with public and private subnets for scalable networking

Security groups to enforce secure access

EC2 instances running NGINX web servers

Elastic Load Balancer (ELB) to handle traffic dynamically

This project demonstrates my ability to design and deploy highly available, scalable, and secure cloud infrastructure.

## Tech Stack

Cloud Provider: AWS (VPC, EC2, ELB)

Infrastructure as Code: Terraform

Web Server: NGINX

Step-by-Step Workflow & Achievements

I approached this project systematically, building the infrastructure from the ground up:

## Project Initialisation

**1. Created a structured project directory for Terraform files.**

Achievement: Organised infrastructure code for maintainability and scalability.

**2. AWS Configuration**

Configured AWS CLI credentials to enable Terraform to deploy resources.

Achievement: Ensured secure and seamless connectivity to AWS.

**3. Terraform Provider Definition**

Defined the AWS provider specifying region and credentials.

Achievement: Established Terraform environment for automated deployments.

**4. VPC and Networking**

Created a custom VPC with public and private subnets.

Configured route tables and associated them with subnets.

Deployed an Internet Gateway for public access.

Achievement: Built a scalable and secure network foundation.

5.**Security Groups**

Configured rules for inbound and outbound traffic to EC2 instances.

Achievement: Implemented strong security best practices.

**6. Compute Layer**

Launched EC2 instances and installed NGINX web server.

Achievement: Enabled high-availability application hosting.

**7. Load Balancer**

Provisioned an Elastic Load Balancer to distribute traffic across instances.

**8. Outputted DNS name for public access.**

Achievement: Achieved scalable and fault-tolerant application delivery.

**9. Verification and Testing**

Verified deployed resources via AWS Console.

Accessed NGINX web server through Load Balancer DNS.

Achievement: Ensured end-to-end functionality of the infrastructure.

## Terraform Workflow

All infrastructure provisioning was automated with Terraform:

### Initialise Terraform
terraform init

### Preview planned infrastructure
terraform plan

### Apply configuration to deploy AWS resources
terraform apply

Result: Fully automated AWS infrastructure with minimal manual intervention.

## Architecture Diagram

This diagram illustrates the project’s architecture:

## Architecture
![Architecture Diagram](./docs//architecture/architecture-diagram.png)

## Key Learnings & Achievements (STAR Style)
-I needed to deploy a complete AWS environment for a scalable web application.

-Automated provisioning, networking, compute, and load balancing using Terraform.

-Built VPC, subnets, security groups, EC2 instances, and ELB with Terraform.

-Successfully deployed a fully functional, secure, and scalable AWS infrastructure.

**Additional Highlights:**

-Reduced manual setup time by 100% through automation.

-Ensured high availability and fault tolerance for the application.

-Gained practical experience with infrastructure-as-code, cloud networking, and load balancing.

## Cleanup

To avoid unnecessary AWS costs, I destroyed all resources after testing:

terraform destroy

## Summary
This project demonstrates my ability to design, deploy, and automate AWS infrastructure using Terraform. It showcases my skills in cloud architecture, automation, security, and scalable application deployment, making it a strong addition to my GitHub portfolio for potential employers.# Automate End-to-End AWS Infra with Terraform

## Screenshots

### Terraform Plan Output
![Terraform Plan](./docs/screenshots/terraform-plan.png)

### AWS Load Balancer Dashboard
![Load Balancer](./docs/screenshots/aws-loadbalancer.png)

### NGINX Running on EC2
![NGINX on EC2](./docs/screenshots/nginx-ec2.png)
