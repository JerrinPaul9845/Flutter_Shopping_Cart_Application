import 'package:flutter/material.dart';

void showSuccessMessage(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.all(20.0),
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      style: const TextStyle(fontSize: 15.0),
    ),
    backgroundColor: Colors.grey[900],
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showFailMessage(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    padding: const EdgeInsets.all(20.0),
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      style: const TextStyle(fontSize: 15.0),
    ),
    backgroundColor: Colors.red[500],
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
