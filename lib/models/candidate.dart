class Candidate {
  String title;
  List<int> scores;

  Candidate({this.title, this.scores});

  Candidate.fromJson(Map<String, dynamic> data) 
    : title = data['title'],
      scores = data['scores'].cast<int>();

  Map<String, dynamic> toJson() => {
    'title': this.title,
    'scores': this.scores,
  };
}
