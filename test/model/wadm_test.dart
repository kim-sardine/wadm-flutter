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

    test('default datetime is utcNow', () {
      final wadm = Wadm();

      DateTime now = removeMiliMicroSeconds(getUtcNow());
      expect(wadm.createdAt, equals(now));
      expect(wadm.createdAt, equals(wadm.updatedAt));
    });
  });

  group('[Wadm json test]', () {
    test('toJson', () {
      DateTime yesterday = getUtcNow().subtract(Duration(days: 1));
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

  group('[Wadm function test]', () {
    test('sortCategory', () {
      final wadm = Wadm(
        title: "test",
        candidates: [
          Candidate(id: 'can_1', title: '1', scores: [3,4,2,1]),
          Candidate(id: 'can_2', title: '2', scores: [6,5,4,3]),
        ],
        categories: [
          Category(id: 'cat_1', title: 'aaa', weight: 2),
          Category(id: 'cat_2', title: 'bbb', weight: 1),
          Category(id: 'cat_3', title: 'ccc', weight: 2),
          Category(id: 'cat_4', title: 'ddd', weight: 3),
        ]
      );

      wadm.sortCategory();

      expect(wadm.categories[0], equals(Category(id: 'cat_4', title: 'ddd', weight: 3)));
      expect(wadm.categories[1], equals(Category(id: 'cat_1', title: 'aaa', weight: 2)));
      expect(wadm.categories[2], equals(Category(id: 'cat_3', title: 'ccc', weight: 2)));
      expect(wadm.categories[3], equals(Category(id: 'cat_2', title: 'bbb', weight: 1)));
    });

    test('updateTitle', () {
      final wadm = Wadm(
        title: "test",
      );

      expect(wadm.title, equals('test'));

      wadm.updateTitle('Changed Title');
      expect(wadm.title, equals('Changed Title'));
    });

    test('addCandidate', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      expect(wadm.candidates.length, equals(0));

      wadm.addCandidate('new title');
      expect(wadm.candidates.length, equals(1));

      Candidate newCandidate = wadm.candidates.last;
      expect(newCandidate.title, equals('new title'));
      expect(newCandidate.id.length, equals(Uuid().v1().length));
      expect(newCandidate.scores.length, equals(0));

      wadm = Wadm(
        title: "test",
        categories: [
          Category(id: 'cat_1', title: 'aaa', weight: 2),
          Category(id: 'cat_2', title: 'bbb', weight: 1),
        ]
      );

      wadm.addCandidate('new title');
      expect(wadm.candidates.length, equals(1));

      newCandidate = wadm.candidates.last;
      expect(newCandidate.title, equals('new title'));
      expect(newCandidate.id.length, equals(Uuid().v1().length));
      expect(newCandidate.scores.length, equals(2));
    });

    test('removeCandidate', () {
      final wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');
      expect(wadm.candidates.length, equals(2));

      wadm.removeCandidate(wadm.candidates[0].id);
      expect(wadm.candidates.length, equals(1));
    });

    test('updateCandidateTitle', () {
      final wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');
      expect(wadm.candidates[0].title, equals('title 1'));

      wadm.updateCandidateTitle(wadm.candidates[0].id, 'new title');
      expect(wadm.candidates[0].title, equals('new title'));
    });

    test('candidateTitleExists', () {
      final wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');

      expect(wadm.candidateTitleExists('title 1'), equals(true));
      expect(wadm.candidateTitleExists('not existing title'), equals(false));
    });

    test('addCategory', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');

      wadm.addCategory('cat title 1', 3);

      expect(wadm.categories.length, equals(1));
      expect(wadm.candidates[0].scores.length, equals(1));
      expect(wadm.candidates[0].scores[0], equals(1));
    });

    test('removeCategory', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');

      wadm.addCategory('cat title 1', 3);
      wadm.addCategory('cat title 2', 4);
      wadm.addCategory('cat title 3', 5);
      expect(wadm.categories.length, equals(3));
      expect(wadm.candidates[0].scores.length, equals(3));

      Category targetCategory = wadm.categories[0];
      wadm.removeCategory(targetCategory.id);
      expect(wadm.categories.length, equals(2));
      expect(wadm.candidates[0].scores.length, equals(2));

      wadm.candidates[0].scores = [4,5];
      targetCategory = wadm.categories[0];
      wadm.removeCategory(targetCategory.id);
      expect(wadm.candidates[0].scores[0], equals(5));
    });

    test('updateCategory', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      wadm.addCategory('cat title 1', 3);
      wadm.addCategory('cat title 2', 4);

      Category targetCategory = wadm.categories[0];
      wadm.updateCategory(targetCategory.id, 'new title', 8);
      expect(targetCategory.title, equals('new title'));
      expect(targetCategory.weight, equals(8));
    });

    test('getTotal', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      wadm.addCandidate('title 1');
      wadm.addCandidate('title 2');
      wadm.addCategory('cat title 1', 4);
      wadm.addCategory('cat title 2', 3);

      expect(wadm.getTotal(0), equals(7));
      expect(wadm.getTotal(1), equals(7));

      wadm.candidates[0].scores = [4, 5];
      expect(wadm.getTotal(0), equals(4*4 + 3*5));
    });

    test('isEmptyTable', () {
      Wadm wadm = Wadm(
        title: "test",
      );

      expect(wadm.isEmptyTable(), equals(true));

      wadm.addCandidate('title 1');
      expect(wadm.isEmptyTable(), equals(false));

      wadm = Wadm(
        title: "test",
      );
      wadm.addCategory('cat title 1', 4);
      expect(wadm.isEmptyTable(), equals(false));

      wadm.addCandidate('title 1');
      expect(wadm.isEmptyTable(), equals(false));
    });


  });
}