import 'dart:convert';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:json_annotation/json_annotation.dart';
import 'source.dart';

@JsonSerializable()
class ArticleModel extends ArticleEntity {
  SourceModel? source;
  int? id;

  final String? author;
  final String? title;
  final String? descripution;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  //var id;

  ArticleModel({
    this.id,
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
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "Unknewn",
      );

  factory ArticleModel.fromLocalDataBase(Map<String, dynamic> json) =>
      ArticleModel(
        id: json["id"],
        source: SourceModel(id: json['source_id'], name: json['source_name']),
        author: json["author"] ?? "Unknewn",
        title: json["title"] ?? "Unknewn",
        descripution: json["description"] ?? "Unknewn",
        url: json["url"] ?? "Unknewn",
        urlToImage: json["urlToImage"] ?? "Unknewn",
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "Unknewn",
      );
}
