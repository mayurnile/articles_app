import 'dart:math';

import 'package:articles_app/core/core.dart';
import 'package:articles_app/di/locator.dart';
import 'package:articles_app/network/models/models.dart';
import 'package:articles_app/network/repositories/favourites_repository.dart';
import 'package:articles_app/presentation/favourites/bloc/favourites_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({
    required this.article,
    required this.isFavourite,
    super.key,
  });

  final ArticleModel article;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => FavouritesBloc(
            favouritesRepository: locator.get<FavouritesRepository>(),
          ),
      child: _ArticleDetailView(article: article, isFavourite: isFavourite),
    );
  }
}

class _ArticleDetailView extends StatelessWidget {
  const _ArticleDetailView({required this.article, required this.isFavourite});

  final ArticleModel article;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isFavourite) {
            context.read<FavouritesBloc>().add(
              RemoveFromFavouritesEvent(article),
            );
          } else {
            context.read<FavouritesBloc>().add(AddToFavouritesEvent(article));
          }
          context.router.maybePop();
        },
        child:
            isFavourite ? const Icon(Icons.remove) : const Icon(Icons.favorite),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Background Image with Perspective View
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.black),
              child: Image.network(
                'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
                fit: BoxFit.cover,
                color: Colors.black.opacityValue(0.6),
                colorBlendMode: BlendMode.darken,
              ),
            ),

            // back button
            Positioned(
              top: 48,
              left: 32,
              child: GestureDetector(
                onTap: () => context.router.maybePop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),

            // Article Body
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 22,
              right: 22,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.opacityValue(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
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

                      // Article Title
                      Text(
                        article.title.capitalizeFirst(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Article Published Date
                      Row(
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Published ${article.publishedAt}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // Article Content
                      Text(
                        article.content,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
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
