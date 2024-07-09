# Azure-Project

# Azure-Project Design

# CI/CD Strategy:
Tool: Azure DevOps 
Use Case: Implement two separate pipelines one for infrastructure changes and another for the application code.

Pipeline 1: Infrastructure Pipeline
This pipeline manages changes to the Terraform-defined infrastructure.
Steps:
1. Trigger: Set up to run on changes to the main.tf file in the main branch.
2. Checkout Code: Fetch the latest code from the repository.
3. Install Terraform: Use the "TerraformInstaller" task to install the specified Terraform version.
4. Initialize Terraform: Run terraform init to initialize the working directory.
5. Validate Terraform: Run terraform validate to check for syntax errors and internal consistency.
6. Plan Terraform Changes: Execute terraform plan to create an execution plan. This step shows what changes will be made to the infrastructure.
7. Publish Plan: Save the plan as an artifact for review.
8. Approval Gate: Implement a manual approval process for reviewing the plan before applying changes.
Apply Terraform Changes: If approved, run terraform apply to make the actual changes to the infrastructure.
9. Output Variables: Capture and store any output variables from Terraform for use in other pipelines or processes.

Pipeline 2: Application Pipeline
This pipeline handles the F1 results Python application.
Steps:
1. Trigger: Set to run on changes to the F1QualiResults.py file or config.ini in the main branch.
2. Checkout Code: Fetch the latest application code.
3. Build Docker Image: Use the Docker task to build an image of the F1 results application.
4. Run Tests: Execute any unit or integration tests for the Python script.
5. Push Docker Image: If tests pass, push the Docker image to Azure Container Registry.
6. Deploy to AKS: Use Kubernetes manifests to deploy the new image to the AKS cluster.
7. Post-Deployment Tests: Run smoke tests to ensure the deployment was successful.


Describe a CI/CD pipeline strategy that encompasses both infrastructure and application code changes. Detail the steps involved from code commit to deployment, specifying:
How infrastructure changes are tested and applied.
How application code, including the provided Python script, is built, tested, and deployed to the containerized environment.



# Monitoring and Security Tools:
Monitoring and Security Tools
Azure Monitor: Enable for your AKS cluster and storage account
Azure Security Center: Enable for your subscription
Azure Key Vault: Store secrets and access keys




Specify what tools and practices you would implement for monitoring the performance and health of the infrastructure.
Describe the security measures and tools you would use to ensure the integrity and security of the storage, message queue, and containerization infrastructure.
