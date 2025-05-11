// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:articles_app/network/models/models.dart' as _i7;
import 'package:articles_app/presentation/favourites/views/favourites_screen.dart'
    as _i2;
import 'package:articles_app/presentation/home/views/article_detail_screen.dart'
    as _i1;
import 'package:articles_app/presentation/home/views/home_screen.dart' as _i3;
import 'package:articles_app/presentation/landing_page.dart' as _i4;
import 'package:articles_app/presentation/search/views/search_screen.dart'
    as _i5;
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

/// generated route for
/// [_i1.ArticleDetailScreen]
class ArticleDetailRoute extends _i6.PageRouteInfo<ArticleDetailRouteArgs> {
  ArticleDetailRoute({
    required _i7.ArticleModel article,
    required bool isFavourite,
    _i8.Key? key,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ArticleDetailRoute.name,
          args: ArticleDetailRouteArgs(
            article: article,
            isFavourite: isFavourite,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ArticleDetailRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleDetailRouteArgs>();
      return _i1.ArticleDetailScreen(
        article: args.article,
        isFavourite: args.isFavourite,
        key: args.key,
      );
    },
  );
}

class ArticleDetailRouteArgs {
  const ArticleDetailRouteArgs({
    required this.article,
    required this.isFavourite,
    this.key,
  });

  final _i7.ArticleModel article;

  final bool isFavourite;

  final _i8.Key? key;

  @override
  String toString() {
    return 'ArticleDetailRouteArgs{article: $article, isFavourite: $isFavourite, key: $key}';
  }
}

/// generated route for
/// [_i2.FavouritesScreen]
class FavouritesRoute extends _i6.PageRouteInfo<void> {
  const FavouritesRoute({List<_i6.PageRouteInfo>? children})
      : super(
          FavouritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavouritesRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.FavouritesScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.LandingPage]
class LandingPage extends _i6.PageRouteInfo<void> {
  const LandingPage({List<_i6.PageRouteInfo>? children})
      : super(
          LandingPage.name,
          initialChildren: children,
        );

  static const String name = 'LandingPage';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.LandingPage();
    },
  );
}

/// generated route for
/// [_i5.SearchScreen]
class SearchRoute extends _i6.PageRouteInfo<void> {
  const SearchRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.SearchScreen();
    },
  );
}
