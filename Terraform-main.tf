terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone      = "ru-central1-b"
  token     = "y0_AgAAAAAVd9HcAATuwQAAAADn2T11b6GthkG6SxWN5_bdKBXkGRhkf7Y"
  cloud_id  = "b1g347hmvcjnnj95iqfm"
  folder_id = "b1gmvkavm7e36jp24s8s"
}

resource "yandex_compute_instance" "vm-cl1-ans" {

  name                      = "linux-vm"
  allow_stopping_for_update = true
  platform_id               = "standard-v1"
  zone                      = "ru-central1-b"
  hostname                  = "cl1-ans"
  resources {
    cores         = "2"
    memory        = "2"
    core_fraction = "20"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8loi0gfu0v74tm2qst"
    }
  }
  scheduling_policy {
    preemptible = "true"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm2-cl1-ans" {

  name                      = "linux-vm2"
  allow_stopping_for_update = true
  platform_id               = "standard-v1"
  zone                      = "ru-central1-b"
  hostname                  = "cl2-ans"
  resources {
    cores         = "2"
    memory        = "2"
    core_fraction = "20"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8loi0gfu0v74tm2qst"
    }
  }
  scheduling_policy {
    preemptible = "true"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_compute_instance" "vm3-cl1-ans" {

  name                      = "linux-vm3"
  allow_stopping_for_update = true
  platform_id               = "standard-v1"
  zone                      = "ru-central1-b"
  hostname                  = "cl3-ans"
  resources {
    cores         = "2"
    memory        = "2"
    core_fraction = "5"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8loi0gfu0v74tm2qst"
    }
  }
  scheduling_policy {
    preemptible = "true"
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sub1.id
    nat       = true
  }
  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}


resource "yandex_vpc_network" "sub1" {
  name = "ansible"
}

resource "yandex_vpc_subnet" "sub1" {
  name           = "subansible"
  zone           = "ru-central1-b"
  v4_cidr_blocks = ["192.168.10.0/24"]
  network_id     = yandex_vpc_network.sub1.id
}



output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-cl1-ans.network_interface.0.ip_address
}
output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-cl1-ans.network_interface.0.nat_ip_address
}
output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm2-cl1-ans.network_interface.0.ip_address
}
output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm2-cl1-ans.network_interface.0.nat_ip_address
}
