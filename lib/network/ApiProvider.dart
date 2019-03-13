import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/model/MovieItem.dart';

class ApiProvider {

  static Future<MovieItem> fetchMovieDetails() async {
    final response = await http.get(Constants.BASE_URL +
        Constants.FILTER_POPULAR +
        '?api_key=${Constants.API_KEY}');
    print(response.body.toString());
    if (response.statusCode == 200) {
      return MovieItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get Movies');
    }
  }
}
