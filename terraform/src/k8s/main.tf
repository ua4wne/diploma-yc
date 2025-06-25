locals {
  ssh-keys         = var.ssh_public_key
  ssh-private-keys = var.ssh_private_key
}


data "yandex_compute_image" "os" {
  family = var.os_family
}

data "template_file" "cloudinit_bastion" {
  template = file("${path.module}/cloudinit/cloudinit_bastion.yaml")
}
