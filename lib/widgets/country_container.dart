import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_info_app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryContainer extends StatelessWidget {
  final Country country;
  final VoidCallback onPressed;

  const CountryContainer({
    super.key,
    required this.country,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: country.flagUrl,
              width: 40,
              height: 40,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.commonName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    country.capital.join(', '),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
