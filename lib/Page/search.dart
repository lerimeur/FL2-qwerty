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
    final List<User> users = await context.read<API>().getAllUsers();
    setState(() {
      userList = users;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (userList[index].id == context.read<API>().user.id) {
                    return Container();
                  }
                  return SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        context.read<API>().newConversation(<String>[userList[index].id]).then((dynamic data) {
                          if (data != null) {
                            Navigator.of(context).pop();
                            context.read<API>().getAllConversations();
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
                        child: Row(
                          children: <Widget>[
                            const CircleAvatar(),
                            const SizedBox(width: 20),
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
