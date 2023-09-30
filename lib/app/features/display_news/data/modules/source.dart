import 'dart:convert';

import 'package:news_app/app/features/display_news/domain/entities/source.dart';

class SourceModel extends SourceEntity {
  final String? id;
  final String? name;
  const SourceModel({
    this.id,
    this.name,
  });

  factory SourceModel.fromRawJson(String str) =>
      SourceModel.fromJson(json.decode(str));

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"] ?? 'Unknewn',
        name: json["name"] ?? 'Unknewn',
      );
}
