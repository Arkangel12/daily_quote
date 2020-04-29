import 'dart:convert';

import 'package:daily_quote/src/components/validators.dart';
import 'package:daily_quote/src/models/quote.dart';
import 'package:daily_quote/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() async {
  User _userModel;
  Quote _quoteModel;

  group('[User] Object', () {
    test('[User] Check individual values', () {
      _userModel = User(
        name: 'Argel',
        lastName: 'Bejarano',
        email: 'argel.bc18@gmail.com',
        password: 'password',
        phoneNumber: '6622791358',
        address: 'address',
      );

      //Effective use o model
      expect(_userModel.name, isNotEmpty);
      expect(_userModel.lastName, isNotEmpty);
      expect(_userModel.email, isNotEmpty);
      expect(_userModel.password, isNotEmpty);
      expect(_userModel.phoneNumber, isNotEmpty);
      expect(_userModel.address, isNotEmpty);

      // Types
      expect(_userModel.name.runtimeType, equals(String));
      expect(_userModel.lastName.runtimeType, equals(String));
      expect(_userModel.email.runtimeType, equals(String));
      expect(_userModel.password.runtimeType, equals(String));
      expect(_userModel.phoneNumber.runtimeType, equals(String));
      expect(_userModel.address.runtimeType, equals(String));
    });

    test('Parse JSON User to Object', () {
      const jsonString =
          '[{"name": "Argel", "last_name": "Bejarano", "email": "argel.bc18@gmail.com", "password": "123456", "phone_number": "6622791358", "address": "Vavaturu 24, Benei Residencial"}]';

      expect(userFromJson(jsonString).first, isNotNull);
      expect(userFromJson(jsonString).first.email, 'argel.bc18@gmail.com');
      expect(userFromJson(jsonString).length, 1);
      expect(userFromJson(jsonString)[0].image, null);
    });

    test('User Share Preferences', () async {
      SharedPreferences.setMockInitialValues(<String, dynamic>{'user': '{"name": "Argel", "last_name": "Bejarano", "email": "argel.bc18@gmail.com", "password": "123456", "phone_number": "6622791358", "address": "Vavaturu 24, Benei Residencial"}'});
      final prefs = await SharedPreferences.getInstance();
      final jsonUser = prefs.getString('user');

//      print('resultado $jsonUser');
      User user = User.fromJson(json.decode(jsonUser));

      expect(user.name, isNotNull);
      expect(user.name, 'Argel');
      expect(user.password, isNotNull);
      expect(user.phoneNumber.runtimeType, equals(String));
      expect(user.email.runtimeType, equals(String));
      expect(user.address.runtimeType, equals(String));

    });
  });

  group('[Form Test (Register and Login)]', () {
    test('empty name returns error string', () {
      final result = Validators.validateName('');
      expect(result, 'Name can\'t be empty');
    });

    test('non-empty name returns null', () {
      final result = Validators.validateName('name');
      expect(result, null);
    });

    test('empty lastname returns error string', () {
      final result = Validators.validateLastName('');
      expect(result, 'Last Name can\'t be empty');
    });

    test('non-empty lastname returns null', () {
      final result = Validators.validateLastName('lastname');
      expect(result, null);
    });

    test('empty email returns error string', () {
      final result = Validators.validateEmail('');
      expect(result, 'Email can\'t be empty');
    });

    test('non-empty email returns null', () {
      final result = Validators.validateEmail('email@email.com');
      expect(result, null);
    });

    test('empty email returns error string', () {
      final result = Validators.validatePassword('');
      expect(result, 'Password can\'t be empty');
    });

    test('non-empty password returns null', () {
      final result = Validators.validateEmail('email@email.com');
      expect(result, null);
    });

    test('empty phone number returns error string', () {
      final result = Validators.validatePhoneNumber('');
      expect(result, 'Phone Number can\'t be empty');
    });

    test('non-empty phone number returns null', () {
      final result = Validators.validatePhoneNumber('email@email.com');
      expect(result, null);
    });

    test('empty address returns error string', () {
      final result = Validators.validateAddress('');
      expect(result, 'Address can\'t be empty');
    });

    test('non-empty address returns null', () {
      final result = Validators.validateAddress('email@email.com');
      expect(result, null);
    });
  });

  group('[Quote] Object', () {
    test('[Quote] Check individual values', () {
      _quoteModel = Quote(
        success: Success(total: 1),
        baseurl: 'url',
        copyright: Copyright(year: 2020, url: 'otherUrl'),
        contents: Contents(quotes: [
          QuoteElement(
            quote: 'My quote',
            length: "8",
            author: 'Argel Bejarano',
            tags: ['BJJ', 'Calistenia', 'Basquet Ball'],
            category: 'human',
            language: 'en',
            date: DateTime.now(),
            permalink: 'link',
            id: 'id',
            background: 'imageurl',
            title: 'url',
          )
        ]),
      );

      //Effective use o model
      expect(_quoteModel.success.total, isNotNull);
      expect(_quoteModel.success.total, isNonNegative);
      expect(_quoteModel.baseurl, isNotEmpty);
      expect(_quoteModel.contents.quotes.length,  1);
      expect(_quoteModel.copyright.year, 2020);
      expect(_quoteModel.contents.quotes.length, 1);

      // Types
      expect(_quoteModel.success.runtimeType, Success().runtimeType);
      expect(_quoteModel.baseurl.runtimeType, equals(String));
      expect(_quoteModel.copyright.runtimeType, Copyright().runtimeType);
      expect(_quoteModel.contents.runtimeType, Contents().runtimeType);
      expect(_quoteModel.contents.quotes.runtimeType, List<QuoteElement>().runtimeType);
    });

    test('Parse JSON User to Object', () {
      const String jsonString = '''
{
  "success": {
    "total": 1
  },
  "contents": {
    "quotes": [
      {
        "quote": "Extend beyond your preconceived limits!",
        "length": "39",
        "author": "Lorii Myers",
        "tags": [
          "confidence",
          "inspire",
          "limit",
          "self-improvement"
        ],
        "category": "inspire",
        "language": "en",
        "date": "2020-04-28",
        "permalink": "https://theysaidso.com/quote/lorii-myers-extend-beyond-your-preconceived-limits",
        "id": "JRlytEdrKdV8iSCZCSEh6weF",
        "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
        "title": "Inspiring Quote of the day"
      }
    ]
  },
  "baseurl": "https://theysaidso.com",
  "copyright": {
    "year": 2022,
    "url": "https://theysaidso.com"
  }
}''';

      expect(quoteFromJson(jsonString).success.total, 1);
      expect(quoteFromJson(jsonString).copyright.year, isNotNull);
      expect(quoteFromJson(jsonString).contents.quotes.length, 1);
      expect(quoteFromJson(jsonString).contents.quotes[0].quote, 'Extend beyond your preconceived limits!');
      expect(quoteFromJson(jsonString).baseurl, 'https://theysaidso.com');
    });
  });
}
