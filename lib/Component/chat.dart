import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key, required this.title, this.lastMessage = '', required this.id, required this.onSelectedChat});

  final String title;
  final String lastMessage;
  final String id;
  final VoidCallback onSelectedChat;

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
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
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
                      color: Colors.black54,
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
