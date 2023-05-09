import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

// ----Creating an empty list----
List<Map> listmap = []; 
void main(List<String> args)async {
  withHotreload(() => createServer());
 
}
Future<HttpServer> createServer() async{
 final ip =InternetAddress.anyIPv4; 

 final port = int.parse(Platform.environment["PORT"] ?? "8080"); 

 final router = Router()
 // ----Creating an endpoint to add data to the list---
 ..post('/adduser', (Request req)async{ 
  final body =await req.readAsString();
  final Map jsonbody= json.decode(body);
  listmap.add(jsonbody);
  return Response.ok('updated..');
// ----Creating an endpoint to display all data in the list----
 })..get('/users', (Request req){ 
   final jsonbody= json.encode(listmap);
 return Response.ok(jsonbody);
 // ----Creating an endpoint to display one index data----
 })..get('/users<index>', (Request req,String index){ 
   final jsonbody= json.encode(listmap[int.parse(index)]);
 return Response.ok(jsonbody);
 // ----Creating an endpoint to delete one index data----
 })..delete('/deletuser<index>', (Request req,String index){ 
   final jsonbody= json.encode(listmap.removeAt(int.parse(index)));
 return Response.ok("deleted $jsonbody");
 });

 final server =await serve(router, ip, port);

 print("server is starting at http:${server.address.host}:${server.port}");
 return server;
}