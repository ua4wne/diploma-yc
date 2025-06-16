resource "yandex_vpc_network" "k8s-net" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.k8s-net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "public-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.k8s-net.id
  v4_cidr_blocks = ["10.0.2.0/24"]
  route_table_id = yandex_vpc_route_table.rt-nat.id
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = "public-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.k8s-net.id
  v4_cidr_blocks = ["10.0.3.0/24"]
  route_table_id = yandex_vpc_route_table.rt-nat.id
}

resource "yandex_vpc_subnet" "subnet-d" {
  name           = "public-d"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.k8s-net.id
  v4_cidr_blocks = ["10.0.4.0/24"]
  route_table_id = yandex_vpc_route_table.rt-nat.id
}