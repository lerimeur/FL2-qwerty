import 'package:fl2_qwerty_messenger/Page/home.dart';
import 'package:fl2_qwerty_messenger/Page/profle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyBottomBar extends StatefulWidget {
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => MyBottomBarState();
}

class MyBottomBarState extends State<MyBottomBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[Home(), Profil()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.kym-cdn.com/entries/icons/original/000/028/312/will_poulter.PNG'),
            ),
            SizedBox(width: 20),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 45.0,
              alignment: Alignment.center,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Enter a search term',
                ),
              ),
            ),
          ),
        ),
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
