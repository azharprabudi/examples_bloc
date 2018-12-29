import 'package:examples_bloc/apps/movie-bloc/favorite-bloc.dart';
import 'package:examples_bloc/apps/movie-bloc/favorite.dart';
import 'package:examples_bloc/apps/movie-bloc/movie-bloc.dart';
import 'package:examples_bloc/apps/movie-bloc/movie-state.dart';
import 'package:flutter/material.dart';

class Movie extends StatefulWidget {
  @override
  _MovieState createState() => _MovieState();
}

class _MovieState extends State<Movie> {
  MovieBloc bloc = MovieBloc();
  FavoriteBloc favBloc = FavoriteBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchingData();
  }

  @override
  void dispose() {
    super.dispose();
    // bloc?.dispose();
    // favBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Helo world'),
        actions: <Widget>[
          StreamBuilder<Map<String, dynamic>>(
            stream: favBloc.favorites,
            builder: (BuildContext ctx,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (_) => Favorite(),
                  ));
                },
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(snapshot.hasData
                        ? snapshot.data.keys.length.toString()
                        : "0"),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<MovieState>(
        stream: bloc.movie,
        builder: (BuildContext ctx, AsyncSnapshot<MovieState> snapshot) {
          if (snapshot.hasData && snapshot.data.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.hasData ? snapshot.data.count : 0,
            itemBuilder: (BuildContext ctx, int index) {
              return StreamBuilder<Map<String, dynamic>>(
                stream: favBloc.favorites,
                builder: (BuildContext ctx,
                    AsyncSnapshot<Map<String, dynamic>> favsnapshot) {
                  return GestureDetector(
                    onTap: () {
                      favBloc.addFavorite
                          .add(snapshot.data.movies[index].id.toString());
                    },
                    child: ListTile(
                      title: Text(snapshot.data.movies[index].title),
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
