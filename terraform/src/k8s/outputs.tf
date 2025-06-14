output "bastion_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "control_plane_ip" {
  value = yandex_compute_instance.master[0].network_interface.0.ip_address
}

output "worker_ips" {
  value = yandex_compute_instance.workers[*].network_interface.0.ip_address
}
