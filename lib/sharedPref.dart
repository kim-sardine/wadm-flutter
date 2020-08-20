
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './models/wadm.dart';

class SharedPref {
  loadWadms() async {
    final prefs = await SharedPreferences.getInstance();

    //////////////
    final value = [
      {
        "id": "wadm id",
        "title": "wadm title",
        "candidates": [],
        "categories": []
      }
    ];
    prefs.remove('wadms');
    prefs.setString('wadms', json.encode(value));
    //////////////

    final _wadms = prefs.getString('wadms');
    if (_wadms != null) {
      final wadmsJson = json.decode(_wadms);
      final wadms = wadmsJson.map<Wadm>((wadm) => Wadm.fromJson(wadm)).toList();
      return wadms;
    }
    return [];
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
