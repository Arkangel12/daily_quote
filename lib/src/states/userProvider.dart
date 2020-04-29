
import 'package:daily_quote/src/components/sharedPrefs.dart';
import 'package:daily_quote/src/models/user.dart';
import 'package:daily_quote/src/repositories/userRepository.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User _user;
  bool _registered;
  String _token;

  User get user => _user;
  bool get registered => _registered;
  String get token => _token;

  void getCurrentUser() async {
    _user = User.fromJson(await SharedPrefs().readUser("user"));
    notifyListeners();
  }

  void getRegistered() async {
    _registered = await SharedPrefs().readBool('registered');
    notifyListeners();
  }

  void userAuthenticate() async {
    _token = await UserRepository().authenticate();
    notifyListeners();
  }

  void saveUser(User user) async {
    print('entre saveUser Provider');
    await UserRepository().saveUser(user: user);
    _registered = true;
    notifyListeners();
  }


}
