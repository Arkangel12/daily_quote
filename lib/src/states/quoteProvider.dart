import 'package:daily_quote/src/models/quote.dart';
import 'package:daily_quote/src/repositories/quoteRepository.dart';
import 'package:flutter/material.dart';

class QuoteProvider with ChangeNotifier {
  Quote _quote;

  Quote get quote => _quote;

  void getDailyQuote() async {
   _quote = await QuoteRepository().getDailyQuote();
   notifyListeners();
  }
}
