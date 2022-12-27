import 'dart:async';
import 'dart:developer';

// import 'package:chat/Api/Apirequest.dart';
// import 'package:chat/Screens/Message/textInputchat.dart';
// import 'package:chat/Screens/Message/text_message.dart';
// import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

import '../Component/chat_input.dart';
import '../Component/text_message.dart';
import '../type.dart';

import '../utils.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key, required this.conv}) : super(key: key);
  final Conversation conv;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  Timer? timer;

  List<Message> message_list = [];

  // final context_tab = context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id);

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    final test = context.read<API>().getOneConversation(widget.conv.id);

    // context.read<API>().
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => refresh());
  }

  refresh() async {
    print('refresh');
    context.read<API>().getOneConversation(widget.conv.id);
    // inspect(context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id));
    // final tmp_conv =
    // message_list = tmp_conv;

    // inspect(context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id));
    // setState(() {
    //   message_list = widget.conv.messages;
    // });
    // getMessageforaConv(widget.conv.id).then(
    //   (value) => {
    //     if (message_list.isEmpty || value.length > message_list.length) setState(() => {message_list = value})
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    message_list = context.watch<API>().convlist.where((Conversation e) => e.id == widget.conv.id).first.messages;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: listMessage(),
            ),
          ),
          ChatInputField(widget.conv, fct: refresh),
        ],
      ),
    );
  }

  Widget listMessage() {
    if (message_list.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: message_list.length,
      itemBuilder: (BuildContext context, int index) {
        message_list.sort((a, b) {
          return a.createdDate.compareTo(b.createdDate);
        });

        final bool sender = message_list[index].sender == context.read<API>().user.id;

        return Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Row(
            mainAxisAlignment: sender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!sender) ...[
                const CircleAvatar(
                  radius: 12,
                  backgroundImage: AssetImage("assets/images/user_2.png"),
                ),
                const SizedBox(width: kDefaultPadding / 2),
              ],
              TextMessage(message: message_list[index].mess, sender: sender)
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
        children: [
          const BackButton(),
          const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user_3.png"),
          ),
          const SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
