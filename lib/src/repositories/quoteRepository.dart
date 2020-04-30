import 'package:daily_quote/src/models/quote.dart';
import 'package:http/http.dart' as http;

abstract class QuoteBase {
  Future<Quote> getDailyQuote();
}

class QuoteRepository with QuoteBase {
  @override
  Future<Quote> getDailyQuote() async {
    var response = await http.get("https://quotes.rest/qod");
    return quoteFromJson(response.body);
  }
}
