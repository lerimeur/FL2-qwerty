import 'package:email_validator/email_validator.dart';
import 'package:fl2_qwerty_messenger/Component/button.dart';
import 'package:fl2_qwerty_messenger/Component/inputText.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  void handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Register here
    }
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

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez remplir ce champ';
    }
    if (!EmailValidator.validate(value)) {
      return 'Veuillez entrer une adresse email valide';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez entrer un nom d'utilisateur";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Veuillez fournir un mot de passe";
    }
    if (value.length < 8 || value.length > 30) {
      return "Veuillez entrer un mot de passe de 8 à 30 caractères";
    }
    return null;
  }

  String? validateComfirmPassword(String? value) {
    if (value != password) {
      return 'Les mots de passes ne correspondent pas';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Form registerForm = Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          InputText(
            validator: validateEmail,
            hintText: 'Email',
            onChanged: (dynamic value) {
              setMail(value);
            },
          ),
          const SizedBox(height: 4),
          InputText(
            validator: validateUsername,
            hintText: "Nom d'utilisateur",
            onChanged: (dynamic value) {
              setUsername(value);
            },
          ),
          const SizedBox(height: 4),
          InputText(
            validator: validatePassword,
            hintText: 'Mot de passe',
            password: true,
            onChanged: (dynamic value) {
              setPassword(value);
            },
          ),
          const SizedBox(height: 4),
          InputText(
            validator: validateComfirmPassword,
            hintText: 'Confirmer le mot de passe',
            password: true,
            onChanged: (dynamic value) {
              setConfirmPassword(value);
            },
          ),
          const SizedBox(height: 50),
          Button(
            label: 'Créer le compte',
            onPressed: handleRegister,
          ),
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
