import 'package:equatable/equatable.dart';
import 'package:news_app/app/features/display_news/data/modules/source.dart';

class ArticleEntity extends Equatable {
  final SourceModel? source;

  final String? author;
  final String? title;
  final String? descripution;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  const ArticleEntity({
    this.source,
    this.author,
    this.title,
    this.descripution,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
  @override
  List<Object?> get props {
    return [
      source,
      author,
      title,
      descripution,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }
}
