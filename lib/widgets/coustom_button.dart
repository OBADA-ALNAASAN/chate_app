import 'package:flutter/material.dart';

class CoustomButton extends StatelessWidget {
  const CoustomButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(

                // color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
