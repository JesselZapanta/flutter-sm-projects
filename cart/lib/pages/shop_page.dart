import 'package:cart/components/my_drawer.dart';
import 'package:flutter/material.dart';

class MyShopPage extends StatelessWidget {
  const MyShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text('Minimal Shop'),
      ),
      drawer: MyDrawer(),
    );
  }
}