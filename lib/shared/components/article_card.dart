import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_pp/shared/components/texts/medium.dart';
import 'package:news_pp/shared/components/texts/small.dart';


class ArticleCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;
  final String publishedAt;

  const ArticleCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.publishedAt,
  });

  @override
  Widget build(BuildContext context) {
    const bodyTextColor = Colors.grey; // you can replace with your theme color

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            imageUrl ,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 32),
        MediumText(title ),
        const SizedBox(height: 4),
        Row(
          children: [
            SmallText(source ),
            const SizedBox(width: 12),
            Icon(CupertinoIcons.clock, size: 18, color: bodyTextColor),
            const SizedBox(width: 4),
            SmallText(publishedAt ),
            const Spacer(),
            SmallText('...')
          ],
        ),
      ],
    );
  }
}
