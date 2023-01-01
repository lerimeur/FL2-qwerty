import 'dart:convert';
import 'dart:developer';

import 'package:fl2_qwerty_messenger/Page/home.dart';
import 'package:fl2_qwerty_messenger/Page/profile.dart';
import 'package:fl2_qwerty_messenger/Page/search.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:fl2_qwerty_messenger/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => MyBottomBarState();
}

class MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[const Home(), const Profil()];

  void _onItemTapped(int index) {
    // inspect(context.read<API>().user);

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              width: 10,
              height: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.memory(
                  const Base64Decoder().convert(context.watch<API>().user.profilePicture),
                  width: 10,
                  height: 10,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          actions: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[300],
              child: IconButton(
                color: secondaryColor,
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
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
