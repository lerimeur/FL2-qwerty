import 'package:flutter/material.dart';

class FLChatBubble extends StatefulWidget {
  const FLChatBubble({super.key, required this.message});
  final String message;

  @override
  State<FLChatBubble> createState() => _FLChatBubble();
}

class _FLChatBubble extends State<FLChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromRGBO(200, 200, 200, 100),
      ),
      child: Text(
        widget.message,
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
