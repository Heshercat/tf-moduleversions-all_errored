resource "null_resource" "name"
  triggers = {
    trigger = var.var
  }
}

variable "var" {
  default = "String value"
}

output "out" {
  value = var.var
}