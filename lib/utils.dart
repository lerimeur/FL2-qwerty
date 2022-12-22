import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  // late User user;
  late String token = '';
  static const String endpoint = 'https://flutr.fundy.cf';
  static const Map<String, String> headers = <String, String>{"Content-Type": "application/json"};

  void updateToken(String value) {
    token = value;
  }

  Future<bool> signin(
    String email,
    String password,
    String firstname,
    String lastname,
  ) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    });

    inspect(body);

    http.Response data = await http.post(
      Uri.parse("$endpoint/auth/signup"),
      headers: headers,
      body: body,
    );

    print(data.body);
    // user = User();

    return false;
  }

  Future<bool> signup(String email, String password) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });

    final data = await http.post(
      Uri.parse("$endpoint/auth/signin"),
      headers: headers,
      body: body,
    );

    print(data.body);

    return false;
  }
}
