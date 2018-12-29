import 'package:rxdart/rxdart.dart';

class FavoriteBloc {
  Map<String, dynamic> _favorites = Map<String, dynamic>();

  BehaviorSubject<String> _favoriteState = BehaviorSubject<String>();
  BehaviorSubject<Map<String, dynamic>> _favoritesState =
      BehaviorSubject<Map<String, dynamic>>();

  Sink<String> get addFavorite => _favoriteState.sink;
  Stream<Map<String, dynamic>> get favorites => _favoritesState.stream;

  FavoriteBloc() {
    _favoriteState.listen((String id) {
      if (!_favorites.containsKey(id)) {
        _favorites[id] = true;
        _favoritesState.sink.add(_favorites);
      } else {
        _favorites = _favorites..remove(id);
        _favoritesState.sink.add(_favorites);
      }
    });
  }

  void dispose() {
    _favoritesState?.close();
  }
}
