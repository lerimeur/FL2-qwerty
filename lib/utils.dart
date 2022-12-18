import 'package:flutter/material.dart';

class API with ChangeNotifier {
  late String name = 'home';

  void updateToken(String value) {
    name = value;
    notifyListeners();
  }
}
