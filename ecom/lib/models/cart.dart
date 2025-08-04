import 'package:ecom/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier{
  //list of shoes for sales
  List<Shoe> shoeShop = [
    Shoe(
      name: 'NIKE DUNK LOW RETRO SE',
      price: '129.99',
      description: 'A stylish and iconic Nike Dunk perfect for everyday wear.',
      imagePath: 'lib/img/NIKE DUNK LOW RETRO SE.png',
    ),
    Shoe(
      name: 'NIKE INITIATOR',
      price: '89.99',
      description: 'Classic Nike trainers built for comfort and support.',
      imagePath: 'lib/img/NIKE INITIATOR.png',
    ),
    Shoe(
      name: 'W AIR FORCE 1 07',
      price: '119.99',
      description:
          'Women’s edition of the timeless Air Force 1, fresh and clean.',
      imagePath: 'lib/img/W AIR FORCE 1 07.png',
    ),
    Shoe(
      name: 'W NIKE AIR PEGASUS 2005',
      price: '109.99',
      description: 'Throwback vibes with modern cushioning for daily runs.',
      imagePath: 'lib/img/W NIKE AIR PEGASUS 2005.png',
    ),
  ];


  //list of items in user cart
  List<Shoe> userCart = [];

  //get list of items for sale
  List<Shoe> getShoeList(){
    return shoeShop;
  }
  
  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  //add items from the cart
  void addItemsToCart(Shoe shoe){
    userCart.add(shoe);
    notifyListeners();
  }

  //remove items from cart
  void removeItemsToCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
