import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/pages/intro_page.dart';
import 'package:nike_cart/pages/login_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: ChangeNotifierProvider(
        create: (context) => Cart(),
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AnimatedSplashScreen(
            duration: 5000,
            splash: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
            nextScreen: user != null ? const IntroPage() : const LoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: const Color.fromARGB(255, 33, 33, 33),
            pageTransitionType: PageTransitionType.leftToRight,
          ),
        ),
      ),
    );
  }
}
