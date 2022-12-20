import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/inputText.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Spacer(),
            Text(
              'Connecte toi a Messenger !',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, height: 7),
            ),
            InputText(hintText: 'Email',),
            SizedBox(height: 4),
            InputText(hintText: 'Mot de passe', password: true,),
            SizedBox(height: 50),
            Button(label: 'Se Connecter'),
            SizedBox(height: 14),
            Button(
              label: 'Créer un nouveau compte',
              color: Color.fromARGB(255, 48, 48, 48),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
