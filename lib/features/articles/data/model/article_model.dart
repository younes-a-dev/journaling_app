import '../../domin/entity/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    String? id,
    String? title,
    String? imageUrl,
    String? description,
    String? content,
    DateTime? dateTime,
    String? author,
    int? readTime,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          description: description,
          content: content,
          dateTime: dateTime,
          author: author,
          readTime: readTime,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
     return ArticleModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      content: json['content'],
      dateTime: json['dateTime'],
      author: json['author'],
      readTime: json['readTime'],
    );
  }
}
