import 'package:dio/dio.dart';
import 'package:examples_bloc/apps/movie-bloc/movie-state.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  MovieState _movieState = MovieState.empty();
  Stream<MovieState> get movie => _moviesSubject.stream;

  BehaviorSubject<MovieState> _moviesSubject =
      BehaviorSubject<MovieState>(seedValue: MovieState.empty());

  Future<void> fetchingData() async {
    Dio client = Dio();
    _moviesSubject.sink.add(_movieState..setLoadingState(true));

    final Response res =
        await client.get('https://jsonplaceholder.typicode.com/photos?_page=1');
    List<Movie> _movies = (res.data as List<dynamic>)
        .map(
          (data) => Movie(
                id: data['id'],
                image: data['image'],
                title: data['title'],
              ),
        )
        .toList();

    _moviesSubject.sink.add(_movieState..addMoviesState(_movies));
    _moviesSubject.sink.add(_movieState..setLoadingState(false));
  }

  void dispose() {
    _moviesSubject?.close();
  }
}
