import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
// ignore: depend_on_referenced_packages
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  List<Map> myinfo = [
    {"name": "", "phone": "", "cite": "", "poseshin": ""},
    {"name": "", "phone": "", "cite": "", "poseshin": ""},
    {"name": "", "phone": "", "cite": "", "poseshin": ""}
  ];
  final router = Router()
    ..get("/profail", (Request req) {
      final jesonbode = json.encode(myinfo);

      return Response.ok(jesonbode);
    })
    ..post("/edit_profail/<index>", (Request req, String index) async {
      final body = await req.readAsString();
      final Map jesonbode = json.decode(body);
      if (jesonbode.containsKey("name")) {
        myinfo[int.parse(index)]["name"] = jesonbode["name"];
        return Response.ok("update name.......");
      }
      if (jesonbode.containsKey("phone")) {
        myinfo[int.parse(index)]["phone"] = jesonbode["phone"];
        return Response.ok("update name.......");
      }
      if (jesonbode.containsKey("cite")) {
        myinfo[int.parse(index)]["cite"] = jesonbode["cite"];
        return Response.ok("update name.......");
      }
      if (jesonbode.containsKey("poseshin")) {
        myinfo[int.parse(index)]["poseshin"] = jesonbode["poseshin"];
        return Response.ok("update name.......");
      }

      return Response.ok("not updare  !!! ");
    });

  final ip = InternetAddress.anyIPv4;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await serve(router, ip, port);
  print(' flooss  http://${server.address.host}:${server.port}');

  return server;
}
