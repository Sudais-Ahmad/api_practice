import 'package:api_practice/models/MoviesModle.dart';
import 'package:api_practice/utility/constant_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviesDetail extends StatelessWidget {
  final MoviesModel movies;

  const MoviesDetail({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(movies.title.toString()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Plot: \n',
                  style: tStyle,
                  children: [
                    TextSpan(
                        text: movies.plot,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Genre: \n',
                  style: tStyle,
                  children: [
                    TextSpan(
                        text: movies.genre,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Actors: \n',
                  style: tStyle,
                  children: [
                    TextSpan(
                        text: movies.actors,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Language: \n',
                  style: tStyle,
                  children: [
                    TextSpan(
                        text: movies.language,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Released: \n',
                  style: tStyle,
                  children: [
                    TextSpan(
                        text: movies.released,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
