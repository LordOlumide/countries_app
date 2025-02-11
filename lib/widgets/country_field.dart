import 'package:flutter/material.dart';

class CountryField extends StatelessWidget {
  final String fieldName;
  final String fieldValue;

  const CountryField({
    super.key,
    required this.fieldName,
    required this.fieldValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          fieldName,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 12),
        Text(
          fieldValue,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
