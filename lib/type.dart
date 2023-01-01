import 'package:flutter/material.dart';

const Color primaryColor = Color.fromARGB(255, 169, 167, 167);
const Color secondaryColor = Color.fromARGB(255, 80, 115, 255);
const Color contentColorLightTheme = Color(0xFF1D1D35);
const Color contentColorDarkTheme = Color(0xFFF5FCF9);
const Color warninngColor = Color(0xFFF3BB1C);
const Color errorColor = Color(0xFFF03738);

const double defaultPadding = 20.0;

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
    required this.darkMode,
    required this.type,
    required this.banned,
  });
  final String id;
  String firstname;
  String lastname;
  String profilePicture;
  bool darkMode;
  bool banned;
  final String type;
  String getFirstname() => firstname;
  String getLastname() => lastname;
}

class Message {
  Message({
    required this.content,
    required this.createdAt,
    required this.userId,
  });
  final String content;
  final DateTime createdAt;
  final String userId;
}

class Conversation {
  Conversation({
    required this.title,
    required this.lastMessage,
    required this.id,
    required this.messages,
    required this.userlist,
  });

  final String id;
  final String title;
  final String lastMessage;
  List<Message> messages;
  List<User> userlist;

  List<Message> get gettermessages => messages;
}
