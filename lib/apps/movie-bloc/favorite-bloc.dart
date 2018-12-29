import 'package:rxdart/rxdart.dart';

class FavoriteBloc {
  static final FavoriteBloc _singleton = FavoriteBloc._internal();

  factory FavoriteBloc() {
    return _singleton;
  }

  FavoriteBloc._internal() {
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

  Map<String, dynamic> _favorites = Map<String, dynamic>();

  BehaviorSubject<String> _favoriteState = BehaviorSubject<String>();
  BehaviorSubject<Map<String, dynamic>> _favoritesState =
      BehaviorSubject<Map<String, dynamic>>();

  Sink<String> get addFavorite => _favoriteState.sink;
  Stream<Map<String, dynamic>> get favorites => _favoritesState.stream;

  void dispose() {
    _favoritesState?.close();
  }
}
