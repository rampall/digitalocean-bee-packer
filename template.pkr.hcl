packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.4"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

locals {
  my_token = ""
}

source "digitalocean" "swarm_lightnode" {
  ssh_username = "root"
  api_token    = local.my_token
  image        = "ubuntu-20-04-x64"
  region       = "fra1"
  size         = "s-1vcpu-1gb"
}
build {
  name    = "swarm-lightnode"
  sources = ["source.digitalocean.swarm_lightnode"]
  provisioner "shell" {
    scripts = ["scripts/01-configureBee.sh", "scripts/03-force-ssh-logout.sh", "scripts/90-cleanup.sh", "scripts/99-img-check.sh"]
  }
}

