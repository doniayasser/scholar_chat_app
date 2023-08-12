import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_page.dart';
import 'package:scholar_chat/pages/register_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
        HomeScreen.id: (context) =>  HomeScreen() ,
        RegisterScreen.id: (context) =>  RegisterScreen() ,
        ChatScreen.id: (context) =>  ChatScreen() ,
      },
      //initialRoute:  ChatScreen.id,
      home:  HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
