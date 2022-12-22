import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

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
  bool operator ==(other) {
    return (other is Message) && other.mess == mess && other.createdDate == createdDate && other.sender == sender;
  }
}

class Conversation {
  Conversation(
    this.title,
    this.lastMessage,
    this.id,
  );

  final String id;
  final String title;
  final String lastMessage;
  // final List<Message> messages;

}
