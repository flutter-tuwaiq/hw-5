import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

  // part - 1
  // creat an empty list 
  List<Map> Info = [];

main(){
// Configure routes.
    withHotreload(() => CreateServer());
  
}

  Future<HttpServer> CreateServer()async{

    
  final ip = InternetAddress.anyIPv4;
  final int prot = int.parse(Platform.environment["PORT"] ?? "8080");
  final router = Router()  
    
    // part - 2 
    //Creating an endpoint to add data to the list
  ..post("/editprofile/<index>", (Request req , String index)async{
      if(Info.length <=2){
        final body = await req.readAsString();
        final Map jsonBody = json.decode(body);
        Info.add(jsonBody);
        return Response.ok("Updated...........-_-");

      }else{
        return Response.ok("At least 3 keys must be entered");
      }
  })
  // part - 3 
  // Creating an endpoint to display all data in the list

  ..get("/profile", (Request req ,){
      final jsonBody = json.encode(Info);
      return Response.ok(jsonBody);
      
  })

  // part - 4 
  // Creating an endpoint to display one index data in the list
  ..get("/profilebyindex/<index>", (Request req , String index){
    int numberOfIndex = int.parse(index);
    final jsonBody = json.encode(Info[numberOfIndex]);
    return Response.ok(jsonBody);

  })

  // part - 5 
  // Creating an endpoint to delete one index data in the list
  ..delete("/deleteprofile/<index>", (Request req , String index){
      final jsonBody = json.encode(Info.removeAt(int.parse(index)));
      return Response.ok("the profile are deleted");
  });
  


  final server = await serve(router , ip , prot);
    print("Server is Starting at http://${server.address.host}:${server.port}");

    return server;
  }