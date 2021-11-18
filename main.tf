/*
** In this infrastructure, we will install & configure 2 providers, along with docker provider;
** Kubernetes and GCP
** We will deploy the cluster in a GCP compute engine
** The worker node will run a simple nginx docker image here..
** the kubectl deployments can be changed for live.
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
  project = "{{project-id}}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

provider "kubernetes" {
  version = "value"
}
provider "docker" {

}

// this should be in a module for GCP, 
resource "google_compute_instance" "maven_prod_app_cluster" {
  name         = "maven-prod-kubctl"
  machine_type = "f1.micro"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }
  network_interface {
    network = "declared-vpc-resources"
  }
}

resource "docker_image" "maven_prod_app" {
  name         = "nginx:latest"
  keep_locally = false

}

resource "docker_container" "maven_prod_app" {
  image = docker_image.maven_prod_app.latest
  name  = "Web app container image"
  ports {
    internal = 80
    external = 8080
  }

}
