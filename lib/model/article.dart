class Article {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String sourceName;
  final String author;

  Article({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.sourceName,
    required this.author,
  });

  factory Article.fromJson(Map<String, dynamic> jsonData) {
    var source =
        jsonData['source']?['id'] ??
        jsonData['source']?['name'] ??
        jsonData['sourceId'] ??
        "";
    return Article(
      title: jsonData['title'] ?? "",
      description: jsonData['description'] ?? "",
      url:
          jsonData['url'] ??
          "https://i.pinimg.com/474x/b7/f0/db/b7f0db1455d5a1fcfdb41ef6a13822e2.jpg",
      imageUrl:
          jsonData['urlToImage'] ??
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQauwIRNRadX_pWnwrvqusofrDqo4FxDtgt9Q&s",
      publishedAt: jsonData['publishedAt'] ?? "",
      sourceName: source,
      author:
          jsonData['author'] ??
          (source == "" ? "From Internet" : "UnKnown Journalist"),
    );
  }
}
