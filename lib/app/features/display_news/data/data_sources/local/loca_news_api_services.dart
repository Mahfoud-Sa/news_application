import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';

class LocalNewsApiServices {
  Future<DataState<List<dynamic>>> getArticleNews() async {
    final String response =
        await rootBundle.loadString('assets/json/raw_json.json');
    final data = await json.decode(response);
    var httpResponse =
        data['articles'].map((json) => ArticleModel.fromJson(json)).toList();

    return DataSuccess(httpResponse);
  }
}
