terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.11.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  name  = "nodered"
  image = docker_image.nodered_image.latest
  ports {
    internal = 1880
    external = 1880
  }
}

# The output block is used when you need Terraform to display an output of a given value
# The output will appear after the terraform apply operation, or by running terraform output
# terraform output will work only after a terraform apply has been executed
output "IP-Address" {
  value       = docker_container.nodered_container.ip_address
  description = "The IP address of the container"
}

output "Container-Name" {
  value       = docker_container.nodered_container.name
  description = "The name of the container"
}