import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF00BF6D);
const Color kSecondaryColor = Color(0xFFFE9901);
const Color kContentColorLightTheme = Color(0xFF1D1D35);
const Color kContentColorDarkTheme = Color(0xFFF5FCF9);
const Color kWarninngColor = Color(0xFFF3BB1C);
const Color kErrorColor = Color(0xFFF03738);

const double kDefaultPadding = 20.0;

User? global_User;

class User {
  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.token,
    required this.profilePicture,
  });
  final String id;
  final String firstname;
  final String lastname;
  final String token;
  final String profilePicture;

  String getFirstname() => firstname;
  String getLastname() => lastname;
}

class Message {
  Message(this.mess, this.createdDate, this.sender);
  final String mess;
  final DateTime createdDate;
  final String sender;

  @override
  bool operator ==(Object other) {
    return (other is Message) && other.mess == mess && other.createdDate == createdDate && other.sender == sender;
  }
}

class Conversation {
  Conversation({
    required this.title,
    required this.lastMessage,
    required this.id,
    required this.messages,
  });

  final String id;
  final String title;
  final String lastMessage;
  List<Message> messages;

  List<Message> get gettermessages => messages;
}
