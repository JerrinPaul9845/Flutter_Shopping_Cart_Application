import 'package:flutter/material.dart';
import 'package:nike_cart/pages/cart_item.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/models/shoes.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My cart',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                itemCount: value.getUserCart().length,
                itemBuilder: (context, index) {
                  //get individual shoe
                  Shoe individualShoe = value.getUserCart()[index];

                  //return the cart item
                  return CartItem(shoe: individualShoe);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
