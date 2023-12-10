part of 'favorite_news_bloc.dart';

@immutable
sealed class FavoriteNewsEvent {}

sealed class AddToFavoritePage extends FavoriteNewsEvent {}
