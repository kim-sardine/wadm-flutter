import 'dart:convert';
import 'package:uuid/uuid.dart';

import './candidate.dart';
import './category.dart';
import '../utils.dart';

class Wadm {
  String id;
  String title;
  DateTime createdAt;
  DateTime updatedAt;
  List<Candidate> candidates;
  List<Category> categories;

  Wadm(
      {String id,
      String title,
      DateTime createdAt,
      DateTime updatedAt,
      List<Candidate> candidates,
      List<Category> categories}) {
    id ??= generateUuid();

    var now = getUtcNow();
    now = removeMiliMicroSeconds(now);
    createdAt ??= now;
    updatedAt ??= now;

    candidates ??= [];
    categories ??= [];

    this.id = id;
    this.title = title;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
    this.candidates = candidates;
    this.categories = categories;
  }

  factory Wadm.fromJson(Map<String, dynamic> jsonWadm) {
    List<dynamic> decodedCandidates = json.decode(jsonWadm['candidates']);
    List<Candidate> candidates = decodedCandidates
        .map<Candidate>((each) => Candidate.fromJson(each))
        .toList();

    List<dynamic> decodedCategory = json.decode(jsonWadm['categories']);
    List<Category> categories = decodedCategory
        .map<Category>((each) => Category.fromJson(each))
        .toList();
    
    var wadm = Wadm(
      id: jsonWadm['id'],
      title: jsonWadm['title'],
      createdAt: convertStringToDateTime(jsonWadm['createdAt']),
      updatedAt: convertStringToDateTime(jsonWadm['updatedAt']),
      candidates: candidates,
      categories: categories,
    );
    return wadm;
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'createdAt': convertDateTimeToString(this.createdAt),
    'updatedAt': convertDateTimeToString(this.updatedAt),
    'candidates': json.encode(this.candidates),
    'categories': json.encode(this.categories),
  };

  // sort by catetory's 1.weight, 2.title
  void sortCategory() {
    List<Map<String, dynamic>> indexWithWeight = [];
    for (var i = 0; i < this.categories.length; i++) {
      indexWithWeight.add({
        'index': i,
        'weight': this.categories[i].weight,
        'title': this.categories[i].title,
      });
    }

    indexWithWeight.sort((a, b) {
      var compare = b["weight"].compareTo(a["weight"]);
      if (compare != 0) {
        return compare;
      }
      return a["title"].compareTo(b["title"]);
    });

    List<Category> newCategory = [];
    for (var i = 0; i < this.categories.length; i++) {
      int targetIndex = indexWithWeight[i]['index'];
      newCategory.add(this.categories[targetIndex]);
    }
    this.categories = newCategory;

    // sync candidate
    for (var i = 0; i < this.candidates.length; i++) {
      List<int> newScores = [];
      for (var j = 0; j < indexWithWeight.length; j++) {
        int targetIndex = indexWithWeight[j]['index'];
        newScores.add(this.candidates[i].scores[targetIndex]);
      }
      this.candidates[i].scores = newScores;
    }
  }

  void sortCandidate() {
    this.candidates.sort((a, b) {
      var sumA = a.scores.fold(0, (previous, current) => previous + current);
      var sumB = b.scores.fold(0, (previous, current) => previous + current);
      return sumB.compareTo(sumA);
    });
  }

  String generateUuid() {
    return Uuid().v1();
  }

  bool candidateTitleExists(String title) {
    for (var candidate in this.candidates) {
      if (candidate.title == title) {
        return true;
      }
    }
    return false;
  }

  void updateTitle(String title) {
    this.title = title;
  }

  void addCandidate(String title) {
    final candidateId = generateUuid();

    Candidate newCandidate = Candidate(
        id: candidateId,
        title: title,
        scores: List<int>.filled(this.categories.length, 1, growable: true));
    this.candidates.add(newCandidate);
  }

  void removeCandidate(String candidateId) {
    this.candidates.removeWhere((candidate) => candidate.id == candidateId);
  }

  void updateCandidateTitle(String candidateId, String title) {
    for (var candidate in this.candidates) {
      if (candidate.id == candidateId) {
        candidate.title = title;
        break;
      }
    }
  }

  void addCategory(String title, int weight) {
    final categoryId = generateUuid();

    final category = Category(
      id: categoryId,
      title: title,
      weight: weight,
    );

    this.categories.add(category);
    for (var candidate in this.candidates) {
      candidate.scores.add(1);
    }

    this.sortCategory();
  }

  void removeCategory(String categoryId) {
    for (var i = 0; i < this.categories.length; i++) {
      if (this.categories[i].id == categoryId) {
        this.categories.removeAt(i);
        for (var candidate in this.candidates) {
          candidate.scores.removeAt(i);
        }
        break;
      }
    }
  }

  void updateCategory(String categoryId, String title, int weight) {
    for (var i = 0; i < this.categories.length; i++) {
      if (this.categories[i].id == categoryId) {
        this.categories[i].title = title;
        this.categories[i].weight = weight;
        this.sortCategory();
        break;
      }
    }
  }

  int getTotal(int candidateIdx) {
    // total = candidate's score * category's weight
    int total = 0;
    Candidate candidate = this.candidates[candidateIdx];

    for (var i = 0; i < this.categories.length; i++) {
      total += (this.categories[i].weight * candidate.scores[i]);
    }
    return total;
  }

  bool isEmptyTable() {
    return this.candidates.length == 0 && this.categories.length == 0;
  }
}
