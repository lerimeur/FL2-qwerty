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
                  final String name =
                      '${userList[index].firstname} ${userList[index].lastname}';

                  if (userList[index].id == context.read<API>().user.id) {
                    return Container();
                  }
                  return SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        context.read<API>().newConversation(
                          <String>[userList[index].id],
                        ).then((dynamic data) {
                          if (data != null) {
                            Navigator.of(context).pop();
                            context.read<API>().getAllConversations();
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: defaultPadding,
                          right: defaultPadding,
                        ),
                        child: Row(
                          children: <Widget>[
                            const CircleAvatar(),
                            const Spacer(),
                            Text(
                              name.length > 15
                                  ? '${name.substring(0, 15)}...'
                                  : name,
                            ),
                            const Spacer(flex: 2),
                            if (context.read<API>().user.type == 'ADMIN')
                              if (!userList[index].banned)
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme
                                      ?.primary,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color,
                                  onPressed: () {
                                    context
                                        .read<API>()
                                        .banUser(userList[index].id);
                                  },
                                  child: const Text("Bannir"),
                                )
                              else
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 2,
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme
                                      ?.primary,
                                  textColor: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color,
                                  onPressed: () {
                                    context
                                        .read<API>()
                                        .unbanUser(userList[index].id);
                                  },
                                  child: const Text("Débannir"),
                                )
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
