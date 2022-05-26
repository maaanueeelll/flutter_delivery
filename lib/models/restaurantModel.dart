import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:food_template/constants.dart';
import 'package:pretty_json/pretty_json.dart';
//import 'package:flutter/services.dart' show rootBundle;
//import 'package:shared_preferences/shared_preferences.dart';

Future<Restaurant> fetchRestaurant(http.Client client) async {
  final queryParameters = {
    'restaurant_pk': RESTAURANT_PK,
  };
  final uri = Uri.https(BASE_URL, 'api/restaurant', queryParameters);
  final response = await client.get(uri);
  //printPrettyJson(response.body, indent: 2);
  //final response = await rootBundle.loadString('assets/data/menu.json');

  bool saveP = await savePrefs(response.body);
  // Use the compute function to run parseMenus in a separate isolate.
  return compute(parseRestaurant, response.body);
}

Future<Restaurant> fetchRestaurantFromPref() async {
  const storage = FlutterSecureStorage();

  //SharedPreferences sharedRest = await SharedPreferences.getInstance();

  String json = await storage.read(key: 'restaurant') ?? '';

  if (json.isEmpty) {
    return Restaurant();
  } else {
    return compute(parseRestaurant, json);
  }
}

Future<bool> savePrefs(String jsonRestaurant) async {
  const storage = FlutterSecureStorage();

  //SharedPreferences sharedRest = await SharedPreferences.getInstance();
  storage.write(key: 'restaurant', value: jsonRestaurant);
  return true;
}

// A function that converts a response body into a List<Menu>.
Restaurant parseRestaurant(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return Restaurant.fromJson(parsed);
}

class Restaurant {
  final int id;
  final String name;
  final bool activeOrders;
  final double deliveryFees;
  String stripeAccountId = '';
//  final String? imageUrl;

  Restaurant({
    this.id = 0,
    this.name = '',
    this.activeOrders = false,
    this.deliveryFees = 0.0,
    this.stripeAccountId = '',
    //  required this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'] as String,
      activeOrders: json['active_orders'] as bool,
      stripeAccountId: json['stripe_account'] ?? '',
      deliveryFees: json['delivery_fees'].toDouble(),
      // imageUrl: json['image_url'] as String?,
    );
  }
}
