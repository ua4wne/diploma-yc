# Создаем группу балансировщика
resource "yandex_lb_target_group" "balancer-group" {
  name       = "balancer-group"
  depends_on = [yandex_compute_instance.master]
  dynamic "target" {
    for_each = yandex_compute_instance.workers
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

# Создаем балансировщик grafana
resource "yandex_lb_network_load_balancer" "nlb-grafana" {
  name = "grafana"
  listener {
    name        = "grafana-listener"
    port        = 80
    target_port = var.k8s_vm.grafana_port
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.balancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = var.k8s_vm.grafana_port
      }
    }
  }
  depends_on = [yandex_lb_target_group.balancer-group]
}

# Создаем балансировщик web-app
resource "yandex_lb_network_load_balancer" "nlb-web-app" {
  name = "web-app"
  listener {
    name        = "web-app-listener"
    port        = 80
    target_port = var.k8s_vm.app_port
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.balancer-group.id
    healthcheck {
      name = "healthcheck"
      tcp_options {
        port = var.k8s_vm.app_port
      }
    }
  }
  depends_on = [yandex_lb_network_load_balancer.nlb-grafana]
}