terraform {
  backend "local" {
    path = "/backup/gcp-project1/terraform.tfstate"
  }
}