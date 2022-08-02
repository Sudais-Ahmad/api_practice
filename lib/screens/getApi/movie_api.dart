import 'dart:async';
import 'dart:convert';
import 'package:api_practice/models/MoviesModle.dart';
import 'package:api_practice/screens/getApi/movie_detail.dart';
import 'package:api_practice/utility/constant_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MovieApi extends StatefulWidget {
  const MovieApi({Key? key}) : super(key: key);

  @override
  _MovieApiState createState() => _MovieApiState();
}

class _MovieApiState extends State<MovieApi> {
  var searchMovieController = TextEditingController();
  late StreamController streamController;
  late Stream stream;

  apiSearcher(String name) async {
    streamController.add('loading');
    var response = await http.get(
      Uri.parse('https://www.omdbapi.com/?t=$name&plot=full&apiKey=94e188aa'),
    );
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['Response'] == 'True') {
        MoviesModel moviesModel = MoviesModel.fromJson(jsonData);
        streamController.add(moviesModel);
      } else {
        streamController.add('not found');
      }
      // print(jsonData);
    } else {
      streamController.add('wrong');
    }
  }

  @override
  void initState() {
    streamController = StreamController();
    stream = streamController.stream;
    streamController.add('empty');
    var isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Movie API'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: TextField(
                controller: searchMovieController,
                cursorColor: Colors.grey[800],
                decoration: InputDecoration(
                  hintText: 'Search Movie',
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey[800],
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                var searchedMovie = searchMovieController.text;
                if (searchedMovie.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please enter movie name');
                } else {
                  apiSearcher(searchedMovie);
                }
              },
              child: Container(
                height: 46,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Center(
                  child: Text('Search'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 'loading') {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.grey.shade400,),
                        );
                      } else if (snapshot.data == 'wrong') {
                        return const Text('Something went wrong');
                      } else if (snapshot.data == 'not found') {
                        return const Text('Movie not found');
                      } else if (snapshot.data == 'empty') {
                        return const Text('Search Movie name');
                      } else {
                        MoviesModel movie = snapshot.data as MoviesModel;
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                movie.poster.toString(),
                                height: 400,
                                width: double.infinity,fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Tittle: ${movie.title.toString()}',style: tStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Year: ${movie.year.toString()}',style: tStyle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (ctx) {
                                    return MoviesDetail(movies: movie);
                                  }));
                                },
                                child: Center(
                                  child: Container(
                                    height: 48,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Center(
                                      child: Text('Movie Details'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.grey.shade400,),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
