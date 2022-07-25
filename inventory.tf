resource "local_file" "inventory_cfg" {
  content = templatefile("${path.module}/inventory.tpl",
    {
      wireguard_server = arvan_iaas_abrak.wireguard.addresses
    }
  )
  filename = "./ansible.yaml"
}