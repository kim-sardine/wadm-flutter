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
}
