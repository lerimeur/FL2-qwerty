import 'package:flutter/material.dart';

class Rename extends StatefulWidget {
  const Rename({super.key});

  @override
  State<Rename> createState() => _RenameState();
}

class _RenameState extends State<Rename> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello world'),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
