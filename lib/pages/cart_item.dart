import 'package:flutter/material.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/models/shoes.dart';
import 'package:nike_cart/snackbar/snackbar_notification.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  Shoe shoe;
  CartItem({
    super.key,
    required this.shoe,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void removeItemFromCart() {
    //remove item from cart
    Provider.of<Cart>(context, listen: false).removeItemFromCart(widget.shoe);
    //showing message if shoe is removed from cart
    showSuccessMessage(context, message: 'Deleted item from cart');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        leading: Image.asset(widget.shoe.imagePath),
        title: Text(widget.shoe.name),
        subtitle: Text(widget.shoe.price),
        trailing: IconButton(
            onPressed: removeItemFromCart, icon: const Icon(Icons.delete)),
      ),
    );
  }
}
