import 'package:cart/components/my_list_tile.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // icon
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Center(
                  child: Icon(
                    Icons.trolley,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              //btns
              MyListTile(text: 'Home', icon: Icons.home, onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/home_page');
              }),
              MyListTile(text: 'Cart', icon: Icons.shopping_cart, onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(context, '/cart_page');
              }),
          
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: MyListTile(text: 'Exit', icon: Icons.logout, onTap: (){
              Navigator.pop(context);

              Navigator.pushNamed(context, '/intro_page');
            }),
          ),
        ],
      ),
    );
  }
}