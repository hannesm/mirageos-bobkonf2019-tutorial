open Mirage

let url =
  let doc = Key.Arg.info ~doc:"URL to fetch" ["url"] in
  Key.(create "url" Arg.(opt string "https://nqsb.io" doc))

let client =
  let packages =
    let pin = "git+https://github.com/roburio/udns.git" in
    [
      package ~pin "udns";
      package ~pin "udns-client";
      package ~pin "udns-mirage-client";
      package ~pin:"git+https://github.com/hannesm/ocaml-conduit.git#udns" "mirage-conduit";
      package "cohttp-mirage";
      package "duration" ;
      package ~sublibs:["mirage"] "tls"
    ] in
  foreign
    ~keys:[Key.abstract url]
    ~packages
    "Unikernel.Client" @@ time @-> resolver @-> conduit @-> job

let () =
  let stack = generic_stackv4 default_network in
  let res_dns = resolver_dns stack in
  let conduit = conduit_direct stack in
  let job =  [ client $ default_time $ res_dns $ conduit ] in
  register "web-client" job
