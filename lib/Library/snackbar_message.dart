import 'package:flutter/material.dart';

SnackBar snackBarMessage(String message) {
  return SnackBar(
    backgroundColor: Colors.white,
    elevation: 0,
    duration: const Duration(milliseconds: 1500),
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black87,
          fontFamily: "Sofia",
          fontWeight: FontWeight.w600,
          fontSize: 16),
    ),
  );
}
