import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';




  //Creating an empty list
List<Map> list = [];

void main(List<String> args) {
  withHotreload(() => createServer());

}


Future<HttpServer> createServer() async {
 final ip = InternetAddress.anyIPv4;
 final port = int.parse(Platform.environment["PORT"] ?? '8080');
 final router = Router()

    //Creating an endpoint to add data to the list
 ..post("/add", (Request request) async {
          try {
            final body = await request.readAsString();
            final Map jsonBody = json.decode(body);
            list.add(jsonBody);
          return Response.ok("Added successfully");

          } catch (e) {
              return Response.badRequest();
          }
          
  })

    //Creating an endpoint to display all data in the list
 ..get("/displayAll", (Request request) {

      final JsonBody = json.encode(list);
      return Response.ok(JsonBody);
 })

    //Creating an endpoint to display one index data in the list
 ..get("/display/<index>", (Request request , String index) {

      try {
          int _index = int.parse(index);
          if (checkIndex(_index)) {
          return Response.notFound("The index is not exist");
      } else {
          final JsonBody = json.encode(list[_index]);
          return Response.ok(JsonBody);
      }
      } catch (e) {
          return Response.badRequest();
      }
})

      //Creating an endpoint to delete one index data in the list
  ..delete("/Delete/<index>", (Request request , String index){

      try {
          int _index = int.parse(index);
          if (checkIndex(_index)) {
            return Response.notFound("The index is not exist");
          }
          else {
            final JsonBody = json.encode(list.removeAt(int.parse(index)));
            return Response.ok("The $JsonBody has been removed");
          }

      } catch (e) {
        return Response.badRequest();
      }
});
    
  final server = await serve(router, ip, port);
  print("Server is Http:/${server.address.host}:${server.port}");
  
return server;
}


bool checkIndex(int index) => index > list.length || index < -1 ?  true : false; 

   
