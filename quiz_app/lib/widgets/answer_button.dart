import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answerText;
  final VoidCallback onPressed;

  const AnswerButton({super.key, required this.answerText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.all(7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: onPressed,
      child: Text(
        answerText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }
}
