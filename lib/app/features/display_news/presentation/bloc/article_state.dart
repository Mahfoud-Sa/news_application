import 'package:dio/dio.dart';

abstract class ArticleState {}

class ArticlesLoading extends ArticleState {
  ArticlesLoading();
}

class ArticlesDone extends ArticleState {
  final List<dynamic> data;
  ArticlesDone(this.data);
}

class ArticlesException extends ArticleState {
  final DioException errorMessage;
  ArticlesException(this.errorMessage);
}

class MessageDone extends ArticleState {
  final String errorMessage;
  MessageDone(this.errorMessage);
}
