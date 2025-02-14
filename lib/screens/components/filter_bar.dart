import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBar extends StatelessWidget {
  final Function(BuildContext) onFilterPressed;

  const FilterBar({super.key, required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => onFilterPressed(context),
            child: Container(
              width: 86.w,
              height: 40.h,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 0.2.w, color: const Color(0xFFA9B8D4)),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      size: 20.r,
                    ),
                    SizedBox(width: 11.w),
                    Text(
                      'Filter',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
