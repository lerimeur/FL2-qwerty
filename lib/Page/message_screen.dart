import 'dart:async';

// import 'package:chat/Api/Apirequest.dart';
// import 'package:chat/Screens/Message/textInputchat.dart';
// import 'package:chat/Screens/Message/text_message.dart';
// import 'package:chat/constants.dart';
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

  // final context_tab = context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id);

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    // final Future<bool> test = context.read<API>().getOneConversation(widget.conv.id);

    // context.read<API>().
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => refresh());
  }

  void refresh() async {
    // print('refresh');
    await context.read<API>().getOneConversation(widget.conv.id);
    // inspect(context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id));
    // final tmp_conv =
    // messageList = tmp_conv;

    // inspect(context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id));
    // setState(() {
    //   messageList = widget.conv.messages;
    // });
    // getMessageforaConv(widget.conv.id).then(
    //   (value) => {
    //     if (messageList.isEmpty || value.length > messageList.length) setState(() => {messageList = value})
    //   },
    // );
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
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: messageList.length,
      itemBuilder: (BuildContext context, int index) {
        messageList.sort((Message a, Message b) {
          return a.createdAt.compareTo(b.createdAt);
        });

        final bool sender = messageList[index].userId == context.read<API>().user.id;

        return Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Row(
            mainAxisAlignment: sender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[
              if (!sender) ...<Widget>[
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/images/user_2.png"),
                ),
                const SizedBox(width: kDefaultPadding / 2),
              ],
              TextMessage(message: messageList[index].content, sender: sender)
            ],
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
          const SizedBox(width: kDefaultPadding * 0.75),
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
