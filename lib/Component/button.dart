import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    this.label = '',
    this.color = const Color.fromARGB(255, 5, 132, 254),
    required this.onPressed,
  });

  final String label;
  final Color color;
  final VoidCallback onPressed;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
