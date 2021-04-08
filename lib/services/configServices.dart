import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getConfig() async{
  String data = await rootBundle.loadString('assets/json/keyboard.json');
  return json.decode(data);
}
