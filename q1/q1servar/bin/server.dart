import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'package:shelf_router/shelf_router.dart';

void main() async {
  withHotreload(() => createServer());
}

Future<HttpServer> createServer() async {
  List<Map> myinfo = [
    {
      "name": "waleed",
      "phone": "534524",
      "cite": "madenah",
      "poseshin": "app_dev"
    },
    {
      "name": "maha",
      "phone": "5323452346",
      "cite": "reyad",
      "poseshin": "engnring"
    },
    {
      "name": "fahad",
      "phone": "53452334",
      "cite": "reyad",
      "poseshin": "rrtrtr"
    }
  ];
  List<Map> myinfo1 = [
    {
      "name": "khaled",
      "phone": "534523434",
      "cite": "reyad",
      "poseshin": "wep_dev"
    },
    {
      "name": "jrkerg",
      "phone": "533723489",
      "cite": "reyad",
      "poseshin": "decor"
    },
    {"name": "", "phone": "", "cite": "reyad", "poseshin": ""}
  ];
  List<Map> myinfo2 = [
    {
      "name": "ahmad",
      "phone": "534957431",
      "cite": "reyad",
      "poseshin": "gergqer"
    },
    {
      "name": "fadee",
      "phone": "53452345",
      "cite": "reyad",
      "poseshin": "afgsfvf"
    },
    {
      "name": "gawad",
      "phone": "55387034",
      "cite": "reyad",
      "poseshin": "sgahsfdlj"
    }
  ];

  List<Map> mydata3 = [
    {"name": "", "phone": "", "cite": "", "poseshin": ""},
    {"name": "", "phone": "", "cite": "", "poseshin": ""},
    {"name": "", "phone": "", "cite": "", "poseshin": ""}
  ];

  final router = Router()
    ..get("/data", (Request req) {
      final jesonbode = json.encode(mydata3);

      return Response.ok(jesonbode);
    })
    ..get("/data/<indexMap>", (Request req, String indexMap) {
      final jesonbode = json.encode(mydata3[int.parse(indexMap)]);

      return Response.ok(jesonbode);
    })
    ..post("/update_data/<index>", (Request req, String index) async {
      final body = await req.readAsString();
      final Map jesonbode = json.decode(body);
      if (jesonbode.containsKey("name")) {
        mydata3[int.parse(index)]["name"] = jesonbode["name"];
        return Response.ok("update name.......");
      }
      if (jesonbode.containsKey("phone")) {
        mydata3[int.parse(index)]["phone"] = jesonbode["phone"];
        return Response.ok("update phone.......");
      }
      if (jesonbode.containsKey("cite")) {
        mydata3[int.parse(index)]["cite"] = jesonbode["cite"];
        return Response.ok("update cite.......");
      }
      if (jesonbode.containsKey("poseshin")) {
        mydata3[int.parse(index)]["poseshin"] = jesonbode.remove(["poseshin"]);
        return Response.ok("update poseshin.......");
      }

      return Response.ok("not updare  !!! ");
    })
    ..delete("/deleteData/<endixDelete>",
        (Request req, String endixDelete) async {
      final body = await req.readAsString();
      final Map jesonbode = json.decode(body);
      if (jesonbode.containsKey("name") &&
          mydata3[int.parse(endixDelete)]["name"] == jesonbode["name"] &&
          jesonbode["name"] == jesonbode["name"] + ".remove") {
        mydata3[int.parse(endixDelete)]["name"] = jesonbode.remove(["name"]);
        return Response.ok("remove name.......");
      }
      if (jesonbode.containsKey("phone") &&
          mydata3[int.parse(endixDelete)]["phone"] == jesonbode["phone"] &&
          jesonbode["phone"] == jesonbode["phone"] + ".remove") {
        mydata3[int.parse(endixDelete)]["phone"] = jesonbode.remove(["phone"]);
        return Response.ok("remove phone.......");
      }
      if (jesonbode.containsKey("cite") &&
          mydata3[int.parse(endixDelete)]["cite"] == jesonbode["cite"] &&
          jesonbode["cite"] == jesonbode["cite"] + ".remove") {
        mydata3[int.parse(endixDelete)]["cite"] = jesonbode.remove(["cite"]);
        return Response.ok("remove cite.......");
      }
      if (jesonbode.containsKey("poseshin") &&
          mydata3[int.parse(endixDelete)]["poseshin"] ==
              jesonbode["poseshin"] &&
          jesonbode["poseshin"] == jesonbode["poseshin"] + ".remove") {
        mydata3[int.parse(endixDelete)]["poseshin"] =
            jesonbode.remove(["poseshin"]);
        return Response.ok("remove poseshin.......");
      }

      return Response.ok("not remove  !!! ");
    });

  final ip = InternetAddress.anyIPv4;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await serve(router, ip, port);
  print(' flooss  http://${server.address.host}:${server.port}');

  return server;
}
