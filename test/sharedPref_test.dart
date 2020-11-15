import 'package:test/test.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:wadm/sharedPref.dart';

void main() {
  group('[SharedPreferences Test]', () {
    SharedPref sharedPref;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        'key': 'value',
        'jsonKey': '{"json": "value"}',

      });
      sharedPref = SharedPref();
    });

    test('load', () async  {
      expect(await sharedPref.load('key'), equals('value'));
    });

    test('loadJson', () async  {
      expect(await sharedPref.loadJson('jsonKey'), equals({"json": "value"}));
      expect(await sharedPref.loadJson('value'), equals(null));
    });

    test('save', () async  {
      expect(await sharedPref.load('newKey'), equals(null));
      await sharedPref.save('newKey', 'newValue');
      expect(await sharedPref.load('newKey'), equals('newValue'));
    });

    test('saveAsJson', () async  {
      expect(await sharedPref.load('newKey'), equals(null));
      await sharedPref.saveAsJson('newKey', 'newValue');
      expect(await sharedPref.load('newKey'), equals('"newValue"'));
    });

    test('remove', () async  {
      expect(await sharedPref.load('key'), equals('value'));
      await sharedPref.remove('key');
      expect(await sharedPref.load('key'), equals(null));
    });
  });
}