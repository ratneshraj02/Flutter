import 'package:flutter/material.dart';

class DiceContainer extends StatelessWidget {
  final int number;
  const DiceContainer({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage('assets/image/dice-six-faces-$number.png'))
      ),
    );
  }
}
