import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> data = [];
main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? "8080");

  final router = Router()
    ..post('/profile', (
      Request req,
    ) async {
      final body = await req.readAsString();
      final jsonBody = json.decode(body);
      data.add(jsonBody);
      return Response.ok("data added is true: ");
    })
    ..get("/dispget", (Request req) {
      final jsonBody = json.encode(data);
      return Response.ok(jsonBody);
    })
    ..get('/dispget2/<index>', (Request req, String index) {
      var ii = int.parse(index);
      final jsonBody = json.encode(data[ii]);
      return Response.ok(jsonBody);
    })
    ..delete('/delete/<index>', (Request req, String index) {
      var ii = int.parse(index);
      final jsonBody = json.encode(data.removeAt(ii));
      return Response.ok(jsonBody);
    });

  final server = await serve(router, ip, port);
  print("server is dtarting at http://${server.address.host}:${server.port}");

  return server;
}
