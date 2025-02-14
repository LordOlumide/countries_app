import 'package:country_info_app/providers/all_countries_provider.dart';
import 'package:country_info_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  final Map<String, bool> _continentsAndStates = {};
  final Map<String, bool> _timeZonesAndStates = {};

  @override
  void initState() {
    super.initState();
    final List<String> allContinents =
        context.read<AllCountriesProvider>().allContinents.toList();
    allContinents.sort();
    final List<String> allTimeZones =
        context.read<AllCountriesProvider>().allTimeZones.toList();
    allTimeZones.sort();

    for (String continent in allContinents) {
      _continentsAndStates[continent] = false;
    }
    for (String timeZone in allTimeZones) {
      _timeZonesAndStates[timeZone] = false;
    }
  }

  bool isContinentsOpen = false;
  bool isTimeZonesOpen = false;

  void _openCloseContinents() {
    setState(() {
      isContinentsOpen = !isContinentsOpen;
    });
  }

  void _openCloseTimeZones() {
    setState(() {
      isTimeZonesOpen = !isTimeZonesOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _FieldHeader(
                    name: 'Continent',
                    openClose: _openCloseContinents,
                    isOpen: isContinentsOpen,
                  ),
                  // SizedBox(height: 16.h),
                  for (final continentAndState in _continentsAndStates.entries)
                    isContinentsOpen
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: _FieldBody(
                              name: continentAndState.key,
                              state: continentAndState.value,
                              onChanged: (newValue) {
                                setState(() {
                                  _continentsAndStates[continentAndState.key] =
                                      newValue ?? false;
                                });
                              },
                            ),
                          )
                        : const SizedBox(),
                  // SizedBox(height: 24.h),
                  _FieldHeader(
                    name: 'Time Zones',
                    openClose: _openCloseTimeZones,
                    isOpen: isTimeZonesOpen,
                  ),
                  // SizedBox(height: 16.h),
                  for (final timeZoneAndState in _timeZonesAndStates.entries)
                    isTimeZonesOpen
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: _FieldBody(
                              name: timeZoneAndState.key,
                              state: timeZoneAndState.value,
                              onChanged: (newValue) {
                                setState(() {
                                  _timeZonesAndStates[timeZoneAndState.key] =
                                      newValue ?? false;
                                });
                              },
                            ),
                          )
                        : const SizedBox(),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: _onResetPressed,
                child: Container(
                  width: 104.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(
                      'Reset',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: _onShowResultsPressed,
                child: Container(
                  width: 236.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: const Color(0xFFFF6C00),
                  ),
                  child: Center(
                    child: Text(
                      'Show results',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Color(0xFFFDFDFC),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  void _onResetPressed() {
    Navigator.pop(
      context,
      {
        'selectedContinents': null,
        'selectedTimeZones': null,
      },
    );
  }

  void _onShowResultsPressed() {
    final List<String> selectedContinents = _continentsAndStates.keys
        .where((continent) => _continentsAndStates[continent] == true)
        .toList();
    final List<String> selectedTimeZones = _timeZonesAndStates.keys
        .where((timeZone) => _timeZonesAndStates[timeZone] == true)
        .toList();
    Navigator.pop(
      context,
      {
        'selectedContinents': selectedContinents,
        'selectedTimeZones': selectedTimeZones,
      },
    );
  }
}

class _FieldHeader extends StatelessWidget {
  final String name;
  final VoidCallback openClose;
  final bool isOpen;

  const _FieldHeader(
      {required this.name, required this.openClose, required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openClose,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          IconButton(
            onPressed: openClose,
            icon: Icon(
              isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldBody extends StatelessWidget {
  final String name;
  final bool state;
  final Function(bool?) onChanged;

  const _FieldBody({
    required this.name,
    required this.state,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15.w),
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: Checkbox(
              value: state,
              onChanged: onChanged,
              activeColor: context.select<ThemeProvider, bool>(
                      (themeProvider) => themeProvider.isLightMode)
                  ? const Color(0xFF1C1917)
                  : const Color(0xFFF2F4F7),
            ),
          ),
        ),
      ],
    );
  }
}
