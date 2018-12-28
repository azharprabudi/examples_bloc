import 'package:dio/dio.dart';
import 'package:examples_bloc/apps/movie-scoped-model/favorite-movie-model.dart';
import 'package:examples_bloc/apps/movie-scoped-model/list-movie-model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoriteMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('favorite ku ah ah ah'),
      ),
      body: ScopedModel<ListMovieModel>(
        model: ListMovieModel(),
        child: ScopedModel<FavoriteMovieModel>(
          model: FavoriteMovieModel(),
          child: ScopedModelDescendant<ListMovieModel>(
            builder: (BuildContext ctx, Widget child, ListMovieModel model) {
              return ScopedModelDescendant<FavoriteMovieModel>(
                builder: (BuildContext ctx, Widget child,
                    FavoriteMovieModel favmodel) {
                  return ListView.builder(
                    itemCount: int.parse(favmodel.countFavorites),
                    itemBuilder: (BuildContext ctx, int index) {
                      String id = favmodel.favorites.keys.toList()[index];
                      Movie movie =
                          model.movies.firstWhere((movie) => movie.id == id);
                      return Text('${index + 1}. ${movie.title}');
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
