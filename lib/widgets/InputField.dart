import 'package:flutter/material.dart';
import 'package:news_app/utils/constants.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required TextEditingController nameController,
    required String hintText,
    required bool obscureText,
    required Icon suffixIcon,
  })  : _nameController = nameController,
        hintText = hintText,
        obscureText = obscureText,
        suffixIcon = suffixIcon;

  final String hintText;
  final Icon suffixIcon;
  final bool obscureText;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        TextFormField(
          obscureText: obscureText,
          controller: _nameController,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            suffixIconColor: kPrimaryColor,
            focusColor: kPrimaryColor,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
