locals {
  ssh-keys = fileexists("~/.ssh/id_ed25519.pub") ? file("~/.ssh/id_ed25519.pub") : var.ssh_public_key
  ssh-private-keys = fileexists("~/.ssh/id_ed25519") ? file("~/.ssh/id_ed25519") : var.ssh_private_key
}

data "yandex_compute_image" "os" {
  family = var.os_family
}

# data "template_file" "cloudinit" {
#  template = file("${path.module}/cloud-init.yml")
#  vars = {
#    ssh_public_key = local.ssh-keys
#    ssh_private_key = local.ssh-private-keys
#  }
# }