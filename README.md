# wireguard-arvancloud

This terraform creates an abrak(VPS) in arvancloud, installs wireguard on the server using ansible, then creates a wireguard client.

At the end of the run, it will displays a **qrcode** that you can scan it with your device to add connection.

You can simply destroy server when you are done with Iran's IP address


## Requirements
You need to have an **API-KEY** from ArvanCloud to fill **apikey** in **provider.tf**

**Ansible** needs to be installed on your machine.


## Run
You have to provide sshkey for the ansible, or use random sshkey that is already available in directory.

to create:
```bash
ssh-keygen -f ./sshkeys/key
```
or change the permission of existing key
```bash
chmod 600 ./sshkeys/key
```
then you can run terraform:

```bash
terraform init
terraform apply
terraform destroy
```
