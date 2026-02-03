import 'package:flutter/material.dart';
import 'package:news_pp/shared/components/texts/small.dart';
import '../texts/medium.dart';

class HeadingRow extends StatelessWidget {
  final VoidCallback onSeeAllPressed;
  final String title;


  const HeadingRow({
    super.key,
    required this.onSeeAllPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         MediumText(title),

        TextButton(
          onPressed: onSeeAllPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child:  SmallText(
            'See all',
          ),
        ),
      ],
    );
  }
}
