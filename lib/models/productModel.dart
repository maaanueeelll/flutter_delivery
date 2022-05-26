import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:food_template/models/restaurantModel.dart';
import 'package:food_template/models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:food_template/constants.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:pretty_json/pretty_json.dart';

Future<bool> addFavorite(
    Product product, User user, Restaurant restaurant) async {
  Token token = await fetchTokenFromPref();
  final uri = Uri.https(BASE_URL, 'api/food/favorites/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    //  HttpHeaders.contentTypeHeader: 'application/json'
  };
  var map = new Map<String, dynamic>();
  map['food'] = product.id.toString();
  map['user'] = user.id.toString();
  map['restaurant'] = restaurant.id.toString();

  http.Response response = await http.post(
    uri,
    headers: header,
    body: map,
    encoding: Encoding.getByName("utf-8"),
  );

  if (response.statusCode == 201 || response.statusCode == 409) {
    return true;
  } else {
    return false;
  }
}

Future<bool> removeFavorite(Product product, User user) async {
  Token token = await fetchTokenFromPref();
  final uri = Uri.https(BASE_URL, 'api/food/favorites/remove/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    //  HttpHeaders.contentTypeHeader: 'application/json'
  };
  var map = new Map<String, dynamic>();
  map['food'] = product.id.toString();
  map['user'] = user.id.toString();

  http.Response response = await http.post(
    uri,
    headers: header,
    body: map,
    encoding: Encoding.getByName("utf-8"),
  );

  if (response.statusCode == 205) {
    return true;
  } else {
    return false;
  }
}

Future<List<Product>> fetchFavoriteProducts(
    http.Client client, Restaurant restaurant) async {
  Token token = await fetchTokenFromPref();
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    //  HttpHeaders.contentTypeHeader: 'application/json'
  };
  final queryParameters = {
    'restaurant': RESTAURANT_PK,
  };
  final uri = Uri.https(BASE_URL, 'api/food/favorites', queryParameters);
  final response = await client.get(uri, headers: header);

  // Use the compute function to run parseProducts in a separate isolate.
  return compute(parseProducts, response.body);
}

Future<List<Product>> fetchPopularProducts(http.Client client) async {
  final queryParameters = {
    'restaurant_pk': RESTAURANT_PK,
  };
  final uri = Uri.https(BASE_URL, 'api/menu/food/popular', queryParameters);
  final response = await client.get(uri, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });

  //final response = await rootBundle.loadString('assets/data/food.json');

  // Use the compute function to run parseProducts in a separate isolate.
  return compute(parseProducts, response.body);
}

Future<List<Product>> fetchProducts(
  http.Client client,
  int menuPk,
) async {
  final queryParameters = {
    'restaurant_pk': RESTAURANT_PK,
    'menu_pk': menuPk.toString(),
  };
  final uri = Uri.https(BASE_URL, 'api/menu/food', queryParameters);
  final response = await client.get(uri, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
  });

  //final response = await rootBundle.loadString('assets/data/food.json');
  //printPrettyJson(response.body, indent: 2);
  // Use the compute function to run parseProducts in a separate isolate.
  return compute(parseProducts, response.body);
}

// A function that converts a response body into a List<Product>.
List<Product> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Product>((json) => Product.fromJson(json)).toList();
}

class Product {
  int id;
  String name;
  String description;
  String imageUrl;
  int restaurant;
  String ingredients;
  double rating;
  double price;
  int menu;
  int kcal;
  int protein;
  int carbs;
  bool isPromo;
  bool isNews;
  int quantity;
  bool isInCart;

  Product({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.imageUrl = '',
    this.restaurant = 0,
    this.ingredients = '',
    this.rating = 0.0,
    this.price = 0.0,
    this.menu = 0,
    this.quantity = 1,
    this.kcal = 0,
    this.carbs = 0,
    this.protein = 0,
    this.isNews = false,
    this.isPromo = false,
    this.isInCart = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      restaurant: json['restaurant'] as int,
      ingredients: json['ingredients'] as String,
      rating: double.parse(json['rating']),
      price: double.parse(json['price']),
      menu: json['menu'] as int,
      quantity: json['quantity'] as int,
      kcal: json['kcal'] as int,
      protein: json['protein'] as int,
      carbs: json['carbs'] as int,
      isNews: json['is_news'] == '1' ? true : false,
      isPromo: json['is_promo'] == '1' ? true : false,
    );
  }

  factory Product.fromCartJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['food']),
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: json['ingredients'] as String,
      imageUrl: json['image_url'] as String,
      restaurant: int.parse(json['restaurant']),
      price: double.parse(json['price']),
      menu: int.parse(json['menu']),
      quantity: int.parse(json['quantity']),
      isPromo: json['isInCart'] == 'true' ? true : false,
    );
  }

  factory Product.sharedFromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      restaurant: int.parse(json['restaurant']),
      ingredients: json['ingredients'] as String,
      rating: double.parse(json['rating']),
      price: double.parse(json['price']),
      menu: int.parse(json['menu']),
      quantity: int.parse(json['quantity']),
      isInCart: json['isInCart'] == 'true' ? true : false,
      kcal: int.parse(json['kcal']),
      protein: int.parse(json['protein']),
      carbs: int.parse(json['carbs']),
      isNews: json['is_news'] == 'true' ? true : false,
      isPromo: json['is_promo'] == 'true' ? true : false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'name': name.toString(),
      'description': description.toString(),
      'image_url': imageUrl.toString(),
      'restaurant': restaurant.toString(),
      'ingredients': ingredients.toString(),
      'rating': rating.toString(),
      'price': price.toString(),
      'menu': menu.toString(),
      'quantity': quantity.toString(),
      'isInCart': isInCart.toString(),
    };
  }

  Map<String, dynamic> toCartJson() {
    return {
      'food': id.toString(),
      'name': name.toString(),
      'description': description.toString(),
      'ingredients': ingredients.toString(),
      'image_url': imageUrl.toString(),
      'restaurant': restaurant.toString(),
      'price': price.toString(),
      'menu': menu.toString(),
      'quantity': quantity.toString(),
      'isInCart': isInCart.toString(),
    };
  }
}

Future<bool> insertReview(ReviewFood reviewFood) async {
  Token token = await fetchTokenFromPref();

  final uri = Uri.https(BASE_URL, 'api/food/insert-review/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    //  HttpHeaders.contentTypeHeader: 'application/json'
  };
  var map = new Map<String, dynamic>();
  map['food'] = reviewFood.foodId.toString();
  map['user'] = reviewFood.userId.toString();
  map['restaurant'] = reviewFood.restaurantId.toString();
  map['review'] = reviewFood.review;
  map['rating'] = reviewFood.rating.toString();

  http.Response response = await http.post(
    uri,
    headers: header,
    body: map,
    encoding: Encoding.getByName("utf-8"),
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

class ReviewFood {
  int foodId;
  int restaurantId;
  String userId;
  String review;
  double rating;

  ReviewFood({
    this.foodId = 0,
    this.restaurantId = 0,
    this.userId = '',
    this.review = '',
    this.rating = 0.0,
  });

  factory ReviewFood.fromJson(Map<String, dynamic> json) {
    return ReviewFood(
      foodId: json['food'] as int,
      rating: double.parse(json['rating']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': foodId.toString(),
      'user': userId.toString(),
      'restaurant': restaurantId.toString(),
      'review': review.toString(),
      'rating': rating.toString(),
    };
  }
}
