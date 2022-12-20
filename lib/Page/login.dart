import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/inputText.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void handleLogin() {
    print('LOG IN');
  }

  void goToRegister() {
    print('Register');
  }

  @override
  Widget build(BuildContext context) {
    final Container loginForm = Container(
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          const InputText(
            hintText: 'Email',
          ),
          const SizedBox(height: 4),
          const InputText(
            hintText: 'Mot de passe',
            password: true,
          ),
          const SizedBox(height: 50),
          Button(label: 'Se Connecter', onPressed: handleLogin),
          const SizedBox(height: 14),
          Button(
            label: 'Créer un nouveau compte',
            color: const Color.fromARGB(255, 48, 48, 48),
            onPressed: goToRegister,
          ),
        ],
      ),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Spacer(),
            const Text(
              'Connecte toi a Messenger !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.25,
              ),
            ),
            loginForm,
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
