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
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // final List<Message> messagelist = <Message>[
  //   Message('hello1', DateTime.now(), 'greg'),
  //   Message('hello2', DateTime.now(), 'max'),
  //   Message('comment vas?', DateTime.now(), 'greg'),
  //   Message('trkl et toi', DateTime.now(), 'max'),
  //   Message(
  //     'sinon blab blab blab wperbgpwieurbvpweirubvwpreiujbvwerpiubvwreipuvbrwepivbrpivbjrtuwpviwusrbvpsirubvrptiuvbwrpiuvbrwpivbutwr',
  //     DateTime.now(),
  //     'greg',
  //   ),
  //   Message(
  //     'iluwrbv;iuwrbeptivubwrntbuohwerptiubhwrnpt9ubosrheptbouihrenpbiuserbhnpeiyrtubnerpiyubrpniusrwk',
  //     DateTime.now(),
  //     'max',
  //   ),
  //   Message('plop', DateTime.now(), 'greg'),
  //   Message('plop2', DateTime.now(), 'greg'),
  //   Message('plip1', DateTime.now(), 'max'),
  //   Message('plip1', DateTime.now(), 'max'),
  // ];

  // final List<Conversation> fakeData = <Conversation>[
  // Conversation(
  //   title: 'Jean Dupont', lastMessage: 'SAlut comment va', id: '1',

  // messages: [
  //   Message('hello1', DateTime.now(), 'greg'),
  //   Message('hello2', DateTime.now(), 'max'),
  //   Message('comment vas?', DateTime.now(), 'greg'),
  //   Message('trkl et toi', DateTime.now(), 'max'),
  //   Message(
  //       'sinon blab blab blab wperbgpwieurbvpweirubvwpreiujbvwerpiubvwreipuvbrwepivbrpivbjrtuwpviwusrbvpsirubvrptiuvbwrpiuvbrwpivbutwr',
  //       DateTime.now(),
  //       'greg'),
  //   Message('iluwrbv;iuwrbeptivubwrntbuohwerptiubhwrnpt9ubosrheptbouihrenpbiuserbhnpeiyrtubnerpiyubrpniusrwk',
  //       DateTime.now(), 'max'),
  //   Message('plop', DateTime.now(), 'greg'),
  //   Message('plop2', DateTime.now(), 'greg'),
  //   Message('plip1', DateTime.now(), 'max'),
  //   Message('plip1', DateTime.now(), 'max'),
  // ]
  // ),
  // Conversation(title: 'Pierre Dupont', lastMessage: 'SAlut comment va', id: '2', messages: messagelist),
  // Conversation(title: 'Manon Ponutella', lastMessage: 'SAlut comment va', id: '3', messages: messagelist),
  // Conversation(title: 'Kylian Mbappe', lastMessage: 'SAlut comment va', id: '4', messages: messagelist),
  // Conversation(title: 'Claude Francois', lastMessage: 'SAlut comment va', id: '5', messages: messagelist),
  // Conversation(title: 'Michael Jackson', lastMessage: 'SAlut comment va', id: '6', messages: messagelist),
  // Conversation(title: 'Lillian Thuram', lastMessage: 'SAlut comment va', id: '7', messages: messagelist),
  // Conversation(title: 'Jeanne Darc', lastMessage: 'SAlut comment va', id: '8', messages: messagelist),
  // Conversation(title: 'Louis Parapluie', lastMessage: 'SAlut comment va', id: '9', messages: messagelist),
  // Conversation(title: 'Fred Vase', lastMessage: 'Salut comment va', id: '10', messages: messagelist),
  // ];

  void handleSelectedChat(Conversation data) {
    // print('Select chat ${data.id}');
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
    return ListView.builder(
      itemCount: context.watch<API>().convlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Chat(
          title: context.read<API>().convlist[index].title,
          lastMessage: context.read<API>().convlist[index].lastMessage,
          id: context.read<API>().convlist[index].id,
          onSelectedChat: () => handleSelectedChat(context.read<API>().convlist[index]),
        );
      },
    );
  }
}
