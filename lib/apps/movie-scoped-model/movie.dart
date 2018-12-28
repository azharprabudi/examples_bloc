import 'package:dio/dio.dart';
import 'package:examples_bloc/apps/movie-scoped-model/favorite-movie-model.dart';
import 'package:examples_bloc/apps/movie-scoped-model/list-favorite.dart';
import 'package:examples_bloc/apps/movie-scoped-model/list-movie-model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ItemMovie extends StatelessWidget {
  final String title;
  final String image;
  final Function onPress;
  final bool favorite;

  ItemMovie({
    @required this.title,
    @required this.image,
    @required this.onPress,
    @required this.favorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          alignment: Alignment(0, 0),
          child: favorite
              ? Icon(Icons.check, color: Colors.white)
              : Text(
                  title,
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}

class Movie extends StatelessWidget {
  FavoriteMovieModel favoriteMovie = FavoriteMovieModel();
  ListMovieModel movieModel = ListMovieModel();
  ScrollController scrollController = ScrollController();

  Movie() {
    movieModel.fetchMovie();
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 10) {
        movieModel.fetchMovie();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite koeh ah'),
        actions: <Widget>[
          ScopedModel<FavoriteMovieModel>(
            model: favoriteMovie,
            child: ScopedModelDescendant<FavoriteMovieModel>(
              builder:
                  (BuildContext ctx, Widget child, FavoriteMovieModel model) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(ctx).push(
                      MaterialPageRoute(builder: (_) => FavoriteMovie()),
                    );
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(model.countFavorites),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModel<ListMovieModel>(
        model: movieModel,
        child: ScopedModel<FavoriteMovieModel>(
          model: favoriteMovie,
          child: ScopedModelDescendant<ListMovieModel>(
            builder: (BuildContext ctx, Widget child, ListMovieModel model) {
              return GridView.builder(
                itemCount: model.countMovies,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return ScopedModelDescendant<FavoriteMovieModel>(
                    builder: (BuildContext ctx, Widget child,
                        FavoriteMovieModel favmodel) {
                      return ItemMovie(
                        image: model.movies[index].url,
                        title: model.movies[index].title,
                        favorite:
                            favmodel.checkFavorite(model.movies[index].id),
                        onPress: () {
                          if (!favmodel.checkFavorite(model.movies[index].id)) {
                            favmodel.addFavorite(model.movies[index].id);
                          } else {
                            favmodel.removeFavorite(model.movies[index].id);
                          }
                        },
                      );
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
