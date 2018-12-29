import 'package:meta/meta.dart';

class Movie {
  final int id;
  final String title;
  final String image;

  Movie({
    @required this.id,
    @required this.title,
    @required this.image,
  });
}

class MovieState {
  List<Movie> _movies = [];
  bool _loading = false;
  int _page = -1;

  List<Movie> get movies => _movies;
  int get count => _movies.length;
  bool get loading => _loading;
  int get page => _page;

  MovieState.empty() {
    _movies = [];
    _loading = false;
    _page = -1;
  }

  void addMoviesState(List<Movie> _newMovies) {
    _movies.addAll(_newMovies);
  }

  void setLoadingState(bool _newLoading) {
    _loading = _newLoading;
  }
}
