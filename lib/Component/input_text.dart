import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  const InputText({
    super.key,
    this.hintText = '',
    this.password = false,
    required this.onChanged,
    this.validator,
    this.inputColor = const Color.fromARGB(15, 0, 0, 0),
  });

  final String hintText;
  final bool password;
  final ValueChanged onChanged;
  final String? Function(String?)? validator;
  final Color inputColor;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      obscureText: widget.password,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.inputColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
