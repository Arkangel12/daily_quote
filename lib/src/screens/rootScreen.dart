import 'package:daily_quote/src/models/user.dart';
import 'package:daily_quote/src/screens/loginScreen.dart';
import 'package:daily_quote/src/screens/registerScreen.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatelessWidget {

  static Route<dynamic> route() { //registered
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: RootScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, snapshot, __){
        snapshot.getRegistered();
        if(snapshot.registered != null && snapshot.registered)
          return LoginScreen();
        else
          return RegisterScreen();
      },
    );
  }
}
