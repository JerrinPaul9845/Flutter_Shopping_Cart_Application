import 'package:flutter/material.dart';
import 'package:nike_cart/pages/home_page.dart';
import 'package:nike_cart/pages/loading_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 240,
                    ),
                  ),

                  const SizedBox(height: 48),

                  //text
                  const Text(
                    'Just Do It',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  //guesture detection for a container
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(25),
                        child: const Center(
                          child: Text(
                            'Start Shopping',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
}
