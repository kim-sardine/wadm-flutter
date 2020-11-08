import 'package:test/test.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('[SharedPreferences Test]', () {
    SharedPreferences.setMockInitialValues({}); 
  });
}