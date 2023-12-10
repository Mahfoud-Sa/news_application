import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorite_news_event.dart';
part 'favorite_news_state.dart';

class FavoriteNewsBloc extends Bloc<FavoriteNewsEvent, FavoriteNewsState> {
  FavoriteNewsBloc() : super(FavoriteNewsInitial()) {
    on<FavoriteNewsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
