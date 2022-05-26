//import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_template/models/productModel.dart';
import 'package:pretty_json/pretty_json.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:food_template/constants.dart';
import 'package:food_template/models/userModel.dart';

Future<Map<String, dynamic>> insertOrder(CartModel cart) async {
  Token token = await fetchTokenFromPref();
  final uri = Uri.https(BASE_URL, 'api/orders/create/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    HttpHeaders.contentTypeHeader: 'application/json'
  };

  cart.total = cart.total + cart.deliveryFee;

  String mapCart = jsonEncode(cart.toCartJson());
  http.Response response = await http.post(
    uri,
    headers: header,
    body: mapCart,
    encoding: Encoding.getByName("utf-8"),
  );
  switch (response.statusCode) {
    case 201:
      return json.decode(response.body);
    case 205:
      return json.decode('{"error": "Stripe checkout error"}');
    case 400:
      return json.decode('{"error": "Bad request"}');
    case 500:
      return json.decode('{"error": "Server error"}');
    default:
      return json.decode('{"error": "Unknown error"}');
  }
}

Future<CartModel> fetchCartFromPref() async {
  const storage = FlutterSecureStorage();
  // SharedPreferences sharedRest = await SharedPreferences.getInstance();

  String? json = await storage.read(key: 'cart');

  if (json != null) {
    return compute(parseCart, json);
  } else {
    return CartModel(0.0, []);
  }
}

CartModel updateTotalCart(CartModel cart) {
  if (cart.cartItems.isNotEmpty) {
    cart.total = 0.0;
    for (var element in cart.cartItems) {
      cart.total = cart.total + (element.price * element.quantity);
    }
  } else {
    cart.total = 0.0;
  }

  return cart;
}

Future<bool> saveCartPrefs(CartModel cart) async {
  const storage = FlutterSecureStorage();
  CartModel cartUpdated = updateTotalCart(cart);
  //SharedPreferences sharedRest = await SharedPreferences.getInstance();
  String jsonCart = jsonEncode(cartUpdated);

  storage.write(key: 'cart', value: jsonCart);
  return true;
}

CartModel parseCart(String responseBody) {
  final parsed = jsonDecode(responseBody);
  //printPrettyJson(parsed, indent: 2);
  return CartModel.fromJson(parsed);
}

class CartModel {
  List<Product>? items = [];
  double total = 0.0;
  double deliveryFee = 0.0;
  String restaurant = '';
  String restaurantName = '';
  String paymentType = '';
  String deliverType = '';
  String status = '';
  String fullName = '';
  String address = '';
  String city = '';
  String note = '';
  String user = '';
  String email = '';
  String telephone = '';
  String timeDelivery = '';
  String firebaseToken = '';
  String stripeAccountId = '';
  bool onlinePayment = false;
  bool pickup = false;
  bool deliveryAsap = false;

  CartModel(this.total, [this.items]);

  factory CartModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      var total = json['total'] as double;
      var prodJson = json['items'] as List;
      List<Product> _items =
          prodJson.map((pJson) => Product.fromCartJson(pJson)).toList();
      return CartModel(
        total,
        _items,
      );
    } else {
      return CartModel(
        0.0,
        [],
      );
    }
  }
  Map toJson() {
    List? items = this.items != null
        ? this.items!.map((i) => i.toCartJson()).toList()
        : null;
    return {
      'items': items,
      'total': total,
      'deliveryFee': deliveryFee,
      'restaurant': restaurant,
      'restauraName': restaurantName,
      'paymentType': paymentType,
      'deliverType': deliverType,
      'delivery_asap': deliveryAsap,
      'is_pickup': pickup,
      'status': status,
      'address': address,
      'city': city,
      'telephone': telephone,
      'user': user,
      'email': email,
      'fullname': fullName,
      'timeDelivery': timeDelivery,
      'firebaseToken': firebaseToken,
      'onlinePayment': onlinePayment,
      'stripeAccountId': stripeAccountId,
      'note': note,
    };
  }

  Map<String, dynamic> toCartJson() {
    List? items = this.items != null
        ? this.items!.map((i) => i.toCartJson()).toList()
        : null;
    return {
      "food_list": items,
      "total": total.toString(),
      "deliveryFee": deliveryFee.toString(),
      "restaurant": restaurant.toString(),
      "restaurant_name": restaurantName.toString(),
      "payment_type": paymentType.toString(),
      "deliver_type": deliverType.toString(),
      "delivery_asap": deliveryAsap.toString(),
      "is_pickup": pickup.toString(),
      "status": status.toString(),
      "address": address.toString(),
      "city": city.toString(),
      "telephone": telephone.toString(),
      "email": email.toString(),
      "user": user.toString(),
      "fullname": fullName.toString(),
      "deliver_time": timeDelivery.toString(),
      "firebase_id": firebaseToken.toString(),
      "online_payment": onlinePayment.toString(),
      "note": note.toString()
    };
  }

  List<Product> get cartItems {
    return items!;
  }

//
// void add(Product item) {
//   items!.add(item);
// }
//
// void remove(Product item) {
//   items!.remove(item);
// }
//
  void removeAll() {
    items!.clear();
  }
}
