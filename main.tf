resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits = 4096
}
resource "local_sensitive_file" "pem_file" {
  filename = pathexpand("./sshkeys/key")
  file_permission = "600"
  directory_permission = "700"
  content = tls_private_key.pk.private_key_pem
}
resource "local_file" "pem_file_pub" {
  filename = pathexpand("./sshkeys/key.pub")
  file_permission = "644"
  directory_permission = "700"
  content = tls_private_key.pk.public_key_pem

}

resource "arvan_iaas_sshkey" "wireguard_SSHKEY" {
  region = var.arvan_region
  name = var.wireguard_sshkey_name
  public_key = tls_private_key.pk.public_key_openssh
}


resource "arvan_iaas_abrak" "wireguard" {
  region = var.arvan_region
  flavor = var.arvan_server_flavor
  name   = var.server_name
  key_name = arvan_iaas_sshkey.wireguard_SSHKEY.name
  image {
    type = "distributions"
    name = "ubuntu/20.04"
  }
  disk_size = 25
}

resource "null_resource" "null" {
provisioner "local-exec" {
command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --private-key=./sshkeys/key -i ./ansible.yaml ./wireguard/main.yaml"
}
depends_on = [
  arvan_iaas_abrak.wireguard
]
}

output "wireguard_IP" {
  value = arvan_iaas_abrak.wireguard.addresses[0]
  depends_on = [
  arvan_iaas_abrak.wireguard
]
}