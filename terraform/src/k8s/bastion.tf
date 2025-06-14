# --- Бастион ---
resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  hostname    = "bastion"
  platform_id = var.vm_platform
  zone        = var.default_zone

  resources {
    cores         = var.resources_bastion["cores"]
    memory        = var.resources_bastion["memory"]
    core_fraction = var.resources_bastion["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      size     = var.resources_bastion["disk_size"]
      type     = var.resources_bastion["disk_type"]
    }
  }

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public-subnet.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata.serial-port-enable
    ssh-keys           = "${var.vm_user}:${local.ssh-keys}"
  }
}
