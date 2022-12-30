import 'package:fl2_qwerty_messenger/Page/home.dart';
import 'package:fl2_qwerty_messenger/Page/search.dart';
import 'package:fl2_qwerty_messenger/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../type.dart';

class WebFoundation extends StatefulWidget {
  const WebFoundation({super.key});

  @override
  State<WebFoundation> createState() => _WebFoundationState();
}

class _WebFoundationState extends State<WebFoundation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.kym-cdn.com/entries/icons/original/000/028/312/will_poulter.PNG',
            ),
          ),
        ),
        actions: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: IconButton(
              icon: const Icon(Icons.person_add_sharp),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) {
                      return const Search();
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
        title: Text(context.watch<API>().user.firstname),
      ),
      body: Row(children: [
        Container(
          color: Colors.green,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.30,
          child: Home(),
        ),
        Expanded(
          child: Container(
            color: Colors.red,
          ),
        )
      ]),
    );
  }
}
