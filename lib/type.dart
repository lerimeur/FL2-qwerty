import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF00BF6D);
const Color kSecondaryColor = Color(0xFFFE9901);
const Color kContentColorLightTheme = Color(0xFF1D1D35);
const Color kContentColorDarkTheme = Color(0xFFF5FCF9);
const Color kWarninngColor = Color(0xFFF3BB1C);
const Color kErrorColor = Color(0xFFF03738);

const double kDefaultPadding = 20.0;

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.profilePicture,
    required this.darkMode,
  });
  final String id;
  final String firstname;
  final String lastname;
  final String profilePicture;
  final bool darkMode;
  String getFirstname() => firstname;
  String getLastname() => lastname;
}

class Message {
  Message({required this.content, required this.createdAt, required this.userId});
  final String content;
  final DateTime createdAt;
  final String userId;

  // @override
  // bool operator ==(Object other) {
  //   return (other is Message) && other.content == content && other.createdAt == createdAt && other.userId == userId;
  // }
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
