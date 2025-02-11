import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_info_app/models/country.dart';
import 'package:flutter/material.dart';

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
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  country.capital,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
