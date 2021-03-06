# Terraform - AWS VM deployment and XaaS change request

This AWS example shows how to use Commander workflow modules to sync Terraform accounts after a deployment is made, then set resource ownership for Commander portal visibility and make a change request for a deployed AWS E2 instance.This example can be modified for other cloud accounts and can also be used as a starting point for other cloud accounts not managed by Snow Commander.

Requirements:
* Credential in the Commander credential library for connecting to Commander (Admin Portal API User)
* Credential in the Commander credential library named after the AWS subscription that will be used for Change Requests
* Advanced property "embotics.rest.credentials.retrievesensitive" must be set to "True"
* Advanced property "embotics.workflow.script.credentials" must be set to "True"
* Terraform binary Installed on the Commander Server and linked to Terraform Cloud.
    * Binary path for this sample:  "C:\terraform\terraform.exe"
    * https://learn.hashicorp.com/tutorials/terraform/cloud-login
    * You may need to copy your Terraform Cloud token to C:\Users\CommanderService\AppData\Roaming\terraform.d for Commander to be able to connect to TFCloud
* AWS Powershell module installed on the Commander server
* Commander 9.X or higher 



Deployment workflow modules installation and setup:
1. In Commander ensure a credential exists in "Configuration > Credentials" for Commander API.
2. Import the custom component completion modules, Import the workflow modules.
3. Open the sync and ownership completion modules and specify the credential in the dropdown to connect back into the Commander API. 
4. Create a folder for deployments on the  server for this example: "c:\terraform\deployments".
5. Create a folder "Ubuntu_VM_Template" to be copied as a base config or "template", and copy the justvm.tf file into the folder. This will be copied for every deployment and named after the RequestID. 
6. Open the Terraform Deployment module and look at where the variables.tf file get created in the new folder for the deployment. Make sure these match the variables in justvm.tf.
7. In the sample the VM name is "NewTFVM001". This can be a user input field and passed into the module.
8. If the module fails to run, the comments will contain the errors.

Change request Workflow:
1. In Commander ensure a credential exists in "Configuration > Credentials" for the AWS account. The name must match the subscription ID for programmatic lookup. 
2. Import the Change Completion Workflow. 
3. Edit the workflow and specify the credential in the dropdown to connect back into the Commander API.
4. Create an XaaS change request with a display condition of: ```(#{target.context.provider} -contains "registry.terraform.io/hashicorp/aws") -and (#{target.context.instances[0].attributes.arn} -contains ":instance/")```
5. Set the completion workflow for the component to the imported workflow "XaaS CR TF_AWS Start or Reboot Instance". 
    * This change request will now only show up when making a change on an AWS resource from the Terrafrom resources list  on the Admin Portal or Service Portal. 
6. If the workflow fails to run, the comments will contain the errors.
____

*Currently being migrated from [Embotics Git](https://github.com/Embotics)*

### [Commander Documentation](https://docs.snowsoftware.com/commander/index.htm)

### [Commander Knowledge Base](https://community.snowsoftware.com/s/topic/0TO1r000000E5srGAC/commander?tabset-056aa=2)
