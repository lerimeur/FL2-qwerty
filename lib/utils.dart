import 'dart:convert';
import 'dart:developer';

import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  late User user;
  static const String endpoint = 'https://flutr.fundy.cf';
  late Map<String, String> headers = <String, String>{
    "Content-Type": "application/json"
  };

  void updateCookie(http.Response response) {
    final String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
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

    try {
      final http.Response data = await http.post(
        Uri.parse("$endpoint/auth/signup"),
        headers: headers,
        body: body,
      );
      updateCookie(data);

      final tmp = json.decode(data.body);

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
      updateCookie(data);
      final tmp = json.decode(data.body);
      inspect(data);

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

  Future<bool> getAllUsers() async {
    // final String body = jsonEncode(<String, String>{
    //   'email': email,
    //   'password': password,
    // });
    try {
      final data = await http.get(
        Uri.parse("$endpoint/users"),
        headers: headers,
      );
      updateCookie(data);

      final tmp = json.decode(data.body);

      print(data.body);

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
