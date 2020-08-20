
import 'package:flutter/material.dart';

import '../models/wadm.dart';
import '../sharedPref.dart';

class Wadms with ChangeNotifier {

  List<Wadm> _wadms = [];
  SharedPref sharedPref = SharedPref();

  Wadms() {
    setup();
  }

  void setup() async {
    _wadms = await sharedPref.loadWadms();
    notifyListeners();
  }

  List<Wadm> get wadms {
    return [..._wadms];
  }

  Wadm findById(String id) {
    return _wadms.firstWhere((wadm) => wadm.id == id);
  }

  void addNewWadm(id, title) {
    notifyListeners();
  }

  void renameWadm(id, title) {
    notifyListeners();
  }

  void updateWadm(id, wadm) {
    notifyListeners();
  }
}