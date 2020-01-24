import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class DB {
  final _headers = <String,String>{
    "id": "com.vollup.store",
    "key": md5.convert(utf8.encode("654321")).toString(),
};
  final _url = "https://jonathanvegasp.herokuapp.com/database";

  static final DB _instance = DB._internal();

  DB._internal();

  factory DB() => _instance;

  Future<Map<String,dynamic>> _validateResponse(http.StreamedResponse response) async {
    if(response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(await utf8.decodeStream(response.stream));
    } else {
      return {
        "status": response.statusCode,
        "headers": response.headers.toString(),
        "body": await utf8.decodeStream(response.stream)
      };
    }
  }

  String _JsonToQueryUrl(Map<String,dynamic> map) {
    var queryUrl = "";
    for(var i = 0; i< map.keys.length; i++) {
      final key = map.keys.elementAt(i);
      if(i == 0) {
        queryUrl += "$key=${map[key]}";
      } else {
        queryUrl += "&$key=${map[key]}";
      }
    }
    return queryUrl;
  }


  Future<Map<String, dynamic>> getDataByJson(
      String table, Map<String, dynamic> map) async {
    final query = _JsonToQueryUrl(map);
    final request = http.Request("GET", Uri.parse("$_url/$table?$query"));
    request.headers.addAll(_headers);
    final response = await request.send();
    return _validateResponse(response);
  }

  Future<Map<String, dynamic>> createTable(
      String table, Map<String, dynamic> map) async {
    final request = http.Request("POST",Uri.parse("$_url/$table"));
    request..headers.addAll(_headers)..bodyBytes = utf8.encode(json.encode(map));
    final response = await request.send();
    return _validateResponse(response);
  }
}
