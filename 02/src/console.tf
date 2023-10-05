##Этот файл для 7 задания!!
#John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks
#format("My first name is %s and my last name is %s and my age is %d", local.test_map.admin, var.last-name, var.age)


locals {

  test_list = ["develop", "staging", "production"]

  test_map = {
    admin = "John"
    user  = "Alex"
  }

  servers = {
    develop = {
      cpu   = 2
      ram   = 4
      image = "ubuntu-21-10"
      disks = ["vda", "vdb"]
    },
    stage = {
      cpu   = 4
      ram   = 8
      image = "ubuntu-20-04"
      disks = ["vda", "vdb"]
    },
    production = {
      cpu   = 10
      ram   = 40
      image = "ubuntu-20-04"
      disks = ["vda", "vdb", "vdc", "vdd"]
    }
  }
}

