import 'package:flutter/material.dart';
import 'package:flutter_provider/movie_provider.dart';
import 'package:provider/provider.dart';

class MyFavMoviesList extends StatelessWidget {
  const MyFavMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myList = context
        .watch<MovieProvider>()
        .myList;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Fav List ${myList.length}'),
      ),
      body: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (_, index) {
            final currentMovie = myList[index];
            return Card(
              key: ValueKey(currentMovie.title),
              child: ListTile(
                title: Text(currentMovie.title),
                subtitle: Text(currentMovie.duration ?? 'no inform'),
                trailing: const Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  context.read<MovieProvider>().removeFromList(currentMovie);
                },
              ),
            );
          }),
    );
  }
}
