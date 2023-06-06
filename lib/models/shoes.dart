import 'package:nike_cart/models/product_list.dart';

class Shoe {
  final String name;
  final String price;
  final String imagePath;
  final String description;

  Shoe(
      {required this.name,
      required this.price,
      required this.imagePath,
      required this.description});

  static Product fromProduct(Product product) {
    return Product(
      name: product.name,
      price: product.price,
      image: product.image,
      description: product.description,
    );
  }
}
