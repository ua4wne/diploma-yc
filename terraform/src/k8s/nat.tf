resource "yandex_vpc_gateway" "nat-gateway" {
  folder_id = var.folder_id
  name      = "k8s-nat-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt-nat" {
  folder_id  = var.folder_id
  name       = "rt-nat"
  network_id = yandex_vpc_network.k8s-net.id
  depends_on = [yandex_vpc_network.k8s-net]

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat-gateway.id
  }
}
