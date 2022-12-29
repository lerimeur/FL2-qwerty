import 'package:fl2_qwerty_messenger/Component/input_text.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<User> userList = <User>[];

  void fetchAllUsers() async {
    final users = await context.read<API>().getAllUsers();
    print('USERS ${users}');
    setState(() {
      userList = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchAllUsers();
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        //Navitor crate CONV
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: kDefaultPadding, right: kDefaultPadding),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(),
                            SizedBox(width: 20),
                            Text(
                              '${userList[index].firstname} ${userList[index].lastname}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: <Widget>[
        const BackButton(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: InputText(
            onChanged: (dynamic value) {},
            hintText: 'Rechercher',
            inputColor: const Color.fromARGB(0, 0, 0, 0),
          ),
        )
      ],
    ),
  );
}
