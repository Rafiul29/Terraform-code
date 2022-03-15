variable users {
    type = list
    default = ["Rafiul","bappy"]
}

output printfirst {
   // value = "first user is ${var.users[1]}"
  value = " ${join(",",var.users)}"
}

output helloworldupper {

  value = "${upper(var.users[1])}"
}

output hellowordlower {

  value = "${lower(var.users[0])}"
}