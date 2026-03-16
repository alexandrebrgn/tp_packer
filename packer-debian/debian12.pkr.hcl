# PACKER
packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.0.0"
    }
  }
}

# VARIABLES
variable "vm_name" { default = "debian12-base" }
variable "output_dir" { default = "output-debian12" }

# SOURCE QEMU
source "qemu" "debian12" {
  iso_url        = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.6.0-amd64-netinst.iso"
  iso_checksum   = "sha256:0f3a4d3b8c9e2f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4"

  output_directory = var.output_dir
  vm_name          = var.vm_name

  accelerator      = "kvm"
  disk_size        = 20480
  memory           = 1024
  cpus             = 2

  http_directory   = "http"

  ssh_username     = "vagrant"
  ssh_password     = "vagrantpw"
  ssh_timeout      = "30m"

  boot_wait        = "5s"
  boot_command = [
    "<esc><wait>",
    "auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
    "<enter>"
  ]

  shutdown_command = "sudo shutdown -P now"
}

# BUILD
build {
  sources = ["source.qemu.debian12"]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}
