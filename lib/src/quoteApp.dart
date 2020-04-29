import 'package:daily_quote/src/screens/splashScreen.dart';
import 'package:daily_quote/src/states/quoteProvider.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: SplashScreen(),
      ),
    );
  }
}