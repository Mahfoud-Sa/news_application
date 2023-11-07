import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/core/resources/data_state.dart';
import 'package:news_app/app/features/display_news/data/modules/article.dart';
import 'package:news_app/app/features/display_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:news_app/app/features/display_news/presentation/bloc/article_bloc.dart';

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
