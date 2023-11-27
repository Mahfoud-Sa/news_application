import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/data_sources/remote/news_api_services.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService = NewsApiService();
  @override
  Future<DataState<List>> getSearchArticles(String search) async {
    DataState httpResponse = await _newsApiService.searchArticles(search);

    if (httpResponse is DataSuccess) {
      var articles = httpResponse.data['articles']
          .map((json) => ArticleModel.fromJson(json))
          .toList();

      return DataSuccess(articles);
    } else {
      return DataFailed(httpResponse.error);
    }
  }
}
