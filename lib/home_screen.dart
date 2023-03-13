import 'package:flutter/material.dart';
import 'package:flutter_provider/favorite_movies.dart';
import 'package:flutter_provider/movie_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MovieProvider>().movies;
    var myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MyFavMoviesList()));
            },
            icon: const Icon(Icons.favorite),
            label: Text('Go to my List (${myList.length})'),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (_, index) {
                    final currentMovie = movies[index];
                    return Card(
                      color: Colors.orange,
                      key: ValueKey(currentMovie.title),
                      child: ListTile(
                        title: Text(currentMovie.title),
                        subtitle:
                            Text(currentMovie.duration ?? 'no information'),
                        trailing: IconButton(
                            onPressed: () {
                              if (!myList.contains(currentMovie)) {
                                context
                                    .read<MovieProvider>()
                                    .addToList(currentMovie);
                              } else {
                                context
                                    .read<MovieProvider>()
                                    .removeFromList(currentMovie);
                              }
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: myList.contains(currentMovie)
                                  ? Colors.red
                                  : Colors.white,
                            )),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
