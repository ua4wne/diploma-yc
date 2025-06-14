resource "local_file" "hosts_cfg_kubespray" {
  count = var.get_hosts ? 1 : 0 # Если get_hosts false, ресурс не создается

  content  = templatefile("${path.module}/hosts.tftpl", {
    workers = yandex_compute_instance.workers
    masters = yandex_compute_instance.master
  })
  filename = "../../ansible/hosts.yaml"
}