import 'dart:convert';
import 'dart:developer';

import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API with ChangeNotifier {
  late User user;
  bool darkmode = false;
  late List<Conversation> convlist = <Conversation>[];
  static const String endpoint = 'https://flutr.fundy.cf';

  late Map<String, String> headers = <String, String>{"Content-Type": "application/json"};

  void updateCookie(http.Response response) {
    final String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  void changedarkmode() {
    darkmode = !darkmode;
    notifyListeners();
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

    try {
      final http.Response data = await http.post(
        Uri.parse("$endpoint/auth/signup"),
        headers: headers,
        body: body,
      );
      updateCookie(data);

      final dynamic tmp = json.decode(data.body);

      user = User(
        id: tmp['id'],
        firstname: tmp['firstname'],
        lastname: tmp['lastname'],
        profilePicture: tmp['profilePicture'],
        token: '',
      );

      return true;
    } catch (e) {
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
      final dynamic tmp = json.decode(data.body);

      user = User(
        id: tmp['id'],
        firstname: tmp['firstname'],
        lastname: tmp['lastname'],
        profilePicture: tmp['profilePicture'],
        token: '',
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllUsers() async {
    try {
      final http.Response data = await http.get(
        Uri.parse("$endpoint/users"),
        headers: headers,
      );
      updateCookie(data);

      // final User tmp = json.decode(data.body);

      return true;
    } catch (e) {
      return false;
    }
  }

  void getAllConversations() async {
    try {
      final http.Response data = await http.get(Uri.parse("$endpoint/conversations"), headers: headers);

      updateCookie(data);
      // print('GET ALL CONVERSATION');
      final dynamic tmp = json.decode(data.body);

      final List<Conversation> tmpconv = <Conversation>[];

      for (int i = 0; i < tmp['conversations'].length; i++) {
        tmpconv.add(
          Conversation(
            id: tmp['conversations'][i]['id'],
            title: "titre",
            lastMessage: 'last',
            messages: <Message>[],
          ),
        );
      }

      // inspect(tmpconv);
      convlist = tmpconv;
      notifyListeners();
    } catch (e) {
      inspect(e);
    }
  }

  void newConversation(
    List<String> userId,
  ) async {
    final String body = jsonEncode(<String, List<String>>{'Users': userId});

    final http.Response data = await http.post(
      Uri.parse("$endpoint/conversations"),
      headers: headers,
      body: body,
    );

    updateCookie(data);
    // print("CREATE CONV");
    // print(data.body);
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

    final dynamic tmp = json.decode(data.body);

    final List<Message> tmplist = <Message>[];

    for (final Message item in tmp['messages']) {
      tmplist.add(
        Message(content: item.content, createdAt: DateTime.parse(item.createdAt as String), userId: item.userId),
      );
    }

    if (tmplist.isEmpty) {
      for (int i = 0; i < convlist.length; i++) {
        if (convlist[i].id == id) {
          convlist[i].messages = <Message>[];
        }
      }
    } else {
      for (int i = 0; i < convlist.length; i++) {
        if (convlist[i].id == id) {
          convlist[i].messages = tmplist;
        }
      }
    }

    notifyListeners();
    return true;
  }

  void newMessage({required String conversationId, required String content}) async {
    final String body = jsonEncode(<String, String>{'content': content, 'conversationId': conversationId});
    await http.post(
      Uri.parse("$endpoint/messages"),
      headers: headers,
      body: body,
    );
    // print(response.body);
  }
}
