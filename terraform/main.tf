#===============================================================================
# Arvan Resources
#===============================================================================

resource "arvan_iaas_abrak" "abrak" {
  region   = var.region
  flavor   = var.flavor
  count    = 1
  name     = "${var.abrak_name}-${count.index}"
  ssh_key  = true
  key_name = "secure"
  image {
    type = "distributions"
    name = "ubuntu/22.04"
  }
  disk_size = 25
}

data "arvan_iaas_abrak" "get_abrak_id" {
  depends_on = [
    arvan_iaas_abrak.abrak
  ]
  region = var.region
  count  = 1
  name   = "${var.abrak_name}-${count.index}"
}

output "details-abrak" {
  value = data.arvan_iaas_abrak.get_abrak_id
}

#===============================================================================
# Ansible Resources
#===============================================================================

resource "terraform_data" "ansible" {
  depends_on = [arvan_iaas_abrak.abrak]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "188.121.106.205"
      # password = ""
    }
    inline = [
      "echo 'hi terraform!' > /home/ubuntu/terra.txt"
    ]
  }
}
