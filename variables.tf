##############################################################################
# Variables
##############################################################################

variable "ibmcloud_api_key" {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources."
  type        = string
  sensitive   = true
}

variable "iaas_classic_username" {
  description = "The IBM Cloud username for the creation of classic resources."
  type        = string
  sensitive   = true
}

variable "iaas_classic_api_key" {
  description = "The IBM Cloud API Key for the creation of classic resources."
  type        = string
  sensitive   = true
}

variable "region" {
  description = "IBM Cloud Region where resources will be provisioned"
  type        = string
  default     = "us-south"
  validation {
    error_message = "Region must be in a supported IBM VPC region."
    condition     = contains(["us-south", "us-east", "br-sao", "ca-tor", "eu-gb", "eu-de", "eu-es", "jp-tok", "jp-osa", "au-syd"], var.region)
  }
}

variable "prefix" {
  description = "Name prefix that will be prepended to named resources"
  type        = string
  default     = "pfg-poc"
  validation {
    error_message = "Prefix must begin with a lowercase letter and contain only lowercase letters, numbers, and - characters. Prefixes must end with a lowercase letter or number and be 16 or fewer characters."
    condition     = can(regex("^([a-z]|[a-z][-a-z0-9]*[a-z0-9])", var.prefix)) && length(var.prefix) <= 16
  }
}

variable "ssh_key_public_key" {
  description = "Public SSH Key Value for SSH Key"
  type        = string
  sensitive   = true
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTZzoizcpWPyt6Y8/4ZoBk4PRRB0bWkKmJlOqoqgGv1HyUm1YGryErs9kyHV7v/YEk2xG1UxAjZPps59zyKAjfbn1iO3g8gjCRP7PlBWPnhk5fE00mOn5+witucAArdLh9Qg0Hvm6+AsoAcqHXTai3xvWtVwG0GkC7aLrNZtQYKuEBDj8AWLb2GWqEdMf9aquCuDHJJatTFlFE2w4cn1nFLs6cXxH1WLACx/K7nI6fg383ZVFqweOZkkAKz836SActkC35TcjrtvyTpkCEyBe3r854an6HIwLYnBjlbdZK0b4JYj+kngILKdHrHskrADRv46XzaGvBCqQIDQzsDc0pjuW1c4TrPt19I10W0kNTJ8LyK/EanBn3nuNbu8skhBeb7isKlfqS0nEjT9DM84T2ib3Gb+rZyApqdoytSuxO6+A8EzSGtoCIWeIIpJlA8MVJIWLpuWCoNIajZSj5U5MoTXAbJytRZ0rjnSWLXGoX4MlwC2oK9Q0Drt1yg9/diROD/EJXszc0GaXGre0/IffcM/b1X2DHDwkhsqbycRnWpF6idGhmXQbLXNHfnZ6+LQc53JFrZe3wu5EusKFqkSDvU0AdzT5W9TzauXjCKlbcPjiMHV3llyD04ycLmpGEPfS3azXrW3jFzH7Tuh1BT7Z6A1TGyD0W16aFH81CsdxbEQ== %"
  validation {
    error_message = "Public SSH Key must be a valid ssh rsa public key."
    condition     = "${var.ssh_key_public_key == null || can(regex("ssh-rsa AAAA[0-9A-Za-z+/]+[=]{0,3} ?([^@]+@[^@]+)?", var.ssh_key_public_key))}"
  }
}

variable "power_prod_prod_ssh_key_key" {
  description = "Prod prod ssh key public key value"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTZzoizcpWPyt6Y8/4ZoBk4PRRB0bWkKmJlOqoqgGv1HyUm1YGryErs9kyHV7v/YEk2xG1UxAjZPps59zyKAjfbn1iO3g8gjCRP7PlBWPnhk5fE00mOn5+witucAArdLh9Qg0Hvm6+AsoAcqHXTai3xvWtVwG0GkC7aLrNZtQYKuEBDj8AWLb2GWqEdMf9aquCuDHJJatTFlFE2w4cn1nFLs6cXxH1WLACx/K7nI6fg383ZVFqweOZkkAKz836SActkC35TcjrtvyTpkCEyBe3r854an6HIwLYnBjlbdZK0b4JYj+kngILKdHrHskrADRv46XzaGvBCqQIDQzsDc0pjuW1c4TrPt19I10W0kNTJ8LyK/EanBn3nuNbu8skhBeb7isKlfqS0nEjT9DM84T2ib3Gb+rZyApqdoytSuxO6+A8EzSGtoCIWeIIpJlA8MVJIWLpuWCoNIajZSj5U5MoTXAbJytRZ0rjnSWLXGoX4MlwC2oK9Q0Drt1yg9/diROD/EJXszc0GaXGre0/IffcM/b1X2DHDwkhsqbycRnWpF6idGhmXQbLXNHfnZ6+LQc53JFrZe3wu5EusKFqkSDvU0AdzT5W9TzauXjCKlbcPjiMHV3llyD04ycLmpGEPfS3azXrW3jFzH7Tuh1BT7Z6A1TGyD0W16aFH81CsdxbEQ== %"
}

variable "classic_classic_ssh_key_public_key" {
  description = "Public SSH Key Value for classic SSH Key classic ssh key"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDTZzoizcpWPyt6Y8/4ZoBk4PRRB0bWkKmJlOqoqgGv1HyUm1YGryErs9kyHV7v/YEk2xG1UxAjZPps59zyKAjfbn1iO3g8gjCRP7PlBWPnhk5fE00mOn5+witucAArdLh9Qg0Hvm6+AsoAcqHXTai3xvWtVwG0GkC7aLrNZtQYKuEBDj8AWLb2GWqEdMf9aquCuDHJJatTFlFE2w4cn1nFLs6cXxH1WLACx/K7nI6fg383ZVFqweOZkkAKz836SActkC35TcjrtvyTpkCEyBe3r854an6HIwLYnBjlbdZK0b4JYj+kngILKdHrHskrADRv46XzaGvBCqQIDQzsDc0pjuW1c4TrPt19I10W0kNTJ8LyK/EanBn3nuNbu8skhBeb7isKlfqS0nEjT9DM84T2ib3Gb+rZyApqdoytSuxO6+A8EzSGtoCIWeIIpJlA8MVJIWLpuWCoNIajZSj5U5MoTXAbJytRZ0rjnSWLXGoX4MlwC2oK9Q0Drt1yg9/diROD/EJXszc0GaXGre0/IffcM/b1X2DHDwkhsqbycRnWpF6idGhmXQbLXNHfnZ6+LQc53JFrZe3wu5EusKFqkSDvU0AdzT5W9TzauXjCKlbcPjiMHV3llyD04ycLmpGEPfS3azXrW3jFzH7Tuh1BT7Z6A1TGyD0W16aFH81CsdxbEQ== %"
}

variable "no_vsrx" {
  description = "When true, will not create VSRX router or GRE tunnels"
  type        = bool
  default     = false
}

##############################################################################
