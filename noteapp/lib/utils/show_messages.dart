import 'package:flutter/material.dart';
import 'package:noteapp/main.dart';

void showMeg(String? msg, [bool isError = true]) {
  //optional parameter
  final snackBar = SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: Duration(seconds: 2),
    content: Text(
      msg ?? "",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
    ),
  );
  scaffoldMessagerKey.currentState?.showSnackBar(snackBar);
}
