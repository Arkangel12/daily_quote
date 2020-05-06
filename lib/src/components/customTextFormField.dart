import 'package:daily_quote/src/components/AppStyles.dart';
import 'package:daily_quote/src/components/appColors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;

  const CustomTextFormField({
    Key key,
    this.controller,
    this.label,
    this.obscure = false,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
//        validator: Validators.validateString,
//        onSaved: (String value) => widget.controller.text = value,
        controller: widget.controller,
        obscureText: widget.obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: '${widget.label}',
          labelStyle:
          AppStyles.bodySemiBold.apply(color: AppColors.pinkLighter),
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
    );
  }
}