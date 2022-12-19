import 'package:fl2_qwerty_messenger/Component/chat.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[Chat(), Chat(), Chat(), Chat(), Chat(), Chat()]
    );
  }
}
