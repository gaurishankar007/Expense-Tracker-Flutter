import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Message {
  final String message;
  final int time;
  final Color bgColor;
  final Color textColor;
  final double fontSize;

  const Message({
    required this.message,
    required this.time,
    required this.bgColor,
    required this.textColor,
    this.fontSize = 16,
  });

  Future<bool?> _showMessage() async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: time,
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: fontSize,
    );
    return null;
  }

  Future<bool?> get showMessage => _showMessage();
}
