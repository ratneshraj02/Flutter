import 'dart:math';

import 'package:basic_app/dice_container.dart';
import 'package:basic_app/style_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int randomInt(){
    final random = Random();
    int randomInt = random.nextInt(6) + 1;
    return randomInt;
  }

  @override
  Widget build(BuildContext context) {
    int number = randomInt();
    return
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Roll Dice"),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.yellow,
                ],),
            ),
            child: Center(child: DiceContainer(number: number))),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              randomInt();
            });
          },
          tooltip: 'Roll Dice',
          child: const Icon(Icons.arrow_downward_outlined),
        ),
    );
  }
}
