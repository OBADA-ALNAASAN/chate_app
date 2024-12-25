import 'package:chat_app/screens/chat_page.dart';
import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/register_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholerChat());
}

class ScholerChat extends StatelessWidget {
  const ScholerChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
       RegisterPage.id: (context) => const RegisterPage(),
       ChatPage.id: (context) => const ChatPage(),
        
      },
      initialRoute:  LoginPage.id,
    );
  }
}
