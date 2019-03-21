
module Main = struct

  let start info =
    let {Mirage_info. name; packages; libraries} = info in
    Logs.app (fun m -> m
                 "name = %s@.\
                  packages = %a@.\
                  libraries = %a@."
                 name
                 Fmt.(Dump.list @@ pair ~sep:(const char '.') string string) packages
                 Fmt.(Dump.list string) libraries) ;
    Lwt.return_unit

end
