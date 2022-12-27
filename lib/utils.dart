import 'dart:convert';
import 'dart:developer';

import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  late User user;
  late List<Conversation> convlist = [];
  static const String endpoint = 'https://flutr.fundy.cf';

  late Map<String, String> headers = <String, String>{"Content-Type": "application/json"};

  void updateCookie(http.Response response) {
    final String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
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
      final http.Response data = await http.post(
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
      final http.Response data = await http.get(
        Uri.parse("$endpoint/users"),
        headers: headers,
      );
      updateCookie(data);

      final tmp = json.decode(data.body);

      // print(data.body);
      print("GET ALL USER");
      for (final elem in tmp) {
        inspect(elem);
      }

      // user = User(
      //   id: tmp['id'],
      //   firstname: tmp['firstname'],
      //   lastname: tmp['lastname'],
      //   profilePicture: tmp['profilePicture'],
      //   token: '',
      // );
      // tmp['token'],
      // inspect(user);

      return true;
    } catch (e) {
      return false;
    }
  }

  void getAllConversations() async {
    try {
      final http.Response data = await http.get(Uri.parse("$endpoint/conversations"), headers: headers);

      updateCookie(data);
      print('GET ALL CONVERSATION');
      final tmp = json.decode(data.body);

      List<Conversation> tmpconv = [];

      for (int i = 0; i < tmp['conversations'].length; i++) {
        tmpconv.add(
          Conversation(
            id: tmp['conversations'][i]['id'],
            title: "titre",
            lastMessage: 'last',
            messages: [],
          ),
        );
      }

      inspect(tmpconv);
      convlist = tmpconv;
      notifyListeners();
    } catch (e) {
      inspect(e);
    }
  }

  void newConversation(
    String userId,
  ) async {
    final String body = jsonEncode(<String, List<String>>{
      'Users': [userId]
    });

    final http.Response data = await http.post(
      Uri.parse("$endpoint/conversations"),
      headers: headers,
      body: body,
    );

    updateCookie(data);
    print("CREATE CONV");
    print(data.body);
    // final tmp = json.decode(data.body);
    //   inspect(tmp);
    //   for (final elem in tmp) {
    //     inspect(elem);
    //   }

    // return response;
  }

  Future<bool> getOneConversation(String id) async {
    final http.Response data = await http.get(Uri.parse("$endpoint/conversations/$id"), headers: headers);

    updateCookie(data);

    final tmp = json.decode(data.body);

    List<Message> tmp_list = [];

    for (final item in tmp['messages']) {
      tmp_list.add(Message(item['content'], DateTime.parse(item['createdAt']), item['userId']));
    }

    if (tmp_list.isEmpty) {
      for (var i = 0; i < convlist.length; i++) {
        if (convlist[i].id == id) {
          convlist[i].messages = [];
        }
      }
    } else {
      for (var i = 0; i < convlist.length; i++) {
        if (convlist[i].id == id) {
          convlist[i].messages = tmp_list;
        }
      }
    }

    notifyListeners();
    return true;
  }

  void newMessage({required String conversationId, required String content}) async {
    final String body = jsonEncode(<String, String>{'content': content, 'conversationId': conversationId});
    final http.Response response = await http.post(
      Uri.parse("$endpoint/messages"),
      headers: headers,
      body: body,
    );
    print(response.body);
  }
}
