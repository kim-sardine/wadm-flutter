
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPref {

  // TODO: Sort wadms by 'updated_at'
  Future<String> load(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  dynamic loadJson(String key) async {
    String prefValue = await this.load(key);
    Object result;

    try {
      result = json.decode(prefValue);    
    } catch (e) {
      result = null;
    }

    return result;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  saveAsJson(String key, value) async {
    String jsonValue = json.encode(value);
    await this.save(key, jsonValue);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
