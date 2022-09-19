resource "random_integer" "rand_int" {
    min=10
    max=300
    lifecycle {
      create_before_destroy=true
    }
  
}

resource "random_integer" "rand_int1" {
    min=10
    max=200
    lifecycle {
      prevent_destroy=false
    }
  
}

resource "random_integer" "rand_int2" {
    min=10
    max=30
    lifecycle {
      ignore_changes=[max,min]
    }
  
}
