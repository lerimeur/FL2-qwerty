import 'package:flutter/material.dart';

class FLChatBubble extends StatefulWidget {
  const FLChatBubble({super.key, required this.message, this.me = false});
  final String message;
  final bool me;

  @override
  State<FLChatBubble> createState() => _FLChatBubble();
}

class _FLChatBubble extends State<FLChatBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: widget.me ? const Color.fromARGB(255, 0, 130, 255) : const Color.fromRGBO(200, 200, 200, 100),
      ),
      child: Text(
        widget.message,
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    );
  }
}
