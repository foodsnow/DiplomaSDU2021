class Categories {
  final int id;
  final String title;
  Categories({
    this.id,
    this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory Categories.fromJson(Map<String, dynamic> map) {
    return Categories(
      id: map['id']?.toInt(),
      title: map['title'],
    );
  }

  @override
  String toString() => 'Categories(id: $id, title: $title)';
}
