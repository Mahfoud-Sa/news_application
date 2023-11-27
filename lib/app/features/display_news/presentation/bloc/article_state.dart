import 'package:dio/dio.dart';

abstract class RemoteArticleState {}

class RemoteArticlesLoading extends RemoteArticleState {
  RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticleState {
  final List<dynamic> data;
  RemoteArticlesDone(this.data);
}

class RemoteArticlesException extends RemoteArticleState {
  final DioException errorMessage;
  RemoteArticlesException(this.errorMessage);
}
