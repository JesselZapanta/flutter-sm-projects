import 'package:cart/pages/cart_page.dart';
import 'package:cart/pages/intro_page.dart';
import 'package:cart/pages/shop_page.dart';
import 'package:cart/themes/light_mode.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
      theme: lightMode,
      routes: {
        '/intro_page': (context) => const IntroPage(),
        '/home_page': (context) => const MyShopPage(),
        '/cart_page': (context) => const CartPage(),
      },
    );
  }
}