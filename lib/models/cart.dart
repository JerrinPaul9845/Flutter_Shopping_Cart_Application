import 'package:flutter/widgets.dart';
import 'package:nike_cart/models/shoes.dart';

class Cart extends ChangeNotifier {
  //list of items
  List<Shoe> shoeShop = [
    Shoe(
        name: 'Nike Dunks',
        price: '9000',
        imagePath: 'assets/images/image_8.jpg',
        description: 'This product is excludede from all discounts.'),
    Shoe(
        name: 'Zion 2 PF',
        price: '10000',
        imagePath: 'assets/images/image_3.jpg',
        description: 'This product is excludede from all discounts.'),
    Shoe(
        name: 'Nike Invincible',
        price: '12000',
        imagePath: 'assets/images/image_4.jpg',
        description: 'This product is excludede from all discounts.'),
    Shoe(
        name: 'Nike Pegasus',
        price: '9500',
        imagePath: 'assets/images/image_5.jpg',
        description: 'This product is excludede from all discounts.'),
    Shoe(
        name: 'Nike Penny',
        price: '13000',
        imagePath: 'assets/images/image_2.jpg',
        description: 'This product is excludede from all discounts.'),
  ];

  //list of items in user cart
  List<Shoe> userCart = [];

  //list of shoes for sale
  List<Shoe> getShoesList() {
    return shoeShop;
  }

  //get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  //add item to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  //remove item from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
