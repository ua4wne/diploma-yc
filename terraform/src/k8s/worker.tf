resource "yandex_compute_instance" "workers" {
  count                     = var.k8s_vm.workers
  name                      = "worker-${count.index + 1}"
  hostname                  = "worker-${count.index + 1}"
  platform_id               = var.vm_platform
  zone                      = "ru-central1-b"
  allow_stopping_for_update = var.vm_stop_update

  resources {
    cores         = var.resources_vm["cores"]
    memory        = var.resources_vm["memory"]
    core_fraction = var.resources_vm["core_fraction"]
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.image_id
      size     = var.resources_vm["disk_size"]
      type     = var.resources_vm["disk_type"]
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-b.id
    nat       = var.vm_nat
  }

  metadata = {
    serial-port-enable = var.metadata_map.metadata.serial-port-enable
    ssh-keys           = "${var.vm_user}:${local.ssh-keys}"
    # user-data          = data.template_file.cloudinit.rendered
  }
}
