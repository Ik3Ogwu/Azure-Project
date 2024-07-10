# Azure-Project

# Azure-Project Design

# CI/CD Strategy:
Tool: Azure DevOps 
Use Case: Implement two separate pipelines one for infrastructure changes and another for the application code.

Pipeline 1: Infrastructure Pipeline

![Blank diagram - Page 1](https://github.com/Ik3Ogwu/Azure-Project/assets/161030400/a3c7a847-5a18-4c50-86e1-bcbd34ec6b0c)

This pipeline manages changes to the Terraform-defined infrastructure.
Steps:
1. Trigger: Set up to run on changes to the main.tf file in the main branch.
2. Checkout Code: Fetch the latest code from the repository.
3. Initialize Terraform: Run "terraform init" to initialize the working directory.
4. Validate Terraform: Run "terraform validate" to check for syntax errors and internal consistency.
5. Plan Terraform Changes: Execute "terraform plan -out=tfplan" to create an execution plan. This step shows what changes will be made to the infrastructure.
6. Publish Plan: Run "terraform show -no-color tfplan > tfplan.txt" to save the plan as an artifact for review.
7. Approval Gate: Implement a manual approval process for reviewing the plan before applying changes.
Apply Terraform Changes: If approved, run terraform apply to make the actual changes to the infrastructure.
8. Output Variables: Capture and store any output variables from Terraform for use in other pipelines or processes.

Pipeline 2: Application Pipeline

![Flowchart - Page 1 (1)](https://github.com/Ik3Ogwu/Azure-Project/assets/161030400/93329b28-dcc5-492e-a111-e67955cf4781)

This pipeline handles the F1 results Python application.
Steps:
1. Trigger: Set to run on changes to the F1QualiResults.py file or config.ini in the main branch.
2. Checkout Code: Fetch the latest application code.
3. Build Docker Image: Use the Docker task to build an image of the F1 results application.
4. Run Tests: Execute any unit or integration tests for the Python script.
5. Push Docker Image: If tests pass, push the Docker image to Azure Container Registry.
6. Deploy to AKS: Use Kubernetes manifests to deploy the new image to the AKS cluster.
7. Post-Deployment Tests: Run smoke tests to ensure the deployment was successful.


# Monitoring and Security Tools:
For monitoring, I would use Azure Monitor to track the performance of the AKS cluster and storage account. This tool collects metrics and logs, allowing us to set up alerts for critical issues concerning the infrastructure's health.

To ensure security, I would implement Azure Security Center for threat protection and Azure Key Vault to securely store sensitive information like API keys. Additionally, I'd use Network Security Groups to control traffic and implement container image scanning to check for vulnerabilities before deployment.


