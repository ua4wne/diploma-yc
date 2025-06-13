# Создаем сервисный аккаунт для Terraform
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "sa-diploma"
  description = "for netology diploma"
}

# Выдаем роль editor сервисному аккаунту Terraform
resource "yandex_resourcemanager_folder_iam_member" "service_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}