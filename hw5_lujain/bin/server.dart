import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> myList = [];

main(List<String> args) async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  final ip = 'localhost';
  final port = int.parse(Platform.environment["PORT"] ?? '8080');
  final router = Router()
    ..post('/addToList', (Request req) async {
      final body = await req.readAsString();
      final Map jsonBody = json.decode(body);

      if (jsonBody.containsKey('name') &&
          jsonBody.containsKey('age') &&
          jsonBody.containsKey('mobile_number') &&
          jsonBody.containsKey('city')) {
        myList.add({
          "name": '${jsonBody['name']}',
          "age": '${jsonBody['age']}',
          "mobile_number": '${jsonBody['mobile_number']}',
          "city": '${jsonBody['city']}'
        });
      }

      return Response.ok('added successfully $jsonBody');
    })
    ..get('/displayList', (Request req) {
      final jsonBody = json.encode(myList);

      return Response.ok(jsonBody);
    })
    ..get('/displayListByIndex/<index>', (Request req, String index) async {
      final jsonBody = json.encode(myList[int.parse(index)]);

      return Response.ok(jsonBody);
    })
    ..delete('/deleteByIndex/<index>', (Request req, String index) async {
      final jsonBody = json.encode(myList.removeAt(int.parse(index)));
      return Response.ok("$jsonBody deleted, new list is : $myList");
    });

  final server = await serve(router, ip, port);

  print("http://${server.address.host}:${server.port}");

  return server;
}
