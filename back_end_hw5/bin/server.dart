import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

// -- Part 1: Creating an empty list --
List<Map> myList = [];

main() async {
  withHotreload(() => createServer(), logLevel: Level.INFO);
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? '8080');
  final router = Router()

// -- Part 2: Creating an endpoint to add data to the list --
    ..post('/profile', (
      Request req,
    ) async {
      final body = await req.readAsString();
      final jsonBody = json.decode(body);
      myList.add(jsonBody);
      return Response.ok("data added");
    })
// -- Part 3: Creating an endpoint to display all data in the list --
    ..get("/profile", (Request req) {
      final jsonBody = json.encode(myList);
      return Response.ok(jsonBody);
    })

// -- Part 4: Creating an endpoint to display one index data in the list --
    ..get('/display/<index>', (Request req, String index) {
      var i = int.parse(index);
      final jsonBody = json.encode(myList[i]);
      return Response.ok(jsonBody);
    })

// -- Part 5: Creating an endpoint to delete one index data in the list --
    ..delete('/delete/<index>', (Request req, String index) {
      var i = int.parse(index);
      final jsonBody = json.encode(myList.removeAt(i));
      return Response.ok(jsonBody);
    });

  final server = await serve(router, ip, port);

  print("Server starting at http://${server.address.host}:${server.port}");

  return server;
}
