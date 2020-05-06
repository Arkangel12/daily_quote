import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:daily_quote/src/components/manageImage.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {

  const UserProfile();

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Image avatar;

  @override
  void initState() {
    ManageImage.getImageFromPreferences().then((saveImage) {
      setState(() {
        avatar = ManageImage.imageFromBase64String(saveImage);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        backgroundColor: AppColors.pinkLightest,
        body: SafeArea(
          child: Consumer<UserProvider>(
            builder: (_, snapshot, __) {
              snapshot.getCurrentUser();
              if (snapshot.user != null) {
                return ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 150,
                        height: 150,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width,
                            ),
                            child: avatar,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            '${snapshot.user.name} ${snapshot.user.lastName}',
                            textAlign: TextAlign.center,
                            style: AppStyles.bodySemiBold,
                          ),
                          Text(
                            'Email: \n${snapshot.user.email}',
                            textAlign: TextAlign.center,
                            style: AppStyles.bodyLight,
                          ),
                          Text(
                            'Phone Number: \n${snapshot.user.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: AppStyles.bodyLight,
                          ),
                          Text(
                            'Address: \n${snapshot.user.address}',
                            textAlign: TextAlign.center,
                            style: AppStyles.bodyLight,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.pinkLight),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
