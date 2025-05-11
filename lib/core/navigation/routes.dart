import 'package:articles_app/core/navigation/route_animations.dart';
import 'package:articles_app/core/navigation/routes.gr.dart';
import 'package:auto_route/auto_route.dart';

export 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    getAnimatedRoute(
      page: LandingPage.page,
      initial: true,
      children: [
        getAnimatedRoute(page: HomeRoute.page),
        getAnimatedRoute(page: SearchRoute.page),
        getAnimatedRoute(page: FavouritesRoute.page),
      ],
    ),
    getAnimatedRoute(page: ArticleDetailRoute.page),
  ];
}
