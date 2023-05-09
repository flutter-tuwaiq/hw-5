import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> infoList = [];

void main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final router = Router()

    // ------------- post | add -------------
    ..post('/add', (Request req) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);

      infoList.add(jsonBody);

      return Response.ok("The new data has been added successfully");
    })

    // ------------- get | display -------------
    ..get('/display', (Request req) {
      final jsonBody = json.encode(infoList);
      return Response.ok(jsonBody);
    })

    // ------------- get | display index -------------
    ..get('/displayIndex/<index>', (Request req, String index) {
      int indexInt = int.parse(index);
      final jsonBody = json.encode(infoList[indexInt]);

      return Response.ok(jsonBody);
    })

    // ------------- delete | delete index -------------
    ..delete('/delete/<index>', (Request req, String index) {
      int indexInt = int.parse(index);

      final jsonBody = json.encode(infoList.removeAt(indexInt));
      return Response.ok("$jsonBody ... has been deleted");
    });

  final server = await serve(router, ip, port);

  print("server is starting at: http://${server.address.host}:${server.port}");

  return server;
}
