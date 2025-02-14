import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          fieldName,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            fieldValue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}
