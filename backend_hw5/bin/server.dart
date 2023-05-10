import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> listmaps = [];

main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? '8080');

  final router = Router()

    //------- here is Get profile -----
    ..get('/profile', (Request req) {
      final jsonBody = json.encode(listmaps);
      return Response.ok(jsonBody);
    })

    //------- here is Get by index  -----
    ..get('/profilebyindex/<index>', (Request req, String index) {
      int i = int.parse(index);
      final jsonBody = json.encode(listmaps[i]);
      return Response.ok(jsonBody);
    })

    //------- here is post edit profile -----
    ..post('/editprofile', (Request req) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);
      bool update = false;

      if (jsonBody.containsKey("name") &&
          jsonBody.containsKey("age") &&
          jsonBody.containsKey("mobile_number") &&
          jsonBody.containsKey("city")) {
        update = true;
      }

      if (update == true) {
        listmaps.add(jsonBody);
        return Response.ok("updated ...");
      } else {
        return Response.ok(" there is not any update");
      }
    })

    //------- here is delete by index -----
    ..delete('/delete/<index>', (Request req, String index) {
      int i = int.parse(index);
      final jsonBody = json.encode(listmaps.removeAt(i));
      return Response.ok(jsonBody);
    });

  final server = await serve(router, ip, port);
  print("Server starting at http://${server.address.host}:${server.port}");

  return server;
}


/* [{
 "name" : "maali", 
 "age" : "22",
 "mobile_number" : "96687",
 "city" : "Riyadh"

},
{
 "name" : "amal", 
 "age" : "20",
 "mobile_number" : "96655",
 "city" : "Riyadh"

}, 
{
 "name" : "alkhaldi", 
 "age" : "9884",
 "mobile_number" : "96688",
 "city" : "Riyadh"
}]*/