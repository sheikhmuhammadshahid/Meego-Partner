import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../res/colors.dart';

class MyField extends StatefulWidget {
  //
  const MyField({
    Key key,
    this.label,
    this.isPass,
    this.controller,
    this.isReadOnly = false,
  }) : super(key: key);
  //
  final String label;
  final bool isPass;
  final TextEditingController controller;
  final bool isReadOnly;

  @override
  State<MyField> createState() => _MyFieldState();
}

class _MyFieldState extends State<MyField> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPass ? isShow : false,
        readOnly: widget.isReadOnly,
        decoration: InputDecoration(
          fillColor: AppColors.greyLight,
          hintText: widget.label,
          filled: true,
          enabled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          suffixIcon: widget.isPass ? _toggle() : const SizedBox.shrink(),
        ),
        validator: (value) {
          if (widget.label.contains('Email')) {
            return !EmailValidator.validate(value)
                ? 'Enter correct email'
                : null;
          }
          if (widget.label.contains('Password')) {
            return value.isEmpty ? 'fill this field' : null;
          }
          if (widget.label.contains('Confirm Password')) {
            // int isEqual = context
            //     .read<AuthController>()
            //     .cConfirmPassword
            //     .text
            //     .compareTo(context.read<AuthController>().cPassword.text);
            bool isEqual = true;
            if (isEqual) {
              return null;
            } else {
              return 'password not same';
            }
          }
          if (widget.label.contains('Referral Code')) {
            return null;
          } else {
            value.isEmpty ? "fill this filed" : null;
          }
          return null;
        },
      ),
    );
  }

  Widget _toggle() {
    return isShow
        ? IconButton(
            onPressed: () => setState(() {
              isShow = false;
            }),
            icon: const Icon(Icons.visibility),
          )
        : IconButton(
            onPressed: () => setState(() {
              isShow = true;
            }),
            icon: const Icon(Icons.visibility_off),
          );
  }
}
