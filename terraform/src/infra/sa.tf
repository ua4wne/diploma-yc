# Создаем сервисный аккаунт для Terraform
resource "yandex_iam_service_account" "sa_diploma" {
  folder_id = var.folder_id
  name      = "sa_diploma"
  description = "for netology diploma"
}

# Выдаем роль editor сервисному аккаунту Terraform
resource "yandex_resourcemanager_folder_iam_member" "service_editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa_diploma.id}"
}