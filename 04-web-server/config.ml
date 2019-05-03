open Mirage

let stack = generic_stackv4 default_network
let data_key = Key.(value @@ kv_ro ~group:"data" ())
let data = generic_kv_ro ~key:data_key "htdocs"
(* set ~tls to false to get a plain-http server *)
let https_srv = http_server @@ conduit_direct ~tls:true stack

let http_port =
  let doc = Key.Arg.info ~doc:"Listening HTTP port." ["http"] in
  Key.(create "http_port" Arg.(opt int 80 doc))

let certs_key = Key.(value @@ kv_ro ~group:"certs" ())
(* some default CAs and self-signed certificates are included in
   the tls/ directory, but you can replace them with your own. *)
let certs = generic_kv_ro ~key:certs_key "tls"

let https_port =
  let doc = Key.Arg.info ~doc:"Listening HTTPS port." ["https"] in
  Key.(create "https_port" Arg.(opt int 443 doc))

let main =
  let packages =
    let pin = "git+https://github.com/roburio/udns.git" in
    [
      package "uri";
      package "magic-mime";
      package ~pin "dns";
      package ~pin "dns-client";
      package ~pin "dns-mirage-client";
      package ~pin:"git+https://github.com/hannesm/ocaml-conduit.git#udns" "mirage-conduit";
    ]
  in
  let keys = List.map Key.abstract [ http_port; https_port ] in
  foreign
    ~packages ~keys
    "Unikernel.HTTPS" (pclock @-> kv_ro @-> kv_ro @-> stackv4 @-> http @-> job)

let stack = generic_stackv4 default_network

let () =
  register "web-server" [main $ default_posix_clock $ data $ certs $ stack $ https_srv]
