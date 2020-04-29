import 'dart:async';

import 'package:daily_quote/src/models/user.dart';
import 'package:daily_quote/src/repositories/userRepository.dart';
import 'package:daily_quote/src/screens/registerScreen.dart';
import 'package:daily_quote/src/screens/splashScreen.dart';
import 'package:daily_quote/src/states/quoteProvider.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Run this test flutter test test/providers_test/provider_test.dart

//class MockUser extends Mock implements UserRepository {}

void main() async {
//  UserProvider _userProvider;
//  StreamController<UserProvider> _controller;
  User _userModel = User(
    name: 'Argel',
    lastName: 'Bejarano',
    email: 'argel.bc18@gmail.com',
    password: '123456',
    phoneNumber: '6622791358',
    address: 'address',
  );

//  setUp(() {
//    _controller = StreamController<UserProvider>();
//    _userProvider = UserProvider();
//  });

//  group('[]', () {});

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
//    MockUser mockUser = MockUser();

    await tester.pumpWidget(_TestWidget(
      child: RegisterScreen(),
    ));
    await tester.pump(Duration.zero);

    await tester.tap(find.byKey(Key('create')));
    
    expect(find.byKey(Key('create')), findsOneWidget);

//    verifyNever(mockUser.saveUser(user: _userModel));
  });

  testWidgets('Should passed on tap button ', (tester) async {
//    MockUser mockUser = MockUser();

    await tester.pumpWidget(_TestWidget(
      child: RegisterScreen(),
    ));
    await tester.pump(Duration.zero);

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

    expect(find.byKey(Key('create')), findsNothing);

//    verify(mockUser.saveUser(user: _userModel)).called(1);
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
