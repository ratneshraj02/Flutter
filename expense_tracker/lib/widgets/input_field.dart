import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextInputType? textInputType;
  final String title;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? isValidate;
  final TextEditingController controller;
  final VoidCallback? onTap;

  const InputField({
    super.key,
    this.textInputType,
    this.prefixIcon,
    this.isValidate,
    this.onChanged,
    required this.title,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: isValidate,
      onTap: onTap,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: title,
        hintStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}
