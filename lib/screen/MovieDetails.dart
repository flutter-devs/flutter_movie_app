import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/model/MovieItem.dart';
import 'package:flutter_movie_app/screen/SignUp.dart';

class MovieDetails extends StatefulWidget {
  Result item;

  MovieDetails(this.item);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: Text('Movie Details'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.network(
                Constants.IMAGE_BASE_URL +
                    Constants.IMAGE_SIZE_1 +
                    '${widget.item.poster_path}',
                height: 420.0,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                widget.item.title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                widget.item.overview,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
