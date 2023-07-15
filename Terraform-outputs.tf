output "external_ip_vm1" {
  value = yandex_compute_instance.vm-cl1-ans.network_interface.0.nat_ip_address
}
output "external_ip_vm2" {
  value = yandex_compute_instance.vm2-cl1-ans.network_interface.0.nat_ip_address
}
