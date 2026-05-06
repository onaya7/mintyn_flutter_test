import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mintyn/core/constants/app_size.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({required this.imgPath, required this.title, required this.subtitle, required this.date, super.key});
  final String imgPath;
  final String title;
  final String subtitle;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 20, right: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(imageUrl: imgPath),
          AppSizes.w(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      date,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(fontFamily: 'Rubik', fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
