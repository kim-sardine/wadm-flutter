class Category {
  String id;
  String title;
  int weight;

  Category({this.id, this.title, this.weight});

  Category.fromJson(Map<String, dynamic> data)
    : id = data['id'],
      title = data['title'],
      weight = data['weight'];

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'title': this.title,
    'weight': this.weight,
  };
}
