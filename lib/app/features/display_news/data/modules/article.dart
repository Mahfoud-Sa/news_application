import 'dart:convert';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'source.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  final SourceModel? source;

  final String? author;
  final String? title;
  final String? descripution;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleModel({
    this.source,
    this.author,
    this.title,
    this.descripution,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: SourceModel.fromJson(json["source"]),
        author: json["author"] ?? "Unknewn",
        title: json["title"] ?? "Unknewn",
        descripution: json["description"] ?? "Unknewn",
        url: json["url"] ?? "Unknewn",
        urlToImage: json["urlToImage"] ?? "Unknewn",
        publishedAt: json["publishedAt"],
        content: json["content"] ?? "Unknewn",
      );
}
