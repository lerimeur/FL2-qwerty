import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import '../type.dart';

class ChatInputField extends StatelessWidget {
  ChatInputField(
    this.conv, {
    Key? key,
    required this.fct,
  }) : super(key: key);

  final Function() fct;
  final Conv conv;
  TextEditingController messageValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: const Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Icon(
              Icons.photo_camera,
              color: Theme.of(context).buttonTheme.colorScheme?.primary,
            ),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
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
                // await createMessage(
                //   messageValue.text,
                //   global_User?.id,
                //   conv.id,
                // );
                print(messageValue.text);
                messageValue.text = "";
                sleep(const Duration(milliseconds: 1));

                fct();
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