import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:food_template/constants.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_json/pretty_json.dart';

Future<Token> login(String username, password) async {
  //final queryParameters = {'username': username, 'password': password};
  final uri = Uri.https(BASE_URL, 'auth/token/');
  var body = Map<String, dynamic>();
  body['username'] = username;
  body['password'] = password;

  http.Response response = await http.post(
    uri,
    body: body,
  );

  if (response.statusCode == 200) {
    saveTokenStorage(response.body);
    return compute(parseToken, response.body);
  } else {
    return const Token(accessToken: '', refreshToken: '');
  }
}

Future<bool> logout() async {
  const storage = FlutterSecureStorage();
  User user = User(
    id: '',
    username: '',
    imagePath: '',
    firstName: '',
    lastName: '',
    address: '',
    city: '',
    email: '',
    telephone: '',
    zipCode: '',
    isActive: false,
    isVerified: false,
  );
  Token token = const Token(accessToken: '', refreshToken: '');
  final jsonUser = jsonEncode(user.toJson());
  final jsonToken = jsonEncode(token.toJson());
  storage.write(
    key: 'user',
    value: jsonUser,
  );
  storage.write(
    key: 'token',
    value: jsonToken,
  );

  return true;
}

Future<bool> registerUser(String username, password, email) async {
  final uri = Uri.https(BASE_URL, 'auth/register/');
  var body = Map<String, dynamic>();
  body['username'] = username;
  body['password'] = password;
  body['email'] = email;
  //body['first_name'] = '';
  //body['last_name'] = '';
  body['app_name'] = APP_NAME;

  http.Response response = await http.post(
    uri,
    body: body,
  );

  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<bool> updateUserdata(User user) async {
  Token token = await fetchTokenFromPref();

  final uri = Uri.https(BASE_URL, 'auth/update-user-data/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
    //  HttpHeaders.contentTypeHeader: 'application/json'
  };
  var map = new Map<String, dynamic>();
  map['first_name'] = user.firstName;
  map['last_name'] = user.lastName;
  map['address'] = user.address;
  map['city'] = user.city;
  map['zip_code'] = user.zipCode;
  map['email'] = user.email;
  map['telephone'] = user.telephone;

  http.Response response = await http.post(
    uri,
    headers: header,
    body: map,
  );

  if (response.statusCode == 200) {
    saveUserStorage(response.body);
    return true;
  } else {
    return false;
  }
}

Future<User> fetchUserdata(String accessToken) async {
  //final queryParameters = {'username': username, 'password': password};
  final uri = Uri.https(BASE_URL, 'auth/get-user-data/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    HttpHeaders.contentTypeHeader: 'application/json'
  };
  http.Response response = await http.get(
    uri,
    headers: header,
  );

  if (response.statusCode == 200) {
    saveUserStorage(response.body);
    return compute(parseUser, response.body);
  } else {
    User user = User(
      id: '',
      username: '',
      imagePath: '',
      firstName: '',
      lastName: '',
      address: '',
      city: '',
      email: '',
      telephone: '',
      zipCode: '',
      isActive: false,
      isVerified: false,
    );
    saveUserStorage(jsonEncode(user.toJson()));

    return user;
  }
}

Future<bool> sendEmailActivation(String accessToken) async {
  final uri = Uri.https(BASE_URL, 'auth/resend-email-verification/');
  final header = {
    HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    HttpHeaders.contentTypeHeader: 'application/json'
  };
  var map = new Map<String, dynamic>();
  map['Authorization'] = 'Bearer ' + accessToken;
  http.Response response = await http.post(
    uri,
    headers: header,
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Token> refreshToken(String refresh) async {
  final uri = Uri.https(BASE_URL, 'auth/token/refresh/');
  var map = new Map<String, dynamic>();
  map['refresh'] = refresh;

  http.Response response = await http.post(
    uri,
    body: map,
  );

  if (response.statusCode == 200) {
    saveTokenStorage(response.body);
    return compute(parseToken, response.body);
  } else {
    return const Token(accessToken: '', refreshToken: '');
  }
}

Future<User> fetchUserdataFromPref() async {
  Token token = await fetchTokenFromPref();
  token = await refreshToken(token.refreshToken);
  if (token.accessToken != '') {
    User user = await fetchUserdata(token.accessToken);
    final storage = new FlutterSecureStorage();

    String? json = await storage.read(key: 'user');

    if (json != null) {
      return compute(parseUser, json);
    } else {
      return User(
        id: '',
        username: '',
        imagePath: '',
        firstName: '',
        lastName: '',
        address: '',
        city: '',
        email: '',
        telephone: '',
        zipCode: '',
        isActive: false,
        isVerified: false,
      );
    }
  } else {
    return User(
      id: '',
      username: '',
      imagePath: '',
      firstName: '',
      lastName: '',
      address: '',
      city: '',
      email: '',
      telephone: '',
      zipCode: '',
      isActive: false,
      isVerified: false,
    );
  }
}

Future<String> fetchFirebaseTokenFromPref() async {
  const storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'firebaseToken');

  if (token != null) {
    return token;
  } else {
    return '';
  }
}

Future<Token> fetchTokenFromPref() async {
  const storage = FlutterSecureStorage();
  String? json = await storage.read(key: 'token');

  if (json != null) {
    Token token = await compute(parseToken, json);
    Token tokenUpd = await refreshToken(token.refreshToken);
    return tokenUpd;
  } else {
    return const Token(accessToken: '', refreshToken: '');
  }
}

Future<bool> saveUserStorage(String jsonUser) async {
  const storage = FlutterSecureStorage();
  storage.write(
    key: 'user',
    value: jsonUser,
  );
  return true;
}

Future<bool> saveTokenStorage(String jsonToken) async {
  final storage = new FlutterSecureStorage();
  storage.write(
    key: 'token',
    value: jsonToken,
  );
  return true;
}

// A function that converts a response body into a List<User>.
User parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return User.fromJson(parsed);
}

Token parseToken(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return Token.fromJson(parsed);
}

class User {
  final String id;
  final String username;
  final String imagePath;
  String firstName;
  String lastName;
  String address;
  String city;
  String email;
  String telephone;
  String zipCode;
  final bool isActive;
  final bool isVerified;

  User({
    required this.id,
    required this.username,
    required this.imagePath,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.city,
    required this.email,
    required this.telephone,
    required this.zipCode,
    required this.isActive,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'] as String,
      imagePath: json['image_url'] as String,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      address: json['address'] as String,
      city: json['city'] as String,
      email: json['email'] as String,
      telephone: json['telephone'] as String,
      zipCode: json['zip_code'] as String,
      isActive: json['is_active'] as bool,
      isVerified: json['is_verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'image_url': imagePath,
      'first_name': firstName,
      'last_name': lastName,
      'address': address,
      'city': city,
      'email': email,
      'telephone': telephone,
      'is_active': isActive,
      'is_verified': isVerified,
    };
  }
}

class Token {
  final String accessToken;
  final String refreshToken;

  const Token({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }
}
