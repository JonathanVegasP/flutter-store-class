import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FileManager {
  final String _file;

  FileManager(this._file);

  Future<Map<String,dynamic>> readData() async {
    try {
      final file = await SharedPreferences.getInstance();
      if(!file.containsKey(_file)) return null;
      return json.decode(file.getString(_file));
    }catch(e) {
      print(e);
    }
  }

  Future<bool> saveData(Map<String,dynamic> data) async {
    try {
      final file = await SharedPreferences.getInstance();
      return file.setString(_file, json.encode(data));
    }catch(e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteAllFiles() async {
    try {
      final file = await SharedPreferences.getInstance();
      return file.clear();
    }catch(e) {
      print(e);
      return false;
    }
  }
}