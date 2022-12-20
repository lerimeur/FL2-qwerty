import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/inputText.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  void handleRegister() {
    print('Register $email $username $password $confirmPassword');
  }

  void goToLogin() {
    print('Login');
  }

  void setMail(String value) {
    setState(() {
      email = value;
    });
  }

  void setUsername(String value) {
    setState(() {
      username = value;
    });
  }

  void setPassword(String value) {
    setState(() {
      password = value;
    });
  }

  void setConfirmPassword(String value) {
    setState(() {
      confirmPassword = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Form registerForm = Form(
      child: Column(
        children: [
          InputText(
            hintText: 'Email',
            onChanged: (dynamic value) {
              setMail(value);
            },
          ),
          const SizedBox(height: 4),
          InputText(
            hintText: "Nom d'utilisateur",
            onChanged: (dynamic value) {
              setUsername(value);
            },
          ),
          const SizedBox(height: 4),
          InputText(
            hintText: 'Mot de passe',
            password: true,
            onChanged: (dynamic value) {
              setPassword(value);
            },
          ),
          const SizedBox(height: 50),
          Button(label: 'Créer le compte', onPressed: handleRegister),
          const SizedBox(height: 14),
          Button(
            label: 'Se connecter',
            color: const Color.fromARGB(255, 48, 48, 48),
            onPressed: goToLogin,
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
            Container(
              margin: const EdgeInsets.only(bottom: 25.0),
              child: const Text(
                'Crée un nouveau compte sur Messenger !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
            ),
            registerForm,
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
