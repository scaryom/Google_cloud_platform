resource "random_string" "rand_name" {
    length=10
}

resource "local_file" "file1" {
    filename = "dj.txt"
    content="mixed file value: ${random_string.rand_name.id}"
    depends_on = [
      random_string.rand_name
    ]
}

output "o1" {
    value = local_file.file1
    sensitive = true
}