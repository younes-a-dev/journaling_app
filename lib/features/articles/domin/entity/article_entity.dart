import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String? id;
  final String? title;
  final String? imageUrl;
  final String? description;
  final String? content;
  final DateTime? dateTime;
  final String? author;
  final int? readTime;
  const ArticleEntity({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.content,
    this.dateTime,
    this.author,
    this.readTime,
  });
  @override
  List<Object?> get props =>
      [id, title, imageUrl, description, content, dateTime, author,readTime];
}
