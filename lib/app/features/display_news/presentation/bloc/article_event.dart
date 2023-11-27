abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetAllArticles extends RemoteArticleEvent {
  const GetAllArticles();
}

class GetSearchArticles extends RemoteArticleEvent {
  final String search;

  const GetSearchArticles(this.search);
}
