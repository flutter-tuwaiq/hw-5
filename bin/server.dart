import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> users = [
  {
    "name": "Ali",
    "address": "Riyadh",
    "phone": 966538382983,
  },
  {
    "name": "Saad",
    "address": "Khobar",
    "phone": 966522098987,
  },
  {
    "name": "Omar",
    "address": "Jeddah",
    "phone": 966526773944,
  }
];

main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? "8888");

  final router = Router()
    ..get('/profile', (Request req) {
      final jsonBody = json.encode(users);
      return Response.ok(jsonBody);
    })
    ////////////////EDIT PROFILE///////////////////
    ..post('/editprofile/<index>', (Request req, String index) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);
      bool update = false;
      if (jsonBody.containsKey('name')) {
        users[int.parse(index)]["name"] = jsonBody["name"];
        update = true;
      }
      if (jsonBody.containsKey('address')) {
        users[int.parse(index)]["address"] = jsonBody["address"];
        update = true;
      }
      if (jsonBody.containsKey('phone')) {
        users[int.parse(index)]["phone"] = jsonBody["phone"];
        update = true;
      }
      if (update == true) {
        return Response.ok("Updated");
      } else {
        return Response.ok("There is no updates");
      }
    });

  final server = await serve(router, ip, port);
  print("Server strars at http:/${server.address.host} : ${server.port}");

  return server;
}
