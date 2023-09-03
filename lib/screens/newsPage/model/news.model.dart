class NewsModel {
  NewsModel({
    required this.source,
    required this.title,
    this.urlToImage,
    required this.author,
    this.description,
    required this.date,
  });

  String source;
  String title;
  String? urlToImage;
  String? author;
  String? description;
  String date;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        source: json["source"]["name"],
        title: json["title"],
        urlToImage: json["urlToImage"],
        author: json["author"],
        description: json["description"],
        date: json["publishedAt"],
      );
}
