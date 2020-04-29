import 'dart:io';
import 'dart:typed_data';

import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:daily_quote/src/components/manageImage.dart';
import 'package:daily_quote/src/components/register/imageStatusWidget.dart';
import 'package:daily_quote/src/components/validators.dart';
import 'package:daily_quote/src/models/user.dart';
import 'package:daily_quote/src/repositories/userRepository.dart';
import 'package:daily_quote/src/screens/loginScreen.dart';
import 'package:daily_quote/src/states/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();

  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeLastName = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  final FocusNode _nodePhoneNumber = FocusNode();
  final FocusNode _nodeAddress = FocusNode();

  Future<File> imageFile;
  Uint8List imageData;
  bool showEmptyImageError = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeName,
        ),
        KeyboardAction(
          focusNode: _nodeLastName,
        ),
        KeyboardAction(
          focusNode: _nodeEmail,
        ),
        KeyboardAction(
          focusNode: _nodePassword,
        ),
        KeyboardAction(
          focusNode: _nodePhoneNumber,
        ),
        KeyboardAction(
          focusNode: _nodeAddress,
        ),
      ],
    );
  }

  getFromImageFrom(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: KeyboardActions(
          config: _buildConfig(context),
          child: Form(
            key: formKey,
            child: Stack(
              children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                  children: [
                    Container(
                      height: 60,
                      child: Text(
                        'Register',
                        style: AppStyles.h1Heading,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: FutureBuilder(
                              future: imageFile,
                              builder: (_, AsyncSnapshot<File> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.data != null) {
                                    imageData = snapshot.data.readAsBytesSync();
                                    showEmptyImageError = false;
                                    return AnimatedContainer(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.bounceIn,
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.pinkLight,
                                        image: DecorationImage(
                                          image: FileImage(snapshot.data),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  }
                                }

                                return const ImageStatusWidget('Choose Image');
                              },
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.camera_front,
                                    color: AppColors.pinkLight,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    getFromImageFrom(ImageSource.gallery);
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    color: AppColors.pinkLight,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        key: Key('name'),
                        validator: Validators.validateName,
                        onSaved: (String value) => _nameController.text = value,
                        controller: _nameController,
                        focusNode: _nodeName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Name',
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
                        key: Key('lastname'),
                        validator: Validators.validateLastName,
                        onSaved: (String value) => _lastNameController.text = value,
                        controller: _lastNameController,
                        focusNode: _nodeLastName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Last Name',
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
                        key: Key('email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                        onSaved: (String value) => _emailController.text = value,
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
                        key: Key('password'),
                        validator: Validators.validatePassword,
                        onSaved: (String value) => _passwordController.text = value,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextFormField(
                        key: Key('phone'),
                        keyboardType: TextInputType.number,
                        validator: Validators.validatePhoneNumber,
                        onSaved: (String value) =>
                            _phoneNumberController.text = value,
                        controller: _phoneNumberController,
                        focusNode: _nodePhoneNumber,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Phone Number',
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
                        key: Key('address'),
                        validator: Validators.validateAddress,
                        onSaved: (String value) => _addressController.text = value,
                        controller: _addressController,
                        focusNode: _nodeAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Address',
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
                    FlatButton(
                      key: Key('create'),
                      splashColor: AppColors.pinkLightest,
                      onPressed: () {
                        if (imageData != null) {
                          if (validateAndSave()) {
                            ManageImage.saveImageToPreferences(
                              ManageImage.base64String(imageData),
                            );

                            User user = User(
                              name: _nameController.text,
                              lastName: _lastNameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              phoneNumber: _phoneNumberController.text,
                              address: _addressController.text,
                            );

                            Provider.of<UserProvider>(context, listen: false).saveUser(user);
//                        Navigator.of(context).pop(LoginScreen.route());
//                        UserRepository().saveUser(user: user).then((_) {
//                          Navigator.of(context).pop(LoginScreen.route());
////                          Provider.of<UserProvider>(context, listen: false).setRegistered(true);
//                        });
                          }
                        } else {
                          setState(() => showEmptyImageError = true);
                        }
                      },
                      child: Text(
                        'Create',
                        style: AppStyles.h3HeadingNormal.apply(fontWeightDelta: 3),
                      ),
                    ),
                  ],
                ),
                AnimatedPositioned(
                  top: showEmptyImageError ? 90 : -180,
                  left: MediaQuery.of(context).size.width / 2 -75,
                  duration: Duration(milliseconds: 500),
                  child: CircleAvatar(
                    maxRadius: 75,
                    backgroundColor: AppColors.pinkLightest,
                    child: Text('No Image Selected', style: AppStyles.smallBodySemiBold.apply(color: AppColors.raspberry),),
                  ),
                )
              ],
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
