# terraform {
#  required_version = "1.9.6"
# }

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8200
      external = 8300
      protocol = "tcp-ip"
    }
  ]
}

resource "null_resource" "check_ip" {
  triggers = {
    current_time = timestamp()
  }
  provisioner "local-exec" {
    command = "curl -s https://ifconfig.me/ip > ip.txt"
  }
}

data "local_file" "read_ip" {
  depends_on = [null_resource.check_ip]
  filename   = "./ip.txt"
}

output "scalr_ip" {
  value = "Current instance IP is: ${data.local_file.read_ip.content}\nDocker ports information is: ${jsonencode(var.docker_ports)} The end"
}
