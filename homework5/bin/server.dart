import 'dart:convert';
 import 'dart:io';

 import 'package:shelf/shelf.dart';
 import 'package:shelf/shelf_io.dart';
 import 'package:shelf_router/shelf_router.dart';


 List<Map> nameOfList = [];

 void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

// Configure routes.
  final router  = Router()
  ..post('/profile',(Request req, ) async {
     final body = await req.readAsString();
     final jsonBody = json.decode(body);
     nameOfList.add(jsonBody);
     return Response.ok("some data added");
    })
    //------here is editprofile-----
     ..get("/editporfile", (Request req){
       final jsonBody = json.encode(nameOfList);
       return Response.ok(jsonBody);
     })
     //------here is show-----
     ..get('/showdata/<index>' , (Request req, String index){
         var i = int.parse(index);
         final jsonBody = json.encode(nameOfList[i]);
         return Response.ok(jsonBody);
     })
     //--------delete here------------
     ..delete('/delete/<index>', (Request req, String index){
       var i = int.parse(index);
       final jsonBody = json.encode(nameOfList.removeAt(i));
       return Response.ok(jsonBody);
     });

  final server = await serve(router,ip,port);
  print("Server starting at http://${server.address.host}:${server.port}");
 }