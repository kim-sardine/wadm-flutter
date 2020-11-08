import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wadm/utils.dart';

import '../models/wadm.dart';
import '../sharedPref.dart';

const WADMS_KEY = "wadms";

class Wadms with ChangeNotifier {
  List<Wadm> _wadms = [];
  SharedPref sharedPref = SharedPref();

  Wadms() {
    setup();
  }

  void setup() async {
    String wadmsFromSharedPref = await sharedPref.load(WADMS_KEY);
    if (wadmsFromSharedPref != null) {
      final wadmsJson = json.decode(wadmsFromSharedPref);
      _wadms = wadmsJson.map<Wadm>((wadm) => Wadm.fromJson(wadm)).toList();
    }
    notifyListeners();
  }

  List<Wadm> get wadms {
    return [..._wadms];
  }

  Wadm findById(String id) {
    return _wadms.firstWhere((wadm) => wadm.id == id);
  }

  void addNewWadm(title) {
    Wadm wadm = Wadm(title: title, candidates: [], categories: []);
    _wadms.add(wadm);

    saveWadms();
    notifyListeners();
  }

  void removeWadm(id) {
    _wadms.removeWhere((wadm) => wadm.id == id);
    notifyListeners();
  }

  void updateWadm(Wadm newWadm) {
    _wadms = _wadms.map<Wadm>((_wadm) {
      if (_wadm.id == newWadm.id) {
        newWadm.updatedAt = getUtcNow();
        return newWadm;
      }
      return _wadm;
    }).toList();

    saveWadms();
    notifyListeners();
  }

  void saveWadms() async {
    await sharedPref.save(WADMS_KEY, _wadms);
  }
}
