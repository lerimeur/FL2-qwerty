import 'package:fl2_qwerty_messenger/Page/rename.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  late bool darkMode = context.read<API>().darkmode;

  void goToRename() {
    Navigator.push(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => const Rename(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: kDefaultPadding * 0.5,
          ),
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 60,
          ),
          const SizedBox(
            height: kDefaultPadding * 0.25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(flex: 2),
              Text(
                context.read<API>().user.firstname,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Spacer(),
              Text(
                context.read<API>().user.lastname,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const Spacer(flex: 2),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding * 0.75,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Thème sombre',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: kPrimaryColor,
                    value: darkMode,
                    onChanged: (bool value) {
                      context.read<API>().changedarkmode();
                      setState(() {
                        darkMode = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: InkWell(
              onTap: () {
                goToRename();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 10, 0),
                child: Row(
                  children: const <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nom et prénom',
                        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 17),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
