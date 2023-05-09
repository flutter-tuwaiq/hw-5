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
  final router = Router()
    ..post("/profail", (Request req) {
      final jesonbode = json.encode(myinfo);
      final jesonbode1 = json.encode(myinfo);
      final jesonbode2 = json.encode(myinfo);

      return Response.ok(jesonbode + jesonbode1 + jesonbode2);
    });

  final ip = InternetAddress.anyIPv4;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await serve(router, ip, port);
  print(' flooss  http://${server.address.host}:${server.port}');

  return server;
}
