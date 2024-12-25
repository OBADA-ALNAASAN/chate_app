import 'package:flutter/material.dart';

class Coustomtextformfield extends StatelessWidget {
  const Coustomtextformfield(
     {super.key, required this.hintText, this.onChange, this.abscureText =false});
  final String hintText;
  final Function(String)? onChange;
  final bool? abscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: abscureText!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'field is required';
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: onChange,
    );
  }
}
