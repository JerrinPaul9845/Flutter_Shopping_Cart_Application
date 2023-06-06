import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nike_cart/models/cart.dart';
import 'package:nike_cart/models/push_notification.dart';
import 'package:nike_cart/navbar/bottom_nav_bar.dart';
import 'package:nike_cart/pages/cart_page.dart';
import 'package:nike_cart/pages/loading_page.dart';
import 'package:nike_cart/pages/login_page.dart';
import 'package:nike_cart/pages/shop_page.dart';
import 'package:nike_cart/snackbar/snackbar_notification.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  void registerNotification() async {
    //Initialize the Firebase app
    await Firebase.initializeApp();
    //Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(
            'Message title: ${message.notification?.title}, body: ${message.notification?.body}, data: ${message.data}');

        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );

        setState(() {
          _notificationInfo = notification;
        });

        if (_notificationInfo != null) {
          // For displaying the notification as an overlay
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
      });
    }
  }

  @override
  void initState() {
    registerNotification();
    checkForInitialMessage();

    // For handling notification when the app is in background but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      setState(() {
        _notificationInfo = notification;
      });
    });

    super.initState();
  }

  int _selectedindex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List<Widget> _screen = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Consumer<Cart>(
                builder: (context, value, child) => Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 25.0,
                      ),
                      onPressed: () {},
                      // onPressed: () {
                      //   Navigator.pop(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => ChangeNotifierProvider.value(
                      //         value: Provider.of<Cart>(context),
                      //         child: const CartPage(),
                      //       ),
                      //     ),
                      //   );
                      // },
                    ),
                    if (value.userCart.isNotEmpty)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            value.userCart.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.grey[300],
          bottomNavigationBar: BottomNavBar(
            onTabChange: (index) => navigateBottomBar(index),
          ),
          drawer: Drawer(
            backgroundColor: Colors.grey[900],
            child: Column(
              children: [
                DrawerHeader(
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Divider(
                    color: Colors.grey[700],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Shop',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 330),
                Padding(
                  padding: const EdgeInsets.only(left: 42.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 12.0),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: TextButton(
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              showSuccessMessage(context,
                                  message: 'Logged Out Successfully');
                              FirebaseAuth.instance.signOut().then((value) {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      child: const LoginPage(),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              }).onError((error, stackTrace) {
                                print('Error ${error.toString()}');
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: _screen[_selectedindex],
        );
}
