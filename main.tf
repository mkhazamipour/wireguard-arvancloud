resource "arvan_iaas_sshkey" "wireguard_SSHKEY" {
  region = var.arvan_region
  name = var.wireguard_sshkey_name
  public_key = file(var.sshkey_file_path)
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