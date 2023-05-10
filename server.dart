import 'dart:convert';
import 'dart:io';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/expect.dart';

List<Map> myinfo =[];

void main(List<String> args)async {
   withHotreload(()=>creatServer());
}

void withHotreload(Future<HttpServer> Function() param0) {
} 
 

Future<HttpServer>creatServer() async{

  final ip =InternetAddress.anyIPv4;
final port =int.parse(Platform.environment["PORT"] ?? '8080');
final router = Router()..post('/mylist',(Request req) async{
  final body =await req.readAsString();
  final jsonBody=json.decode(body);
  myinfo.add(jsonBody);
  return Response.ok("add information");
})
..get('/showmylist',(Request req){
final jsonBody=json.encode(myinfo);
return Response.ok(jsonBody);
})
..get('/showmylist/<index>', (Request req, String index){
var i=int.parse(index);
final jsonBody=json.encode(myinfo[i]);
return Response.ok(jsonBody);
})
..delete('deletmylist/<index>', (Request req, String index){
var i=int.parse(index);
final jsonBody=json.encode(myinfo.removeAt(i));
return Response.ok(jsonBody);
});
final server = await serve(router,ip, port);
print("Server start at http://${server.address.host}:${server.port}");
return server;

}






