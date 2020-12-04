import 'dart:convert';

import 'package:test/test.dart';

import 'package:wadm/models/category.dart';


void main() {
  group('[Category json test]', () {
    test('toJson', () {
      final category = Category(id: 'id', title: 'title', weight: 5);
      final jsonCandidate = category.toJson();
      expect(jsonCandidate['id'], equals(category.id));
      expect(jsonCandidate['title'], equals(category.title));
      expect(jsonCandidate['weight'], equals(category.weight));
    });

    test('fromJson', () {
      final category = Category(id: 'id', title: 'title', weight: 5);

      final decodedCandidate = json.decode(json.encode(category));
      final result = Category.fromJson(decodedCandidate);

      expect(category.id, equals(result.id));
      expect(category.title, equals(result.title));
      expect(category.weight, equals(result.weight));
    });
  });

  group('[Category operator test]', () {
    test('==', () {
      Category candidate1 = Category(id: 'id', title: 'title', weight: 5);
      Category candidate2 = Category(id: 'id', title: 'title', weight: 5);
      expect(candidate1 == candidate2, equals(true));

      candidate1 = Category(id: 'id', title: 'title', weight: 5);
      candidate2 = Category(id: 'id', title: 'title', weight: 4);
      expect(candidate1 == candidate2, equals(false));

      candidate1 = Category(id: 'id-1', title: 'title', weight: 5);
      candidate2 = Category(id: 'id-2', title: 'title', weight: 5);
      expect(candidate1 == candidate2, equals(false));

      candidate1 = Category(id: 'id', title: 'title-1', weight: 5);
      candidate2 = Category(id: 'id', title: 'title-2', weight: 5);
      expect(candidate1 == candidate2, equals(false));
    });
  });
}