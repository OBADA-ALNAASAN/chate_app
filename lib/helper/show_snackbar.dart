 import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String t) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));
  }