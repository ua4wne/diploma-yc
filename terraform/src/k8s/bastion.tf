# --- Бастион ---
resource "yandex_compute_instance" "bastion" {
  name        = "bastion"
  hostname    = "bastion"
  platform_id = var.vm_platform
  zone        = var.default_zone
  depends_on = [yandex_compute_instance.master]

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
    # user-data          = data.template_file.cloudinit.rendered
  }
  
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = var.vm_user
    private_key = local.ssh-private-keys
    timeout     = "2m"
  }

  # --- Копирование hosts.yaml ---
  provisioner "file" {
    source      = "../../ansible/hosts.yaml"
    destination = "/home/ubuntu/hosts.yaml"
  }
  
  # --- Установка git, python3-pip, python3.12-venv ---
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y git python3-pip python3.12-venv",
      "echo 'Git, Python и venv установлены'"
    ]
  }

  # --- Клонирование Kubespray и установка зависимостей ---
  provisioner "remote-exec" {
    inline = [
      "cd /home/${var.vm_user}",
      "git clone -b release-2.26 https://github.com/kubernetes-incubator/kubespray.git", 
      "echo 'Kubespray успешно склонирован'",
      "cd kubespray/",
      "python3 -m venv venv",
      "source venv/bin/activate",
      "pip install -r requirements.txt",
      "echo 'Ansible и зависимости Kubespray установлены'"
    ]
  }
}
