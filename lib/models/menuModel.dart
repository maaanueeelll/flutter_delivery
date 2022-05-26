import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:food_template/constants.dart';
//import 'package:flutter/services.dart' show rootBundle;

Future<List<Menu>> fetchMenus(http.Client client) async {
  final queryParameters = {
    'restaurant_pk': RESTAURANT_PK,
  };
  //final httpUri = Uri(
  //    scheme: 'https',
  //    host: 'wholedata.io',
  //    path: '/api/menu/',
  //    queryParameters: {'restaurant_pk': RESTAURANT_PK});
  final uri = Uri.https(BASE_URL, 'api/menu', queryParameters);
  final response = await client.get(uri, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });

  //final response = await rootBundle.loadString('assets/data/menu.json');

  // Use the compute function to run parseMenus in a separate isolate.
  return compute(parseMenus, response.body);
}

Future<Menu> fetchDetailMenus(http.Client client, int id) async {
  final queryParameters = {
    'restaurant_pk': RESTAURANT_PK,
    'menu_pk': id.toString(),
  };

  final uri = Uri.https(BASE_URL, 'api/menu-detail', queryParameters);
  final response = await client.get(uri, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });
  // print(response.body);

  if (response.statusCode == 200) {
    final parsed = jsonDecode(response.body);
    return Menu.fromJson(parsed);
  } else {
    return const Menu(
        id: 0, position: 0, name: '', imageUrl: '', restaurant: 0);
  }
}

// A function that converts a response body into a List<Menu>.
List<Menu> parseMenus(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Menu>((json) => Menu.fromJson(json)).toList();
}

class Menu {
  final int id;
  final int position;
  final String name;
  final String imageUrl;
  final int restaurant;
  final int countFood;

  const Menu({
    this.id = 0,
    this.position = 0,
    this.name = '',
    this.imageUrl = '',
    this.restaurant = 0,
    this.countFood = 0,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      position: json['position'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'],
      restaurant: json['restaurant'] as int,
      countFood: json['count_food'] as int,
    );
  }
}
