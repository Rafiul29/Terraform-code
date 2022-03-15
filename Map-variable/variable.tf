variable "usersage" {
 type= map
 default =   {
     rafiul =23
     islam =12
 }

 }
  //denamically
 variable "username" {
     type = string
}
output "userage" {
    value = "my name is ${var.username} i am ${lookup(var.usersage,"${var.username}")}"
  
}