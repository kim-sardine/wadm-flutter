import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'package:wadm/models/wadm.dart';

void main() {
  group('[Wadm property test]', () {
    test('"id" is uuid.v1', () {
      expect(Wadm().id.length, equals(Uuid().v1().length));
    });
  });
}