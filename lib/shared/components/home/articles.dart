import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data_models/news_model.dart';
import '../../../modules/detailScreen.dart';
import '../texts/small.dart';

class ArticlesListView extends StatelessWidget {
  final List<Article> articles;

  const ArticlesListView({
    super.key,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(article: article),
                ),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  article.urlToImage ??
                      'https://cdn-icons-png.flaticon.com/512/3875/3875172.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SmallText(
                      article.title ?? '',
                      fontSize: 12,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    SmallText(
                      article.source ?? '',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(CupertinoIcons.clock,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        SmallText(
                          article.publishedAt
                              ?.toIso8601String()
                              .split('T')
                              .first ??
                              '',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        const Spacer(),
                        SmallText(
                          '...',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
        color: Colors.grey[200],
      ),
    );
  }
}