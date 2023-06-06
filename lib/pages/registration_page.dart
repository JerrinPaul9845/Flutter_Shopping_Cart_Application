import 'package:flutter/material.dart';
import 'package:nike_cart/pages/login_page.dart';
import 'package:nike_cart/snackbar/snackbar_notification.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  void login(String name, password) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 33, 33, 33),
          Color.fromARGB(255, 66, 66, 66),
          Color.fromARGB(255, 158, 158, 158)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "SignUP",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create your account",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 196, 196, 196),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 238, 238, 238)))),
                                child: TextField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 238, 238, 238)))),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 238, 238, 238)))),
                                child: TextField(
                                  obscureText: true,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) async {
                              showSuccessMessage(context,
                                  message: 'Registered Successfully.');
                              Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: const LoginPage(),
                                    inheritTheme: true,
                                    ctx: context),
                              );
                            }).onError((error, stackTrace) {
                              showFailMessage(context,
                                  message: 'Error could not register.');
                              print('Error ${error.toString()}');
                            });
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey[900]),
                            child: const Center(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
