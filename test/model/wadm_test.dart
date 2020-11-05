import 'dart:convert';

import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import 'package:wadm/models/wadm.dart';
import 'package:wadm/models/category.dart';
import 'package:wadm/models/candidate.dart';
import 'package:wadm/utils.dart';

void main() {
  group('[Wadm property test]', () {
    test('"id" is uuid.v1', () {
      expect(Wadm().id.length, equals(Uuid().v1().length));
    });

    test('default datetime is now', () {
      final wadm = Wadm();

      DateTime now = removeMiliMicroSeconds(new DateTime.now());
      expect(wadm.createdAt, equals(now));
      expect(wadm.createdAt, equals(wadm.updatedAt));
    });
  });

  group('[Wadm json test]', () {
    test('toJson', () {
      DateTime yesterday = new DateTime.now().subtract(Duration(days: 1));
      final wadm = Wadm(createdAt: yesterday);
      final jsonWadm = wadm.toJson();
      expect(jsonWadm['id'], equals(wadm.id));
      expect(jsonWadm['title'], equals(wadm.title));
      expect(jsonWadm['createdAt'], equals(convertDateTimeToString(wadm.createdAt)));
      expect(jsonWadm['updatedAt'], equals(convertDateTimeToString(wadm.updatedAt)));
      expect(jsonWadm['categories'], equals(json.encode(wadm.categories)));
      expect(jsonWadm['candidates'], equals(json.encode(wadm.candidates)));
    });

    test('fromJson', () {
      final wadm = Wadm(
        title: "test",
        candidates: [
          Candidate(id: '1', title: '1', scores: []),
          Candidate(id: '2', title: '2', scores: []),
        ],
        categories: [
          Category(id: '1', title: '1', weight: 1),
          Category(id: '2', title: '2', weight: 2),
        ]
      );
      final decodedWadm = json.decode(json.encode(wadm));
      final result = Wadm.fromJson(decodedWadm);

      expect(wadm.id, equals(result.id));
      expect(wadm.title, equals(result.title));
      expect(wadm.createdAt, equals(result.createdAt));
      expect(wadm.updatedAt, equals(result.updatedAt));
      expect(wadm.candidates, equals(result.candidates));
      expect(wadm.categories, equals(result.categories));
    });

  });
}