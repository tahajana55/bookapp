class BookModel{
  int? id;

  String title;
  String author;
  String description;
  String image;
  String review;
  double rating;

  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.image,
    required this.review,
    required this.rating,
});

Map<String, dynamic> toMap() {
return {
"id": id,
"title": title,
"author": author,
"description": description,
"image": image,
"review": review,
"rating": rating,
};
}

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map["id"],
      title: map["title"],
      author: map["author"],
      description: map["description"],
      image: map["image"],
      review: map["review"],
      rating: map["rating"],
    );
  }
}