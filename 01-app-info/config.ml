open Mirage

let main =
  foreign "Unikernel.Main"
    ~packages:[package "fmt"]
    ~deps:[abstract app_info]
    job

let () =
  register "app-info" [main]
