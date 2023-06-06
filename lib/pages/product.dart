import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/models/product_list.dart';
import 'package:nike_cart/pages/loading_page.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatefulWidget {
  ProductGridView({
    super.key,
    required List products,
  });

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  bool isLoading = false;
  List<Product> _products = [];
  void Function()? onTap;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  void _getProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("products").get();
      List<Product> products = [];
      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        Product product = Product.fromFirestore(docSnapshot);
        products.add(product);
      }
      setState(() {
        _products = products;
      });
    } catch (e) {
      print("Error retrieving products: $e");
    }
  }

  //search bar search fuction
  void _onSearchTextChanged(String searchText) async {
    if (searchText.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    // Create a Firestore query to search for products with the search term in their name or description
    Query query = FirebaseFirestore.instance
        .collection('products')
        .where('name', isGreaterThanOrEqualTo: searchText)
        .where('name', isLessThanOrEqualTo: searchText + '\uf8ff')
        .orderBy('name')
        .startAt([searchText]).endAt([searchText + '\uf8ff']);

    // Get the query results and map each document snapshot to a Product object
    List<Product> searchResults = [];
    try {
      QuerySnapshot snapshot = await query.get();
      if (snapshot.docs.isEmpty) {
        print('No search results found');
      } else {
        searchResults =
            snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
      }
    } catch (e) {
      print('Error searching for products: $e');
    }

    setState(() {
      _searchResults = searchResults;
    });
  }

  final _searchController = TextEditingController();
  List<Product> _searchResults = [];

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : Consumer<Cart>(
          builder: (context, value, child) => Scaffold(
            body: Column(
              children: [
                const Text(
                  'Shopping',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 10.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for a product',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 0),
                        ),
                        onChanged: _onSearchTextChanged,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(24.0),
                    itemCount: _products.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Product product = _products[index];
                      return Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                product.image.toString(),
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            product.name.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "₹${product.price!.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: onTap,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
}
