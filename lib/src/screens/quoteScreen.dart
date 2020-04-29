import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:daily_quote/src/components/sharedPrefs.dart';
import 'package:daily_quote/src/screens/loginScreen.dart';
import 'package:daily_quote/src/states/quoteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuoteScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: QuoteScreen(),
      ),
    );
  }

  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  void initState() {
    print('no hara llamada esta comentada');
//    Provider.of<QuoteProvider>(context, listen: false).getDailyQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<QuoteProvider>(
          builder: (_, snapshot, __) {
            print(snapshot.quote);
            if (snapshot.quote != null)
              return ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                    'A Quote For You',
                    style: AppStyles.h1HeadingBlack
                        .apply(color: AppColors.raspberry),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    height: 300,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .1,
                        bottom: 20),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned.fill(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Opacity(
                                opacity: .7,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      snapshot.quote.contents.quotes.first.background,
                                  fit: BoxFit.cover,
                                  colorBlendMode: BlendMode.color,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -45,
                          left: 10,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.format_quote,
                              color: AppColors.raspberry,
                              size: 50,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -45,
                          right: 10,
                          child: Icon(
                            Icons.format_quote,
                            color: AppColors.raspberry,
                            size: 50,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, top: 24),
                            child: Text(
                              snapshot.quote.contents.quotes.first.quote,
                              textAlign: TextAlign.right,
                              style: AppStyles.bodyExtraSemiBoldItalic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 60.0,
                    ),
                    child: Text(
                      snapshot.quote.contents.quotes.first.author,
                      style: AppStyles.h4Heading.apply(color: AppColors.black),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );

            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.raspberry),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.raspberry,
        onPressed: () {
          SharedPrefs().remove('token');
          Navigator.of(context).push(LoginScreen.route());
        },
        child: Icon(
          Icons.exit_to_app,
          color: AppColors.black,
        ),
      ),
    );
  }
}