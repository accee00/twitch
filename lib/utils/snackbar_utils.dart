import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.deepPurple,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Colors.yellow,
        onPressed: () {},
      ),
    ),
  );
}
