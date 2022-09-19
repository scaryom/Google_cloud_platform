# variable "catname" {
#     type = list(string)
#     default = ["https","http"]
  
# }
/*
variable "catname" {
    type = tuple([string,number,bool,list(string)])
    default = [
    "hi",1,false,[ "this","is list ","in tuple" ]]
  
}*/

variable "catname" {
    type = map
    default = {name="john",age=29}
  
}
