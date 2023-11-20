import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesPage extends StatefulWidget {
  const MoviesPage({Key? key}) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    callMovie();
    super.initState();
  }

  Future callMovie() async {
    var body = {};

    http.Response response = await http.post(
        Uri.parse('https://developers.themoviedb.org/3/movies/get-movie-lists'),
        body: body);

    print(response.body.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
