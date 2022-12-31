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

  late Map<String, String> headersPic = <String, String>{"Content-Type": "application/x-www-form-urlencoded"};

  void updateCookie(http.Response response) {
    final String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final List<String> cookie = rawCookie.split(';');
      headers['cookie'] = cookie[0];
      headersPic['cookie'] = cookie[0];
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
        darkMode: tmp['darkMode'],
        type: tmp['type'],
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
        darkMode: tmp['darkMode'],
        type: tmp['type'],
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final http.Response data = await http.get(
        Uri.parse("$endpoint/users"),
        headers: headers,
      );
      final dynamic tmp = json.decode(data.body);
      final List<User> tmpusers = <User>[];

      for (int i = 0; i < tmp.length; i++) {
        tmpusers.add(
          User(
            id: tmp[i]['id'],
            firstname: tmp[i]['firstname'],
            lastname: tmp[i]['lastname'],
            profilePicture: tmp[i]['profilePicture'],
            darkMode: tmp[i]['darkMode'],
            type: tmp[i]['type'],
          ),
        );
      }
      print(tmpusers);

      return tmpusers;
    } catch (e) {
      return <User>[];
    }
  }

  void getAllConversations() async {
    try {
      final http.Response data = await http.get(Uri.parse("$endpoint/conversations"), headers: headers);

      updateCookie(data);
      // print('GET ALL CONVERSATION');
      final dynamic tmp = json.decode(data.body);

      // inspect(tmp);
      final List<Conversation> tmpconv = <Conversation>[];

      for (int i = 0; i < tmp['conversations'].length; i++) {
        final List<User> tmpusers = <User>[];
        final List<Message> tmpmessage = <Message>[];
        String tmptitre = 'titre';

        for (int j = 0; j < tmp['conversations'][i]['Users'].length; j++) {
          if (tmp['conversations'][i]['Users'][j]['id'] != user.id) {
            tmptitre = tmp['conversations'][i]['Users'][j]['firstname'];
          }

          tmpusers.add(
            User(
              id: tmp['conversations'][i]['Users'][j]['id'],
              firstname: tmp['conversations'][i]['Users'][j]['firstname'],
              lastname: tmp['conversations'][i]['Users'][j]['lastname'],
              profilePicture: tmp['conversations'][i]['Users'][j]['profilePicture'],
              darkMode: tmp['conversations'][i]['Users'][j]['darkMode'],
              type: tmp['conversations'][i]['Users'][j]['type'],
            ),
          );
        }

        for (int j = 0; j < tmp['conversations'][i]['messages'].length; j++) {
          tmpmessage.add(
            Message(
              content: tmp['conversations'][i]['messages'][j]['content'],
              createdAt: DateTime.parse(tmp['conversations'][i]['messages'][j]['createdAt']),
              userId: tmp['conversations'][i]['messages'][j]['id'],
            ),
          );
        }

        String tmplast = '';
        if (tmpmessage.isNotEmpty) {
          tmplast = tmpmessage.last.content;
        }
        tmpconv.add(
          Conversation(
            id: tmp['conversations'][i]['id'],
            title: tmptitre,
            lastMessage: tmplast,
            messages: tmpmessage,
            userlist: tmpusers,
          ),
        );
        tmpmessage.clear();
        tmpusers.clear();
      }

      // inspect(tmpconv);
      convlist = tmpconv;
      notifyListeners();
    } catch (e) {
      inspect(e);
    }
  }

  dynamic newConversation(
    List<String> userId,
  ) async {
    try {
      final String body = jsonEncode(<String, List<String>>{'Users': userId});

      final http.Response data = await http.post(
        Uri.parse("$endpoint/conversations"),
        headers: headers,
        body: body,
      );
      // print("CREATE CONV");

      updateCookie(data);
      final dynamic tmp = json.decode(data.body);
      inspect(tmp);
      return tmp;
    } catch (e) {
      return null;
    }

    // print(data.body);
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

    inspect(tmp);
    final List<Message> tmplist = <Message>[];

    for (final dynamic item in tmp['messages']) {
      tmplist.add(
        Message(
          content: item['content'],
          createdAt: DateTime.parse(item['createdAt']),
          userId: item['userId'],
        ),
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

  Future<void> postProfilPic(String img) async {
    final String body = jsonEncode(
      <String, String>{'picture': img},
    );

    print("LA");
    // inspect(body);
    final http.Response response = await http.patch(
      Uri.parse("$endpoint/users/me/profile-picture"),
      headers: headersPic,
      body: body,
    );
    inspect(response);
    print(response.body);
  }
}
