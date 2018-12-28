import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'package:scoped_model/scoped_model.dart';

class Movie {
  final String id;
  final String title;
  final String url;

  Movie({
    @required this.id,
    @required this.title,
    @required this.url,
  });
}

class ListMovieModel extends Model {
  static final ListMovieModel _singleton = new ListMovieModel._internal();

  factory ListMovieModel() {
    return _singleton;
  }

  ListMovieModel._internal();

  Dio client = Dio();
  List<Movie> _movies = [];
  bool _isLoading = false;
  int _page = 0;

  fetchMovie() async {
    _isLoading = true;
    notifyListeners();

    _page += 1;

    final Response res = await client
        .get('https://jsonplaceholder.typicode.com/photos?_page=$_page');
    final List<Movie> _mv = (res.data as List<dynamic>)
        .map(
          (item) => Movie(
                id: item['id'].toString(),
                title: item['title'],
                url: item['url'],
              ),
        )
        .toList();

    _movies.addAll(_mv);
    _isLoading = false;

    notifyListeners();
  }

  bool get loading => _isLoading;
  List<Movie> get movies => _movies;
  int get countMovies => _movies.length;
}
