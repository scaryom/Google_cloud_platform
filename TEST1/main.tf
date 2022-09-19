terraform {
    required_version = ">=0.13"
    required_providers {
      google ={
          source="hashicorp/google"
          version=">=4.0"
      }
    }
}

provider "google" {
    region = "location"
    project = "project_id"
    credentials = file("service_file")
  
}

# resource "local_file" "t1" {
#     filename = "t1.txt"
#     content_base64 = 1001
   
# }

# resource "random_integer" "int1" {
#     min=10
#     max=15
  
# }
# output "out1" {
#     value = random_integer.int1.result
  
# }

# resource "random_password" "pass1" {
#     length = 10
  
# }
# output "passout1" {
#     sensitive = true
#     value = random_password.pass1.result
  
# }

resource "local_file" "f1" {
    filename = var.filename
    content = var.content
  
}
/*
resource "local_file" "f2" {
    filename = "cat.txt"
    content = var.catname[3][0]
}*/

resource "local_file" "f3" {
    filename = "cat.txt"
    content = var.catname["name"]
  
}