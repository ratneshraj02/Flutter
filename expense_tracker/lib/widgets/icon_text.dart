import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData iconData;
  final String text;
  const IconText({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData, size: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class IconText2 extends StatelessWidget {
  final IconData iconData;
  final String text;
  const IconText2({super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Icon(iconData, size: 20),
      ],
    );
  }
}
