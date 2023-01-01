import 'dart:io';

import 'package:fl2_qwerty_messenger/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../type.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({Key? key, required this.conv, required this.fct}) : super(key: key);

  final Function() fct;
  final Conversation conv;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController messageValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.photo_camera,
              color: Theme.of(context).buttonTheme.colorScheme?.primary,
            ),
            const SizedBox(width: defaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: defaultPadding / 4),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: messageValue,
                        decoration: const InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: const BorderSide(color: Colors.white),
              ),
              elevation: 2,
              color: Theme.of(context).buttonTheme.colorScheme?.primary,
              textColor: Theme.of(context).textTheme.bodyText1?.color,
              onPressed: () async {
                if (messageValue.text == '') {
                  return;
                }

                context.read<API>().newMessage(
                      conversationId: widget.conv.id.toString(),
                      content: messageValue.text.toString(),
                    );

                messageValue.text = "";
                sleep(const Duration(milliseconds: 1));

                widget.fct();
              },
              child: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
