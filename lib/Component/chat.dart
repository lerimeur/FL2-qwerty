import 'dart:convert';

import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({
    super.key,
    required this.title,
    this.lastMessage = '',
    required this.id,
    required this.onSelectedChat,
    required this.profilpic,
  });

  final String title;
  final String lastMessage;
  final String id;
  final VoidCallback onSelectedChat;
  final String profilpic;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onSelectedChat,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              width: 60,
              height: 60,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.memory(
                  const Base64Decoder().convert(widget.profilpic),
                  width: 10,
                  height: 10,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.lastMessage,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
