import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({super.key, this.hintText = '', this.password = false});

  final String hintText;
  final bool password;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.password,
      
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(15, 0, 0, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
