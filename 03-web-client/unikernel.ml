open Lwt.Infix
open Mirage_types_lwt

module Client (T: TIME) (RES: Resolver_lwt.S) (CON: Conduit_mirage.S) = struct

  let http_fetch resolver conduit =
    let uri = Uri.of_string (Key_gen.url ()) in
    Logs.info (fun m -> m "fetching %a" Uri.pp_hum uri) ;
    let ctx = Cohttp_mirage.Client.ctx resolver conduit in
    Cohttp_mirage.Client.get ~ctx uri >>= fun (response, body) ->
    Cohttp_lwt.Body.to_string body >>= fun body ->
    Logs.info (fun m -> m "%a" Sexplib.Sexp.pp_hum (Cohttp.Response.sexp_of_t response)) ;
    Logs.info (fun m -> m "Received body length: %d" (String.length body)) ;
    Logs.debug (fun m -> m "%s" body) ;
    Lwt.return_unit

  let start _time resolver conduit =
    Conduit_mirage.with_tls conduit >>= fun conduit ->
    http_fetch resolver conduit
end
