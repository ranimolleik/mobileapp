import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ranim_flutter/screens/home.dart';
import 'package:ranim_flutter/screens/home.dart';
import 'package:ranim_flutter/screens/login.dart';
import 'package:ranim_flutter/screens/signup.dart';
import 'package:ranim_flutter/screens/auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vintage Clothes',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
