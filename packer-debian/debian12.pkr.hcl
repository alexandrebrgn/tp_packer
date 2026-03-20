packer {
  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = ">= 1.0.0"
    }
  }
}

variable "vm_name" { default = "debian13-packer" }
variable "output_dir" { default = "output-debian13" }

source "qemu" "debian12" {
  iso_url      = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-13.4.0-amd64-netinst.iso"
  iso_checksum = "sha256:0b813535dd76f2ea96eff908c65e8521512c92a0631fd41c95756ffd7d4896dc"

  output_directory = var.output_dir
  vm_name          = var.vm_name

  accelerator      = "none"
  disk_size        = 20480
  memory           = 1024
  cpus             = 2

  http_directory   = "http"

  ssh_username     = "vagrant"
  ssh_password     = "vagrantpw"
  ssh_timeout      = "30m"

  boot_wait        = "5s"
  boot_command = [
    "<tab><wait>",
    "auto=true priority=critical preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ---",
    "<enter>"
  ]

  shutdown_command = "sudo shutdown -P now"
}

build {
  sources = ["source.qemu.debian12"]

  provisioner "shell" {
    script = "scripts/setup.sh"
  }
}