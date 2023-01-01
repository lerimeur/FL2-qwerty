import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Component/chat_input.dart';
import '../Component/text_message.dart';
import '../type.dart';
import '../utils.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key, required this.conv}) : super(key: key);
  final Conversation conv;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Timer? timer;

  List<Message> messageList = <Message>[];

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    inspect(widget.conv);
    super.initState();
    messageList = widget.conv.messages;
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => refresh());
  }

  void refresh() {
    context.read<API>().getOneConversation(widget.conv.id);
    setState(() {
      messageList = context.read<API>().convlist.where((Conversation e) => e.id == widget.conv.id).first.messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: listMessage(),
            ),
          ),
          ChatInputField(conv: widget.conv, fct: refresh),
        ],
      ),
    );
  }

  Widget listMessage() {
    if (messageList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          color: secondaryColor,
        ),
      );
    }

    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: (BuildContext context, int index) {
        messageList.sort((Message a, Message b) {
          return a.createdAt.compareTo(b.createdAt);
        });

        final bool sender = messageList[index].userId == context.read<API>().user.id;

        return Padding(
          padding: const EdgeInsets.only(top: defaultPadding),
          child: Row(
            mainAxisAlignment: sender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children:
                // if (!sender) ...<Widget>[
                //   const CircleAvatar(
                //     radius: 12,
                //     backgroundImage: AssetImage("assets/images/user_3.png"),
                //   ),
                //   const SizedBox(width: defaultPadding / 2),
                // ],
                <Widget>[TextMessage(message: messageList[index].content, sender: sender)],
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    final String friendPic =
        widget.conv.userlist.where((User e) => e.id != context.read<API>().user.id).first.profilePicture;
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: <Widget>[
          const BackButton(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            width: 40,
            height: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.memory(
                const Base64Decoder().convert(friendPic),
                width: 10,
                height: 10,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(width: defaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.conv.title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
