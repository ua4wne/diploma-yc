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
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "k8s"
  description = "VPC network&subnet name"
}

variable "resources_vm" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
    disk_size     = 50
  }
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "nat enable"
}

variable "vm_web_user" {
  type        = string
  default     = "ubuntu"
  description = "default user"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "platform of compute instanse"
}

variable "vm_web_family" {
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
      ssh-keys           = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIdGeVIrjr+DNhhCOKPA5Rl3Aui+Kwk8N3GHiUYs2H+F dervish@devops"
    }
  }
}
