terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    ansible = {
      source  = "ansible/ansible"
      version = "~> 1.1.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "openssh-server" {
  name         = "lscr.io/linuxserver/openssh-server:latest"
  keep_locally = true
}

resource "docker_container" "openssh-server" {
  image = docker_image.openssh-server.image_id
  name  = "tutorial"

  env = [
    "SUDO_ACCESS=true",
    "PASSWORD_ACCESS=true",
    "USER_PASSWORD=password",
    "USER_NAME=admin"
  ]

  ports {
    internal = 2222
    external = 2222
    ip       = "127.0.0.1"
  }
}

resource "terraform_data" "playbook" {
  depends_on = [docker_container.openssh-server]

  connection {
    type     = "ssh"
    user     = "admin"
    password = "password"
    host     = "127.0.0.1"
    port     = "2222"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apk add ansible",
      "mkdir ~/ansible"
    ]
  }

  provisioner "file" {
    source      = "../ansible/playbook.yml"
    destination = "/config/ansible/playbook-df.yml"
  }

}

resource "terraform_data" "ansible" {
  depends_on = [terraform_data.playbook]

  connection {
    type     = "ssh"
    user     = "admin"
    password = "password"
    host     = "127.0.0.1"
    port     = "2222"
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook /config/ansible/playbook-df.yml"
    ]
  }

}

# resource "ansible_playbook" "playbook" {
#   playbook   = "playbook-df.yml"
#   name       = "127.0.0.1"
#   replayable = true

#   extra_vars = {
#     hosts = "127.0.0.1"
#   }
# }
