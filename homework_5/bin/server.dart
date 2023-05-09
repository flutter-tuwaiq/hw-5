import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

List<Map> myList = [];

final _router = Router()
  ..get('/read', readHandler)
  ..get('/read/<index>', readByIndexHandler)
  ..post('/create', createHandler)
  ..delete('/delete/<index>', deleteHandler);

Response readHandler(Request req) {
  final jsonBody = json.encode(myList);
  return Response.ok(jsonBody);
}

Response readByIndexHandler(Request req, String index) {
  final jsonBody = json.encode(myList[int.parse(index)]);
  return Response.ok(jsonBody);
}

Future<Response> createHandler(Request req) async {
  final body = await req.readAsString();
  final Map jsonBody = json.decode(body);

  if (jsonBody.containsKey('name') &&
      jsonBody.containsKey('age') &&
      jsonBody.containsKey('mobile_number') &&
      jsonBody.containsKey('city')) {
    myList.add({
      "name": "${jsonBody['name']}",
      "age": "${jsonBody['age']}",
      "mobile_number": "${jsonBody['mobile_number']}",
      "city": "${jsonBody['city']}"
    });
  }

  return Response.ok('$jsonBody added successfully!');
}

Response deleteHandler(Request req, String index) {
  final jsonBody = json.encode(myList[int.parse(index)]);
  myList.removeAt(int.parse(index));
  return Response.ok(jsonBody);
}

void main(List<String> args) async {
  injectList();
  final ip = InternetAddress.anyIPv4;
  //final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_router, ip, port);
  print(
      'Server listening on port http://${server.address.host}:${server.port}');
}

injectList() {
  myList.add({
    "name": "ahmad",
    "age": "24",
    "mobile_number": "0544632707",
    "city": "riyadh"
  });
  myList.add({
    "name": "nawaf",
    "age": "25",
    "mobile_number": "0512345678",
    "city": "jeddah"
  });
  myList.add({
    "name": "fahad",
    "age": "29",
    "mobile_number": "0587654321",
    "city": "dammam"
  });
}
