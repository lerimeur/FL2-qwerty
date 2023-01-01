import 'dart:async';

import 'package:fl2_qwerty_messenger/Component/chat.dart';
import 'package:fl2_qwerty_messenger/Page/message_screen.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;

  void handleSelectedChat(Conversation data) {
    Navigator.of(context).push(
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return MessagesScreen(conv: data);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<API>().getAllConversations();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => refresh());
  }

  void refresh() {
    context.read<API>().getAllConversations();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<API>().convlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Chat(
          title: context.read<API>().convlist[index].title,
          lastMessage: context.read<API>().convlist[index].lastMessage,
          id: context.read<API>().convlist[index].id,
          onSelectedChat: () =>
              handleSelectedChat(context.read<API>().convlist[index]),
          profilpic: context
              .read<API>()
              .convlist[index]
              .userlist
              .where((User e) => e.id != context.read<API>().user.id)
              .first
              .profilePicture,
        );
      },
    );
  }
}
