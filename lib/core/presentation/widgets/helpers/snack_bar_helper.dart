import 'package:flutter/material.dart';

abstract class SnackBarHelper {
  static void show({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')));
  }
}
