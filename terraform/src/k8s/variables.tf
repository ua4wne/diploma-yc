variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "k8s"
  description = "VPC network&subnet name"
}

variable "ssh_public_key" {
  type        = string
  default     = ""
  description = "SSH public key"
}

variable "ssh_private_key" {
  type        = string
  default     = ""
  description = "SSH private key"
}

variable "k8s_vm" {
  type = map(number)
  default = {
    masters = 1
    workers = 3
    app_port = 30051
    grafana_port = 31396
  }
}

variable "resources_vm" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
    disk_size     = 50
    disk_type = "network-hdd"
  }
}

variable "resources_bastion" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
    disk_size     = 10
    disk_type = "network-hdd"
  }
}

variable "get_hosts" {
  type        = bool
  default     = true
  description = "allow create hosts.yaml for ansible"
}

variable "vm_preemptible" {
  type        = bool
  default     = true
  description = "allow preemptible"
}

variable "vm_nat" {
  type        = bool
  default     = true
  description = "allow nat"
}

variable "vm_stop_update" {
  type        = bool
  default     = true
  description = "allow stopping vm for update"
}

variable "vm_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform of compute instanse"
}

variable "os_family" {
  type        = string
  default     = "ubuntu-2404-lts-oslogin"
  description = "yandex_compute_image"
}

variable "metadata_map" {
  type = map(object({
    serial-port-enable = bool
    ssh-keys           = string
  }))
  default = {
    metadata = {
      serial-port-enable = true
      ssh-keys           = "user:key.pub"
    }
  }
}
