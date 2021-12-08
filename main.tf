/*
** In this infrastructure, we will install & configure 2 providers, along with docker provider;
** Kubernetes and GCP
** We will deploy the cluster in a GCP compute engine
** The worker node will run a simple nginx docker image here..
** the kubectl deployments can be changed for live.
*/


// this should be in a module for GCP, 
resource "google_compute_instance" "maven_prod_app" {
  name         = "maven-prod-cluster"
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
