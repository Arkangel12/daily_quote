import 'package:after_layout/after_layout.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:daily_quote/src/screens/quoteScreen.dart';
import 'package:daily_quote/src/screens/rootScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with AfterLayoutMixin<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset('assets/images/iconPink.png'),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (){ //Mock call delay
      SharedPreferences.getInstance().then((prefs) {
        bool registered = prefs.getBool('registered') ?? false;
        String token = prefs.getString('token');

        if (registered && token != null)
          Navigator.of(context).push(QuoteScreen.route());
        else
          Navigator.of(context).push(RootScreen.route());
      });
    });
  }
}
