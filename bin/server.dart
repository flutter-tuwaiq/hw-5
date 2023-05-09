import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';


List<Map> info = [];

void main(List<String> args) async {
 final ip = InternetAddress.anyIPv4;
 final port = int.parse(Platform.environment['PORT'] ?? '8080');


 final router  = Router()
 ..post('/profile',(Request req, ) async {
    final body = await req.readAsString();
    final jsonBody = json.decode(body);
    info.add(jsonBody);
    return Response.ok("data added successfully...");
   })
    ..get("/displayprofile", (Request req){
      final jsonBody = json.encode(info);
      return Response.ok(jsonBody);
      
    })
    ..get('/displayindex/<index>' , (Request req, String index){
        var i = int.parse(index);
        final jsonBody = json.encode(info[i]);
        return Response.ok(jsonBody);
    })
    ..delete('/deleteindex/<index>', (Request req, String index){
      var i = int.parse(index);
      final jsonBody = json.encode(info.removeAt(i));
      return Response.ok(jsonBody);
    });
    
  


 final server = await serve(router,ip,port);
 print("Server starting at http://${server.address.host}:${server.port}");
}
