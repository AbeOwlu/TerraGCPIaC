/*
** GCP/AWS/Azure with Kubernetes
*/

// define the providers for terraform to download and install
terraform {
  //backend "remote" {
  //organization    " "
  //worksapce{ name = ""}

  required_providers {
    google {
      source  = "hashicorp/google"
      version = "~> 3.0.0"
    }

    Kubernetes {
      source  = "hashicorp/kubernetes"
      version = "~>"
    }

    docker {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

// this should be in a module for GCP, Implemented later 
// and other moldules for AWS, Azure... will be implemented and used later as well.

// Configure the providers -GCP, Kubes, and Docker
provider "google" {
  project = var.project_id
  region  = var.google_region
  zone    = var.google_zone
}

provider "kubernetes" {
  version     = "value"
  config_path = var.kube_config
}

provider "docker" {

}
