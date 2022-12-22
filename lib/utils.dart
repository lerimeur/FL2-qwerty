import 'dart:convert';
import 'dart:developer';

import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  late User user;
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

    // inspect(body);

    try {
      final http.Response data = await http.post(
        Uri.parse("$endpoint/auth/signup"),
        headers: headers,
        body: body,
      );

      final tmp = json.decode(data.body);

      // print(data.body);

      user = User(
        id: tmp['id'],
        firstname: tmp['firstname'],
        lastname: tmp['lastname'],
        profilePicture: tmp['profilePicture'],
        token: tmp['token'],
      );

      // inspect(user);

      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  Future<bool> signup(String email, String password) async {
    final String body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });
    try {
      final data = await http.post(
        Uri.parse("$endpoint/auth/signin"),
        headers: headers,
        body: body,
      );
      final tmp = json.decode(data.body);

      // print(data.body);

      user = User(
        id: tmp['id'],
        firstname: tmp['firstname'],
        lastname: tmp['lastname'],
        profilePicture: tmp['profilePicture'],
        token: '',
      );
      // tmp['token'],
      // inspect(user);

      return true;
    } catch (e) {
      return false;
    }
  }
}
