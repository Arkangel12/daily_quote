import 'package:daily_quote/src/screens/loginScreen.dart';
import 'package:daily_quote/src/screens/quoteScreen.dart';
import 'package:daily_quote/src/screens/registerScreen.dart';
import 'package:daily_quote/src/screens/splashScreen.dart';
import 'package:daily_quote/src/states/quoteProvider.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  testWidgets('Should have an image on screen', (tester) async {
    await tester.pumpWidget(_TestWidget());
    await tester.pump(Duration.zero);

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Should have 6 TextFormField for user creation on first time',
      (tester) async {
    await tester.pumpWidget(_TestWidget(
      child: RegisterScreen(),
    ));
    await tester.pump(Duration.zero);

    expect(find.byType(TextFormField), findsNWidgets(6));
  });


  testWidgets('Should fail on tap button because fields will be empty',
      (tester) async {

    await tester.pumpWidget(_TestWidget(
      child: RegisterScreen(),
    ));
    await tester.pump(Duration.zero);

    await tester.tap(find.byKey(Key('create')));

    expect(find.byKey(Key('create')), findsOneWidget);

  });

  Skip('needs image from shared preferences');
  testWidgets('Should passed on tap button ', (tester) async {
    await tester.pumpWidget(_TestWidget(
      child: RegisterScreen(),
    ));
    await tester.pump(Duration.zero);

//    SharedPreferences.setMockInitialValues(
//        <String, dynamic>{'avata': 'fakeAvatar as Uint8List'});

    Finder nameFinder = find.byKey(Key('name'));
    await tester.enterText(nameFinder, 'Argel');

    Finder lastNameFinder = find.byKey(Key('lastname'));
    await tester.enterText(lastNameFinder, 'Bejarano');

    Finder emailFinder = find.byKey(Key('email'));
    await tester.enterText(emailFinder, 'argel.bc18@gmail.com');

    Finder passwordFinder = find.byKey(Key('password'));
    await tester.enterText(passwordFinder, '123456');

    Finder phoneFinder = find.byKey(Key('phone'));
    await tester.enterText(phoneFinder, '6622791358');

    Finder addressFinder = find.byKey(Key('address'));
    await tester.enterText(addressFinder, 'address');

    await tester.tap(find.byKey(Key('create')));
    await tester.pump();

    await tester.pumpWidget(_TestWidget(
      child: LoginScreen(),
    ));

    await tester.pump(Duration.zero);

    expect(find.byKey(Key('create')), findsNothing);
  });

  testWidgets('Should have 2 TextFormField and 1 button for user login',
      (tester) async {
    await tester.pumpWidget(_TestWidget(
      child: LoginScreen(),
    ));
    await tester.pump(Duration.zero);

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(FlatButton), findsNWidgets(1));
  });

  testWidgets(
      'Should fail login for empty TextFormField and label with information should appear',
      (tester) async {
    await tester.pumpWidget(_TestWidget(
      child: LoginScreen(),
    ));
    await tester.pump(Duration.zero);

    await tester.tap(find.byKey(Key('login')));
    await tester.pump();

    expect(find.text('Error with email or password'), findsNWidgets(1));
  });

  testWidgets('Do login and move to screen QuoteScreen', (tester) async {
    SharedPreferences.setMockInitialValues(<String, dynamic>{
      'user':
          '{"name": "Argel", "last_name": "Bejarano", "email": "argel.bc18@gmail.com", "password": "123456", "phone_number": "6622791358", "address": "Vavaturu 24, Benei Residencial"}'
    });
    await tester.pumpWidget(_TestWidget(
      child: LoginScreen(),
    ));
    await tester.pump(Duration.zero);

    Finder emailFinder = find.byKey(Key('emailLogin'));
    await tester.enterText(emailFinder, 'argel.bc18@gmail.com');

    Finder passwordFinder = find.byKey(Key('passwordLogin'));
    await tester.enterText(passwordFinder, '123456');

    await tester.tap(find.byKey(Key('login')));
    await tester.pump();

    await tester.pumpWidget(_TestWidget(
      child: QuoteScreen(),
    ));

    await tester.pump(Duration.zero);

    expect(find.byKey(Key('login')), findsNothing);
  });

  testWidgets('Verify widgets in QuoteScreen', (tester) async {
    await tester.pumpWidget(_TestWidget(
      child: QuoteScreen(),
    ));
    await tester.pump(Duration.zero);

    expect(find.byType(IconButton), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Signout QuoteScreen', (tester) async {
    SharedPreferences.setMockInitialValues(
        <String, dynamic>{'token': 'fakeToken'});

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    expect(token, 'fakeToken');

    await tester.pumpWidget(_TestWidget(
      child: QuoteScreen(),
    ));

    await tester.pump(Duration.zero);

    await tester.tap(find.byKey(Key('FAB')));

    token = prefs.getString('token');
    expect(token, null);
  });
}

class _TestWidget extends StatelessWidget {
  final Widget child;

  const _TestWidget({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: MaterialApp(
        home: child ?? SplashScreen(),
      ),
    );
  }
}
