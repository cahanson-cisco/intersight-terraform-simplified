resource "intersight_vnic_eth_network_policy" "access_mode" {
  name = "access_mode"
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

  vlan_settings {
    object_type  = "vnic.VlanSettings"
    default_vlan = 0
    mode         = "ACCESS"
  }
}
