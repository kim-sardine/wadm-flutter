
import 'package:flutter/material.dart';

import '../models/wadm.dart';

class Wadms with ChangeNotifier {
  List<Wadm> _wadms = [
    Wadm(
      title: 'First Wadm!',
      candidates: [],
      categories: [],
    ),
  ];

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