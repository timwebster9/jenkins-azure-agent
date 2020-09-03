# jenkins-azure-agent
Docker image for running Azure infrastructure builds on Jenkins.

## Installed Software
- Azure CLI
- PowerShell and assorted modules (see Dockerfile for list)
- tfenv for managing multiple Terraform versions
- Terraform 0.12
- Terraform 0.13
- Make

## Usage
The default Terraform version has been set to 0.12.  To switch versions, use the `tfenv use <version> command`.

For example:
```
tfenv use 0.13.2
```