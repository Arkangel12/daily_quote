import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:daily_quote/src/components/biometrics.dart';
import 'package:daily_quote/src/components/validators.dart';
import 'package:daily_quote/src/models/user.dart';
import 'package:daily_quote/src/screens/quoteScreen.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: LoginScreen(),
      ),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AfterLayoutMixin<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  bool loginError = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics;

  _authenticate() async {
    bool authenticated = false;

    authenticated = await Biometrics().authenticate();

    if (authenticated) {
      Provider.of<UserProvider>(context, listen: false).userAuthenticate();
      Navigator.of(context).push(QuoteScreen.route());
    }
  }

  _isBiometricAllow() async {
    _canCheckBiometrics = await Biometrics().checkBiometrics() ?? false;
    _availableBiometrics = await Biometrics().getAvailableBiometrics() ?? [];
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _isBiometricAllow();
  }

  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).getCurrentUser();
    super.initState();
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeEmail,
        ),
        KeyboardAction(
          focusNode: _nodePassword,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: KeyboardActions(
          config: _buildConfig(context),
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(flex: 2),
                    Text(
                      'Daily Quote',
                      style: AppStyles.h1Heading,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        key: Key('emailLogin'),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                        onSaved: (String value) =>
                            _emailController.text = value,
                        controller: _emailController,
                        focusNode: _nodeEmail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Email',
                          labelStyle: AppStyles.bodySemiBold
                              .apply(color: AppColors.pinkLighter),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.pinkLight),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        key: Key('passwordLogin'),
                        validator: Validators.validatePassword,
                        onSaved: (String value) =>
                            _passwordController.text = value,
                        controller: _passwordController,
                        obscureText: true,
                        focusNode: _nodePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Password',
                          labelStyle: AppStyles.bodySemiBold
                              .apply(color: AppColors.pinkLighter),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.pinkLight),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (_canCheckBiometrics && _availableBiometrics.length > 0)
                          if (Platform.isIOS &&
                              _availableBiometrics.contains(BiometricType.face))
                            IconButton(
                              onPressed: () {
                                _authenticate();
                              },
                              icon: Icon(Icons.face),
                              iconSize: 34,
                            )
                          else
                            IconButton(
                              onPressed: () {
                                _authenticate();
                              },
                              icon: Icon(Icons.fingerprint),
                              iconSize: 34,
                            ),
                        FlatButton(
                          key: Key('login'),
                          splashColor: AppColors.pinkLightest,
                          onPressed: () {
                            if (validateAndSave()) {
                              User user = Provider.of<UserProvider>(context,
                                      listen: false)
                                  .user;

//                              print(user.toJson().toString());

                              if (user.email == _emailController.text &&
                                  user.password == _passwordController.text) {
                                _emailController.text = '';
                                _passwordController.text = '';
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .userAuthenticate();
                                Navigator.of(context).push(QuoteScreen.route());
                              }
                            } else {
                              setState(() {
                                loginError = true;
                              });
                            }
                          },
                          child: Text(
                            'Login',
                            style: AppStyles.h3HeadingNormal
                                .apply(fontWeightDelta: 3),
                          ),
                        ),
                      ],
                    ),
                    if (loginError)
                      Opacity(
                        opacity: loginError ? 0.9 : 0.0,
                        child: Text(
                          'Error with email or password',
                          style: AppStyles.smallBodySemiBold
                              .apply(color: AppColors.raspberry),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Spacer(),
                    Container(
                      height: 100,
                      width: 100,
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset('assets/images/iconPink.png'),
                      ),
                    ),
                    Spacer(flex: 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
