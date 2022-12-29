import 'package:fl2_qwerty_messenger/Component/input_text.dart';
import 'package:fl2_qwerty_messenger/type.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<User> fakeData = <User>[
    User(
      id: '0',
      firstname: 'Paul',
      lastname: 'Dupont',
      token: '',
      profilePicture: 'profilePicture',
    ),
    User(
      id: '1',
      firstname: 'Louis',
      lastname: 'Martin',
      token: '',
      profilePicture: 'profilePicture',
    ),
    User(
      id: '2',
      firstname: 'Thierry',
      lastname: 'Racine',
      token: '',
      profilePicture: 'profilePicture',
    ),
    User(
      id: '3',
      firstname: 'Pierre',
      lastname: 'Durant',
      token: '',
      profilePicture: 'profilePicture',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: fakeData.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding),
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(),
                            SizedBox(width: 20),
                            Text(
                              '${fakeData[index].firstname} ${fakeData[index].lastname}',
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
            inputColor: kPrimaryColor,
          ),
        )
      ],
    ),
  );
}
