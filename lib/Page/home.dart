import 'package:fl2_qwerty_messenger/Component/chat.dart';
import 'package:fl2_qwerty_messenger/Page/message_screen.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Conversation> fakeData = <Conversation>[
    Conversation('Jean Dupont', 'SAlut comment va', '1'),
    Conversation('Pierre Dupont', 'SAlut comment va', '2'),
    Conversation('Manon Ponutella', 'SAlut comment va', '3'),
    Conversation('Kylian Mbappe', 'SAlut comment va', '4'),
    Conversation('Claude Francois', 'SAlut comment va', '5'),
    Conversation('Michael Jackson', 'SAlut comment va', '6'),
    Conversation('Lillian Thuram', 'SAlut comment va', '7'),
    Conversation('Jeanne Darc', 'SAlut comment va', '8'),
    Conversation('Louis Parapluie', 'SAlut comment va', '9'),
    Conversation('Fred Vase', 'Salut comment va', '10'),
  ];

  void handleSelectedChat(Conversation data) {
    print('Select chat ${data.id}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => MessagesScreen(conv: data)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fakeData.length,
      itemBuilder: (BuildContext context, int index) {
        return Chat(
          title: fakeData[index].title,
          lastMessage: fakeData[index].lastMessage,
          id: fakeData[index].id,
          onSelectedChat: () => handleSelectedChat(fakeData[index]),
        );
      },
    );
  }
}
