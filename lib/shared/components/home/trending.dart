import 'package:flutter/material.dart';
import '../../../data_models/news_model.dart';
import '../../../modules/trending.dart';
import '../article_card.dart';
import 'heading_row.dart';

class TrendingSection extends StatelessWidget {
  final Article? article;

  const TrendingSection({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingRow(
          onSeeAllPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Trending()));
          },
          title: 'Trending',
        ),
        const SizedBox(height: 16),
        if(article == null)
        SizedBox(
            height: 290,
            width: double.infinity,
            child: const Center(
                child: CircularProgressIndicator()))
        else
          ArticleCard(
          imageUrl: article!.urlToImage ??
              'https://cdn-icons-png.flaticon.com/512/3875/3875172.png',
          title: article!.title ?? '',
          source: article!.source ?? '',
          publishedAt: article!.publishedAt
              ?.toIso8601String()
              .split('T')
              .first ??
              '',
          article: article,
        ),
      ],
    );
  }
}