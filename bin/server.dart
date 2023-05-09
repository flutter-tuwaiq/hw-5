import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

// List: to store the values from server (database)
List<Map> userInfo = [];
// Counter id

void main(List<String> args) async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final int port = int.parse(Platform.environment['PORT'] ?? '8080');

  final Router router = Router()

// ________________POST: Add profile___________________________________
    ..post('/addprofile/', (Request req) async {
      final body = await req.readAsString();
      final Map jasonBody = json.decode(body);
      bool add = false;
 
      // Check if jasonBody contains all data
      if (jasonBody.containsKey("name") &&
          jasonBody.containsKey("age") &&
          jasonBody.containsKey("mobile_number") &&
          jasonBody.containsKey("city")) {
        userInfo.add(jasonBody);

        add = true;
      }
      if (add == true) {
        return Response.ok("User Added...");
      } else {
        return Response.ok("Failed to Add");
      }
    })

    // __________________GET: Desplay all_________________________
    ..get('/profile', (Request req) {
      final jsonBody = jsonEncode(userInfo);
      return Response.ok(jsonBody);
    })

    // ___________________GET: Desplay By Index_____________________
    ..get('/profile/<id>', (Request req, String id) {
      if (int.parse(id) <= userInfo.length) {
        final jsonBody = jsonEncode(userInfo[int.parse(id)]);
        return Response.ok(jsonBody);
      } else {
        return Response.notFound(
            "the user isn't found, please enter a correct id");
      }
    })

    // ___________________DELETE: Delete By Index_____________________
    ..delete('/deleteprofile/<id>', (Request req, String id) {
      if (int.parse(id) < userInfo.length) {
        final jsonBody = jsonEncode(userInfo.removeAt(int.parse(id)));
        return Response.ok(jsonBody);
      } else {
        return Response.notFound(
            "the user isn't found, please enter a correct id");
      }
    });

  final server = await serve(router, ip, port);

  print("Server starting at http://${server.address.host}:${server.port}");

  return server;
}
