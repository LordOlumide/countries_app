import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreenSearchbar extends StatelessWidget {
  const HomeScreenSearchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 17.sp,
        height: 1.3,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        prefixIcon: Icon(Icons.search, size: 22.r),
        hintText: 'Search Country',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16.sp,
          color: context.select<ThemeProvider, bool>(
                  (provider) => provider.isLightMode)
              ? const Color(0xFF667085)
              : const Color(0xFFEAECF0),
        ),
        filled: true,
        fillColor: context
                .select<ThemeProvider, bool>((provider) => provider.isLightMode)
            ? const Color(0xFFF2F4F7)
            : const Color(0xFF98A2B3).withValues(alpha: 0.2),
        isDense: true,
        isCollapsed: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15.h),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onChanged: (String? newValue) {
        if (newValue == null || newValue.isEmpty) {
          context.read<AllCountriesProvider>().resetCountries();
        } else {
          context.read<AllCountriesProvider>().searchCountries(newValue);
        }
      },
    );
  }
}
