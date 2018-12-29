import 'package:examples_bloc/apps/movie-bloc/favorite-bloc.dart';
import 'package:examples_bloc/apps/movie-bloc/movie-bloc.dart';
import 'package:examples_bloc/apps/movie-bloc/movie-state.dart';
import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  MovieBloc bloc = MovieBloc();
  FavoriteBloc favbloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('helo kondel'),
      ),
      body: StreamBuilder<MovieState>(
        stream: bloc.movie,
        builder: (BuildContext ctx, AsyncSnapshot<MovieState> snapshot) {
          return StreamBuilder<Map<String, dynamic>>(
            stream: favbloc.favorites,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<String, dynamic>> favsnapshot) {
              return ListView.builder(
                itemCount: snapshot.hasData ? favsnapshot.data.keys.length : 0,
                itemBuilder: (BuildContext ctx, int index) {
                  String id = favsnapshot.data.keys.toList()[index].toString();
                  return GestureDetector(
                    onTap: () {
                      favbloc.addFavorite.add(id);
                    },
                    child: ListTile(
                      title: Text(snapshot.data.movies
                          .firstWhere((movie) => movie.id.toString() == id)
                          .title),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
