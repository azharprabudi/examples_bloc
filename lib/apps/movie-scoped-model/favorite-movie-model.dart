import 'package:scoped_model/scoped_model.dart';

class FavoriteMovieModel extends Model {
  static final FavoriteMovieModel _singleton =
      new FavoriteMovieModel._internal();

  factory FavoriteMovieModel() {
    return _singleton;
  }

  FavoriteMovieModel._internal();

  Map<String, dynamic> _favorites = {};

  Map<String, dynamic> get favorites => _favorites;
  String get countFavorites => _favorites.keys.length.toString();

  void addFavorite(String id) {
    if (!_favorites.containsKey(id)) {
      _favorites[id] = true;
      notifyListeners();
    }
  }

  void removeFavorite(String id) {
    if (_favorites.containsKey(id)) {
      _favorites.remove(id);
      notifyListeners();
    }
  }

  bool checkFavorite(String id) => _favorites.containsKey(id);
}
