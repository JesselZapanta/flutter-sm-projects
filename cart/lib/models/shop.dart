import 'package:cart/models/product.dart';

class Shop {
  //list of products

  final List<Product> _shop = [
    Product(
      name: 'shabu',
      price: 150,
      description: 'maka adik',
      // imagePath: imagePath,
    ),
  ];

  //user cart
  List<Product> _cart = [];

  //getters for list of products
  List<Product> get shop => _shop;

  //getters for user cart
  List<Product> get cart => _cart;

  //add item to the cart
  void addToCart(Product product){
    _cart.add(product);
  }

  //remove item to the cart
  void removeToCart(Product product){
    _cart.remove(product);
  }
}
