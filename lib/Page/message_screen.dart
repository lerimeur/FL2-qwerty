import 'dart:async';

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
    super.initState();
    messageList = widget.conv.messages;
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => refresh());
  }

  void refresh() {
    context.read<API>().getOneConversation(widget.conv.id);
  }

  @override
  Widget build(BuildContext context) {
    messageList = context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id).first.messages;
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
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: <Widget>[
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_3.png"),
          ),
          const SizedBox(width: defaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.conv.title,
                style: const TextStyle(fontSize: 16),
              ),
              const Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
