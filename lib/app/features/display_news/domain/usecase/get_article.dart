import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/core/usecase/usecase.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/data/repository/article_repository_impl.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:news_app/app/features/display_news/domain/repository/article_repository.dart';

class GetArticleUseCase implements UseCase<DataState<List<dynamic>>, void> {
  //final ArticleRepository _articleRepository;
  final ArticleRepositoryImpl _articleRepository = ArticleRepositoryImpl();

  GetArticleUseCase();
  @override
  Future<DataState<List<dynamic>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
