import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String label;
  const StyledText({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
