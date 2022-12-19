import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final List<Object> fakeData = <Object>[
    {"firstName": 'Jean', "lastName": 'Leclerc', "lastMessage": 'Yo, Whats up'},
    {
      "firstName": 'Louis',
      "lastName": 'Dupont',
      "lastMessage": 'Salut ca va ?'
    },
    {
      "firstName": 'Manon',
      "lastName": 'Ponutella',
      "lastMessage": 'Super merci !'
    },
    {
      "firstName": 'Kylian',
      "lastName": 'Mbappe',
      "lastMessage": 'J cale un triple en finale y a quoi ?'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Prenom',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'You: Yo whats up !',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
