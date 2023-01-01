import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

final BaseOptions options = BaseOptions(extra: <String, dynamic>{"withCredentials": true});

Dio dio = Dio(options);

class API with ChangeNotifier {
  late User user = User(
    id: '',
    firstname: '',
    lastname: '',
    profilePicture: '',
    darkMode: false,
    type: "",
    banned: false,
  );
  late List<Conversation> convlist = <Conversation>[];
  static const String endpoint = 'https://flutr.fundy.cf';

  late Map<String, String> headers = <String, String>{"Content-Type": "application/json"};

  void updateCookie(Response<dynamic> response) {
    final List<String>? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      final List<String> cookie = rawCookie[0].split(';');
      headers['cookie'] = cookie[0];
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

    try {
      final Response<dynamic> data = await dio.post(
        "$endpoint/auth/signup",
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      updateCookie(data);
      user = User(
        id: data.data['id'],
        firstname: data.data['firstname'],
        lastname: data.data['lastname'],
        profilePicture: data.data['profilePicture'],
        darkMode: data.data['darkMode'],
        type: data.data['type'],
        banned: data.data['banned'],
      );
      inspect(user);

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
      final Response<dynamic> data = await dio.post(
        "$endpoint/auth/signin",
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      updateCookie(data);

      user = User(
        id: data.data['id'],
        firstname: data.data['firstname'],
        lastname: data.data['lastname'],
        profilePicture: data.data['profilePicture'],
        darkMode: data.data['darkMode'],
        type: data.data['type'],
        banned: data.data['banned'],
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      final Response<dynamic> data = await dio.get(
        "$endpoint/users",
        options: Options(
          headers: headers,
        ),
      );
      final List<User> tmpusers = <User>[];

      for (int i = 0; i < data.data.length; i++) {
        tmpusers.add(
          User(
            id: data.data[i]['id'],
            firstname: data.data[i]['firstname'],
            lastname: data.data[i]['lastname'],
            profilePicture: data.data[i]['profilePicture'],
            darkMode: data.data[i]['darkMode'],
            type: data.data[i]['type'],
            banned: data.data[i]['banned'],
          ),
        );
      }

      return tmpusers;
    } catch (e) {
      return <User>[];
    }
  }

  void banUser(String id) async {
    try {
      await dio.post(
        "$endpoint/users/ban/$id",
        options: Options(
          headers: headers,
        ),
      );
      getAllConversations();
    } catch (e) {
      inspect(e);
    }
  }

  void unbanUser(String id) async {
    try {
      await dio.post(
        "$endpoint/users/unban/$id",
        options: Options(
          headers: headers,
        ),
      );
      getAllConversations();
    } catch (e) {
      inspect(e);
    }
  }

  void getAllConversations() async {
    try {
      final Response<dynamic> data = await dio.get(
        "$endpoint/conversations",
        options: Options(
          headers: headers,
        ),
      );

      updateCookie(data);
      // print('GET ALL CONVERSATION');

      final List<Conversation> tmpconv = <Conversation>[];

      for (int i = 0; i < data.data['conversations'].length; i++) {
        final List<User> tmpusers = <User>[];
        final List<Message> tmpmessage = <Message>[];
        String tmptitre = 'titre';

        for (int j = 0; j < data.data['conversations'][i]['Users'].length; j++) {
          if (data.data['conversations'][i]['Users'][j]['id'] != user.id) {
            tmptitre = data.data['conversations'][i]['Users'][j]['firstname'];
          }

          tmpusers.add(
            User(
              id: data.data['conversations'][i]['Users'][j]['id'],
              firstname: data.data['conversations'][i]['Users'][j]['firstname'],
              lastname: data.data['conversations'][i]['Users'][j]['lastname'],
              profilePicture: data.data['conversations'][i]['Users'][j]['profilePicture'],
              darkMode: data.data['conversations'][i]['Users'][j]['darkMode'],
              type: data.data['conversations'][i]['Users'][j]['type'],
              banned: data.data['conversations'][i]['Users'][j]['banned'],
            ),
          );
        }

        for (int j = 0; j < data.data['conversations'][i]['messages'].length; j++) {
          tmpmessage.add(
            Message(
              content: data.data['conversations'][i]['messages'][j]['content'],
              createdAt: DateTime.parse(data.data['conversations'][i]['messages'][j]['createdAt']),
              userId: data.data['conversations'][i]['messages'][j]['id'],
            ),
          );
        }

        String tmplast = '';
        if (tmpmessage.isNotEmpty) {
          tmplast = tmpmessage.last.content;
        }
        tmpconv.add(
          Conversation(
            id: data.data['conversations'][i]['id'],
            title: tmptitre,
            lastMessage: tmplast,
            messages: tmpmessage,
            userlist: tmpusers,
          ),
        );
        tmpmessage.clear();
        tmpusers.clear();
      }

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

      final Response<dynamic> data = await dio.post(
        "$endpoint/conversations",
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      // print("CREATE CONV");

      updateCookie(data);

      inspect(data.data);
      return data.data;
    } catch (e) {
      return null;
    }
  }

  Future<bool> getOneConversation(String id) async {
    final Response<dynamic> data = await dio.get(
      "$endpoint/conversations/$id",
      options: Options(
        headers: headers,
      ),
    );

    updateCookie(data);

    inspect(data.data);
    final List<Message> tmplist = <Message>[];

    for (final dynamic item in data.data['messages']) {
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
    await dio.post(
      "$endpoint/messages",
      data: body,
      options: Options(
        headers: headers,
      ),
    );
  }

  Future<void> postProfilPic(String img) async {
    final String body = jsonEncode(<String, String>{
      'profilePicture': img,
    });

    final Response<dynamic> response = await dio.patch(
      "$endpoint/users/me",
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    if (response.statusCode == 200) {
      user.profilePicture = img;
      notifyListeners();
    }
  }

  Future<void> updateDarkMode(bool isdark) async {
    final String body = jsonEncode(<String, bool>{
      'darkMode': isdark,
    });

    final Response<dynamic> response = await dio.patch(
      "$endpoint/users/me",
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    inspect(response);
    if (response.statusCode == 200) {
      user.darkMode = isdark;
      notifyListeners();
    }
  }

  Future<void> postfirstOrLast(String firstname, String lastname) async {
    final String body = jsonEncode(
      <String, String>{'firstname': firstname, 'lastname': lastname},
    );

    try {
      final Response<dynamic> response = await dio.patch(
        "$endpoint/users/me",
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        user.firstname = firstname;
        user.lastname = lastname;
        notifyListeners();
      }
      inspect(response);
    } catch (e) {
      inspect(e);
    }
  }
}
