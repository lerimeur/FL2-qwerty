import 'package:fl2_qwerty_messenger/Page/rename.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final TextStyle optionStyle =
      const TextStyle(fontSize: 17, color: Colors.black);
  bool darkMode = false;

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
          const Text(
            "Jean Marie",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
                  Text(
                    'Thème sombre',
                    style: optionStyle,
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: kPrimaryColor,
                    value: darkMode,
                    onChanged: (bool value) {
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
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nom et prénom',
                    style: optionStyle,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
