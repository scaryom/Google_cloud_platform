terraform {
  backend "local" {
    path = "/backup/gcp-project2/terraform.tfstate"

  }
}