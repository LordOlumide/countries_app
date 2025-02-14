import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_info_app/models/country.dart';
import 'package:country_info_app/widgets/country_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CountryDetailScreen extends StatefulWidget {
  static const String screenId = 'country_detail_screen';

  final Country country;
  // final List<String> countryStates;

  const CountryDetailScreen({
    super.key,
    required this.country,
    // required this.countryStates,
  });

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  List<String> imageUrls = [];
  int displayIndex = 0;

  @override
  void initState() {
    super.initState();
    imageUrls.add(widget.country.flagUrl);
    if (widget.country.coatOfArmsUrl != null) {
      imageUrls.add(widget.country.coatOfArmsUrl!);
    }
  }

  void nextImage() {
    setState(() {
      if (displayIndex == imageUrls.length - 1) {
        displayIndex = 0;
      } else {
        displayIndex++;
      }
    });
  }

  void previousImage() {
    setState(() {
      if (displayIndex == 0) {
        displayIndex = imageUrls.length - 1;
      } else {
        displayIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.country.commonName,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  displayIndex == 0
                      ? CachedNetworkImage(
                          imageUrl: imageUrls[displayIndex],
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )
                      : CachedNetworkImage(
                          imageUrl: imageUrls[displayIndex],
                          height: 250.h,
                          fit: BoxFit.contain,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  imageUrls.length > 1
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.white.withAlpha(80)),
                                ),
                                // padding: EdgeInsets.all(10.r),
                                onPressed: previousImage,
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                              IconButton(
                                style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.white.withAlpha(80)),
                                ),
                                // padding: EdgeInsets.all(10.r),
                                onPressed: nextImage,
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white.withAlpha(220),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: [
                SizedBox(height: 10.h),
                CountryField(
                    fieldName: 'Name', fieldValue: widget.country.commonName),
                SizedBox(height: 4.h),
                CountryField(
                    fieldName: 'Official Name',
                    fieldValue: widget.country.officialName),
                SizedBox(height: 24.h),
                //
                CountryField(
                  fieldName: 'Population',
                  fieldValue: commaSeparate(widget.country.population),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Region',
                  fieldValue: widget.country.region.toString(),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Capital City',
                  fieldValue: widget.country.capital.join(', '),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Country Code',
                  fieldValue: widget.country.cca3,
                ),
                SizedBox(height: 24.h),
                //
                CountryField(
                  fieldName: 'Continents',
                  fieldValue: widget.country.continents.join(', '),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Independent',
                  fieldValue: widget.country.independent != null
                      ? widget.country.independent!
                          ? 'Yes'
                          : 'No'
                      : 'Unknown',
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Status',
                  fieldValue: widget.country.status,
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'UN Member',
                  fieldValue: widget.country.unMember ? 'Yes' : 'No',
                ),
                SizedBox(height: 24.h),
                //
                CountryField(
                  fieldName: 'Currencies',
                  fieldValue: widget.country.currencies.values
                      .map((value) => '${value['name']} (${value['symbol']})')
                      .toList()
                      .join(', '),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Languages',
                  fieldValue:
                      widget.country.languages.values.toList().join(', '),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Lat-Long',
                  fieldValue:
                      '[${widget.country.latlng[0]} ${widget.country.latlng[0]}]',
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Timezones',
                  fieldValue: widget.country.timezones.join(', '),
                ),
                SizedBox(height: 4.h),
                CountryField(
                  fieldName: 'Start of Week',
                  fieldValue: widget.country.startOfWeek,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String commaSeparate(int num) => NumberFormat("###,###", "en_US").format(num);
}
