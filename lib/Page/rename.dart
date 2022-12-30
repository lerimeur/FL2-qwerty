import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/input_text.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

class Rename extends StatefulWidget {
  const Rename({super.key});

  @override
  State<Rename> createState() => _RenameState();
}

class _RenameState extends State<Rename> {
  void handleFirstName(dynamic value) {}

  void handleLastName(dynamic value) {}
  void handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: <Widget>[
            InputText(
              onChanged: handleFirstName,
              hintText: 'Prénom',
            ),
            const SizedBox(
              height: defaultPadding * 0.75,
            ),
            InputText(
              onChanged: handleLastName,
              hintText: 'Nom',
            ),
            const SizedBox(
              height: defaultPadding * 1.5,
            ),
            Button(
              onPressed: handleSubmit,
              label: 'Enregistrer',
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: const <Widget>[
          BackButton(),
          SizedBox(width: defaultPadding * 0.75),
          Text(
            'Nom et prénom',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
