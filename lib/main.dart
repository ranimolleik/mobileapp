import 'package:flutter/material.dart';
import 'package:ranim_flutter/screens/home.dart';
import 'package:ranim_flutter/screens/product_list.dart';
import 'package:provider/provider.dart';
import 'package:ranim_flutter/screens/cartprovider.dart';


void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => CartProvider(),
    child: MyApp(),
  ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),

    );
  }
}
