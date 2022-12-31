import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/input_text.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:fl2_qwerty_messenger/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rename extends StatefulWidget {
  const Rename({super.key});

  @override
  State<Rename> createState() => _RenameState();
}

class _RenameState extends State<Rename> {
  String newfirstname = '';
  String newlastname = '';

  @override
  void initState() {
    super.initState();
    newfirstname = context.read<API>().user.firstname;
    newlastname = context.read<API>().user.lastname;
  }

  void handleFirstName(dynamic value) {
    setState(() {
      newfirstname = value;
    });
  }

  void handleLastName(dynamic value) {
    setState(() {
      newlastname = value;
    });
  }

  void handleSubmit() {
    if (newfirstname == '' || newlastname == '') {
      return;
    }
    context.read<API>().postfirstOrLast(newfirstname, newlastname);
    Navigator.maybePop(context);
  }

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
              color: secondaryColor,
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
