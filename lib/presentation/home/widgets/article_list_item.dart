import 'dart:math';

import 'package:articles_app/core/core.dart';
import 'package:articles_app/core/navigation/routes.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ArticlesListItem extends StatelessWidget {
  const ArticlesListItem({
    required this.article,
    required this.isFavourite,
    super.key,
  });

  final ArticleModel article;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => context.router.push(
            ArticleDetailRoute(article: article, isFavourite: isFavourite),
          ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // category
            Text(
              article.category.toUpperCase(),
              style: TextStyle(
                color: getRandomColor(),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title.capitalizeFirst(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.play_arrow, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Published ${article.publishedAt}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getRandomColor() {
    final colors = <Color>[
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
    ];

    return colors[Random().nextInt(colors.length)];
  }
}
