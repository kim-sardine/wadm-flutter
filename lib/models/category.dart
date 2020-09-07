class Category {
  String title;
  int weight;

  Category({this.title, this.weight});

  Category.fromJson(Map<String, dynamic> data)
    : title = data['title'],
      weight = data['weight'];

  Map<String, dynamic> toJson() => {
    'title': this.title,
    'weight': this.weight,
  };

  bool isDuplicated(Category category) {
    return this.title == category.title;
  }
}
