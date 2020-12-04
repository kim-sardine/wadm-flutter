import 'dart:convert';

import 'package:test/test.dart';

import 'package:wadm/models/candidate.dart';


void main() {
  group('[Candidate json test]', () {
    test('toJson', () {
      final candidate = Candidate(id: 'id', title: 'title', scores: [1,2,3]);
      final jsonCandidate = candidate.toJson();
      expect(jsonCandidate['id'], equals(candidate.id));
      expect(jsonCandidate['title'], equals(candidate.title));
      expect(jsonCandidate['scores'], equals(candidate.scores));
    });

    test('fromJson', () {
      final candidate = Candidate(id: 'id', title: 'title', scores: [1,2,3]);

      final decodedCandidate = json.decode(json.encode(candidate));
      final result = Candidate.fromJson(decodedCandidate);

      expect(candidate.id, equals(result.id));
      expect(candidate.title, equals(result.title));
      expect(candidate.scores, equals(result.scores));
    });
  });

  group('[Candidate operator test]', () {
    test('==', () {
      Candidate candidate1 = Candidate(id: 'id', title: 'title', scores: [1,2,3]);
      Candidate candidate2 = Candidate(id: 'id', title: 'title', scores: [1,2,3]);
      expect(candidate1 == candidate2, equals(true));

      candidate1 = Candidate(id: 'id', title: 'title', scores: [1,3,2]);
      candidate2 = Candidate(id: 'id', title: 'title', scores: [1,2,3]);
      expect(candidate1 == candidate2, equals(false));

      candidate1 = Candidate(id: 'id-1', title: 'title', scores: [1,2,3]);
      candidate2 = Candidate(id: 'id-2', title: 'title', scores: [1,2,3]);
      expect(candidate1 == candidate2, equals(false));

      candidate1 = Candidate(id: 'id', title: 'title-1', scores: [1,2,3]);
      candidate2 = Candidate(id: 'id', title: 'title-2', scores: [1,2,3]);
      expect(candidate1 == candidate2, equals(false));
    });
  });
}