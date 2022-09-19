terraform {
  required_version = ">=0.13"
  required_providers {
    google={
        source="hashicorp/google"
        version=">=4.0"
    }
  }
}

provider "google" {
    region = "asia-south1"
      project     = "omprakash-37246"
  credentials = file("omprakash-37246-c0bf75ffce90.json")
  
}