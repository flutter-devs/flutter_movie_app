import 'package:flutter/material.dart';
import 'package:flutter_movie_app/screen/Dashboard.dart';
import 'package:flutter_movie_app/screen/SignIn.dart';
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/screen/SignUp.dart';

final routes = {
  Constants.SIGN_IN: (BuildContext context) => new SignIn(),
  Constants.SIGN_UP: (BuildContext context) => new SignUp(),
  Constants.DASHBOARD: (BuildContext context) => new Dashboard(),
};

void main() => runApp(
      new MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        initialRoute: Constants.SIGN_IN,
      ),
    );
