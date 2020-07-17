output "bastion_public_ip" {
  value = module.bastion.public_ip_address
}
output "app_ip" {
          value = module.jenkins.network_interface_private_ip
}
output "db_ip" {
          value = module.chef.network_interface_private_ip
}

