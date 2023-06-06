import 'package:flutter/material.dart';
import 'package:nike_cart/component/shoe_tile.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/models/shoes.dart';
import 'package:nike_cart/snackbar/snackbar_notification.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _CartPageState();
}

class _CartPageState extends State<ShopPage> {
  //add shoe to cart
  void addShoesToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    //showing message if shoe is added to cart
    showSuccessMessage(context, message: 'Sucessfully added to cart');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            const Text(
              'Shopping',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 10),

            // list of shoes for sale
            Expanded(
              // showing the list in grid view
              child: GridView.builder(
                itemCount: value.getShoesList().length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  // get shoes from shoes list
                  Shoe shoe = value.getShoesList()[index];

                  // return the shoes
                  return ShoeTile(
                      shoe: shoe,
                      onTap: () {
                        addShoesToCart(shoe);
                      });
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
              child: Divider(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
