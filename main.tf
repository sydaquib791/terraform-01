terraform {
  required_providers {
    local  = { source = "hashicorp/local",  version = "~> 2.5" }
    random = { source = "hashicorp/random", version = "~> 3.6" }
  }
}
 
resource "random_pet" "my_pet" {
  prefix    = "jenkins"
  separator = "-"
  length    = 2
}
 
resource "local_file" "my_pet" {
  filename = "${path.module}/jenkins-pet.txt"
  content  = "Hello from Jenkins! My pet is ${random_pet.my_pet.id}\n"
}
 
output "pet_name" {
  value = random_pet.my_pet.id
}
 
output "file_path" {
  value = local_file.my_pet.filename
}
