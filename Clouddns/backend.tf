terraform {
  backend "local" {
    path = "/backup/clouddns/terraform.tfstate"
  }
}