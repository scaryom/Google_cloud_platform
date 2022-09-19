terraform {
  backend "local" {
    path = "/backup/terraform.tfstate"
  }
}