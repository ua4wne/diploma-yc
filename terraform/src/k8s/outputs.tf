output "bastion_ip" {
  value = yandex_compute_instance.bastion.network_interface.0.nat_ip_address
}

output "control_plane_ip" {
  value = yandex_compute_instance.master[0].network_interface.0.ip_address
}

output "worker_ips" {
  value = yandex_compute_instance.workers[*].network_interface.0.ip_address
}

# output "Grafana_Network_Load_Balancer_Address" {
#   value = yandex_lb_network_load_balancer.nlb-grafana.listener.*.external_address_spec[0].*.address
#   description = "Адрес сетевого балансировщика для Grafana"
# }

# output "Web_App_Network_Load_Balancer_Address" {
#   value = yandex_lb_network_load_balancer.nlb-web-app.listener.*.external_address_spec[0].*.address
#   description = "Адрес сетевого балансировщика Web App"
# }
