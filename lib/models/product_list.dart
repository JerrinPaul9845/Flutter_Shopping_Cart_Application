import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? name;
  double? price;
  String? image;
  String? description;

  Product({this.name, this.price, this.image, this.description});

  static Product fromFirestore(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        (documentSnapshot.data() as Map<String, dynamic>);
    return Product(
      name: data["name"],
      price: double.tryParse(data["price"].toString()),
      image: data["image"],
      description: data["description"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "price": price,
      "image": image,
      "description": description,
    };
  }

  static Future<List<Product>> getProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("products").get();
      List<Product> products = [];
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Product product = Product.fromFirestore(docSnapshot);
        products.add(product);
      }
      return products;
    } catch (e) {
      print("Error retrieving products: $e");
      return [];
    }
  }
}
