
import 'package:daily_quote/src/repositories/quoteRepository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<QuoteBase>(() => QuoteRepository());
}