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
  }

  @override
  Widget build(BuildContext context) {
    return

        // Column(
        //   children:
        //    <Widget>[
        //     Container(
        //       // width: MediaQuery.of(context).size.width * 0.90 ,
        //       padding: const EdgeInsets.all(kDefaultPadding),
        //       child: Button(
        //         onPressed: () => searchContact(),
        //         label: 'Rechercher',
        //         color: Colors.black12,
        //       ),
        //     ),
        //     Expanded(
        //       child:
        ListView.builder(
      itemCount: context.watch<API>().convlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Chat(
          title: context.read<API>().convlist[index].title,
          lastMessage: context.read<API>().convlist[index].lastMessage,
          id: context.read<API>().convlist[index].id,
          onSelectedChat: () => handleSelectedChat(context.read<API>().convlist[index]),
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
    //     )
    //   ],
    // );
  }
}
