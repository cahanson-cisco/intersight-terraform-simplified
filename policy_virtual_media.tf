variable "httpiso" {
  type = object({
    url      = string
    username = string
    password = string
  })
  default = {
    # url should be in the format of https://host.domain.com/path/file.iso with EITHER http or https 
    url      = "https://host.local/path/file.iso"
    username = ""
    password = ""
  }
}

resource "intersight_vmedia_policy" "vmedia_http_iso" {
  name = "vmedia_iso"
  dynamic "tags" {
    for_each = local.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }
  organization {
    moid = local.organization
  }

  enabled       = true
  encryption    = true
  low_power_usb = true

  mappings {
    authentication_protocol = "none"
    device_type             = "cdd"
    file_location           = var.httpiso.url
    mount_protocol          = lower(element(split(":", var.httpiso.url), 0))
    password                = var.httpiso.password
    username                = var.httpiso.username
    volume_name             = "IMC_DVD"
  }

}
