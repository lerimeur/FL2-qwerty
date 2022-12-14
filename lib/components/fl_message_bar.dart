import 'package:flutter/material.dart';

class FLMessageBar extends StatefulWidget {
  const FLMessageBar({super.key, required this.onSendValue});

  final Function onSendValue;
  @override
  State<FLMessageBar> createState() => _FLMessageBar();
}

class _FLMessageBar extends State<FLMessageBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String textForm = '';

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      widget.onSendValue(textForm);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Write your message...',
              ),
              onFieldSubmitted: (String? value) => textForm.isNotEmpty ? _onSubmit() : null,
              onChanged: (String text) => setState(() => textForm = text),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: textForm.isNotEmpty ? _onSubmit : null,
              child: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
