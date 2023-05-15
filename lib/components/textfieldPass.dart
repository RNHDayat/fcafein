import 'package:flutter/material.dart';

class TextFieldPass extends StatefulWidget {
  const TextFieldPass({super.key});

  @override
  State<TextFieldPass> createState() => _TextFieldPassState();
}

class _TextFieldPassState extends State<TextFieldPass> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isObscure,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'password',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );
  }
}
