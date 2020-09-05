
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import './models/wadm.dart';

const WADMS_KEY = "wadms";

class SharedPref {

  // TODO: Sort wadms by 'updated_at'
  loadWadms() async {
    final prefs = await SharedPreferences.getInstance();
    final _wadms = prefs.getString(WADMS_KEY);

    if (_wadms != null) {
      final wadmsJson = json.decode(_wadms);
      final wadms = wadmsJson.map<Wadm>((wadm) => Wadm.fromJson(wadm)).toList();
      return wadms;
    }
    return [];
  }

  saveWadms(wadms) async {
    await save(WADMS_KEY, wadms);
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
