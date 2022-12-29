import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Page/home.dart';
import 'package:fl2_qwerty_messenger/Page/profile.dart';
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

  static final List<Widget> _widgetOptions = <Widget>[Home(), const Profil()];

  void _onItemTapped(int index) {
    context.read<API>().getAllUsers();
    // if (index == 0) {
    //   context.read<API>().updateToken('Home');
    // } else {
    //   context.read<API>().updateToken('Profile');
    // }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: kDefaultPadding),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              'https://i.kym-cdn.com/entries/icons/original/000/028/312/will_poulter.PNG',
            ),
          ),
        ),
        title: Row(
          children: const <Widget>[
            Text(
              'Chats',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            )
          ],
        ),
        actions: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: IconButton(
              icon: const Icon(Icons.camera_alt_rounded, color: Colors.black),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: IconButton(
              icon: const Icon(Icons.person_add_sharp, color: Colors.black),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
