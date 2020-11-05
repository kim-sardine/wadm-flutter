import 'package:quiver/core.dart';
import 'package:flutter/foundation.dart';

class Candidate {
  String id;
  String title;
  List<int> scores;

  Candidate({this.id, this.title, this.scores});

  Candidate.fromJson(Map<String, dynamic> data) 
    : id = data['id'],
      title = data['title'],
      scores = data['scores'].cast<int>();

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'scores': this.scores,
  };

  bool operator ==(o) => o is Candidate && o.id == id && o.title == title && listEquals(o.scores, scores);
  int get hashCode => hash3(id.hashCode, title.hashCode, scores.hashCode);
}
