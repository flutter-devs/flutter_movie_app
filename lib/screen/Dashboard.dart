import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/model/MovieItem.dart';
import 'package:flutter_movie_app/model/MovieItem.dart';
import 'package:flutter_movie_app/network/ApiProvider.dart';
import 'package:flutter_movie_app/screen/MovieDetails.dart';
import 'package:flutter_movie_app/screen/SignUp.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<MovieItem> _movieList;


  @override
  void initState() {
    _getMovieDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: <Widget>[
            PopupMenuButton<int>(
              onSelected: _showMenuSelection,
              itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                    PopupMenuItem<int>(
                      value: 0,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.refresh),
                          Text('Refresh'),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.exit_to_app),
                          Text('Sign out'),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: _getMovieDetails(),
            builder: (BuildContext context, AsyncSnapshot<MovieItem> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: false,
                    itemCount: snapshot.data.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildItem(index, snapshot.data.results[index]);
                    },
                  );
                }else{
                  return Center(
                    child: Text('Error! Failed to load movies.'),
                  );
                }
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            /*child: */
          ),
        ),
      ),
    );
  }

  Future<MovieItem> _getMovieDetails() {
    Future<MovieItem> items = ApiProvider.fetchMovieDetails();
    return items;
  }

  Widget _buildItem(int index, Result item) {
    return Card(
      color: Colors.grey[100],
      child: Container(
        height: 120.0,
        padding: EdgeInsets.only(
          left: 0.0,
          top: 4.0,
          right: 2.0,
          bottom: 2.0,
        ),
        child: ListTile(
            onTap: () => _moveToDetailsPage(item),
            leading: new ClipRRect(
              borderRadius: new BorderRadius.circular(5.0),
              child: Image.network(
                Constants.IMAGE_BASE_URL +
                    Constants.IMAGE_SIZE_1 +
                    '${item.poster_path}',
                height: 80.0,
                width: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              item.title,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                item.overview,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(
                  fontSize: 11.0,
                ),
              ),
            )
            //trailing: Icon(Icons.keyboard_arrow_right),
            ),
      ),
    );
  }

  _moveToDetailsPage(Result item) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MovieDetails(item)));
  }

  void _refresh() {
    setState(() {
      _movieList=null;
    });
    //_getMovieDetails();
  }

  void _logout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Sign out?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                _moveToSignIn();
              },
            ),
          ],
        );
      },
    );
  }

  void _moveToSignIn() {
    Navigator.of(context).pushReplacementNamed(Constants.SIGN_IN);
  }

  void _showMenuSelection(int value) {
    print(value);
    if (value == 0) {
      //_getMovieDetails();
      _refresh();
    } else if (value == 1) {
      _logout();
    }
  }
}
