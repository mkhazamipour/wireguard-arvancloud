# wireguard-arvancloud

This terraform creates an abrak(VPS) in arvancloud, installs wireguard on the server using ansible, then creates a wireguard client.

At the end of the run, it will displays a **qrcode** that you can scan it with your device to add connection.

You can simply destroy server when you are done with Iran's IP address


## Requirements
You need to have an **API-KEY** from ArvanCloud to fill **apikey** in **provider.tf**

**Ansible** needs to be installed on your machine.


## Run
Terraform creates a random sshkey in **sshkey** directory to connect to the created server.

You can run terraform:

```bash
terraform init
terraform apply
terraform destroy
```
