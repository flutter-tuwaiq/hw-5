import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

//Part 1: Creating an empty list
List<Map> users = [];

main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? "1234");

  final router = Router()

    //Part 2: Creating an endpoint to add data to the list
    ..post('/editprofile/<index>', (Request req, String index) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);
      users[int.parse(index)] = jsonBody;
      return Response.ok("You have added data to list $index");
    })

    //Part 3: Creating an endpoint to display all data in the list
    ..get('/profile', (Request req) {
      final jsonBody = json.encode(users);
      return Response.ok(jsonBody);
    })

    //Part 4: Creating an endpoint to display one index data in the list
    ..get('/profile/<index>', (Request req, String index) {
      final jsonBody = json.encode(users);
      return Response.ok(jsonBody[int.parse(index)]);
    })

    //Part 5: Creating an endpoint to delete one index data in the list
    ..delete('/profile/<index>', (Request req, String index) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);
      users[int.parse(index)] = jsonBody;
      return Response.ok("You have deleted data from list $index");
    });

  final server = await serve(router, ip, port);
  print("Server strats at http:/${server.address.host} : ${server.port}");

  return server;
}
