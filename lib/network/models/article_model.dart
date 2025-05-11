import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 0)
class ArticleModel {
  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.category,
    required this.slug,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      category: json['category'] as String,
      slug: json['slug'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String image;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String slug;
  @HiveField(6)
  final String publishedAt;

  // Optional: Add equality and hashCode for list operations
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  // Optional: toJson method for serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'category': category,
      'slug': slug,
      'publishedAt': publishedAt,
    };
  }
}
