import 'package:flutter/material.dart';
import 'getApi/movie_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API\'s List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      return const MovieApi();
                    }));
                  },
                  title: const Text('Movie API'),
                  // trailing: Container(
                  //   height: 40,
                  //   width: 90,
                  //   decoration: BoxDecoration(
                  //     color: Colors.purple,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: const Center(
                  //     child: Text('Click'),
                  //   ),
                  // ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
