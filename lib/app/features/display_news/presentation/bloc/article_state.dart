import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';

abstract class RemoteArticleState {}

class RemoteArticlesLoading extends RemoteArticleState {
  RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticleState {
  final int counter;
  RemoteArticlesDone(this.counter);
}

class RemoteArticlesException extends RemoteArticleState {
  final errorMessage;
  RemoteArticlesException(this.errorMessage);
}
