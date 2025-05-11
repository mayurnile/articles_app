import 'package:articles_app/core/navigation/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), SearchRoute(), FavouritesRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(54),
              child: NavigationBar(
                selectedIndex: tabsRouter.activeIndex,
                onDestinationSelected: tabsRouter.setActiveIndex,
                destinations: const[
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    selectedIcon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_border_outlined),
                    selectedIcon: Icon(Icons.favorite),
                    label: 'Favourites',
                  ),
                ],
              ),
            ),
          ),
          // BottomNavigationBar(
          //   currentIndex: tabsRouter.activeIndex,
          //   onTap: tabsRouter.setActiveIndex,
          //   items: const [
          //     BottomNavigationBarItem(
          //       activeIcon: Icon(Icons.home),
          //       icon: Icon(Icons.home_outlined),
          //       label: 'Home',
          //     ),
          //     BottomNavigationBarItem(
          //       activeIcon: Icon(Icons.search),
          //       icon: Icon(Icons.search),
          //       label: 'Search',
          //     ),
          //     BottomNavigationBarItem(
          //       activeIcon: Icon(Icons.favorite),
          //       icon: Icon(Icons.favorite_border_outlined),
          //       label: 'Favourites',
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
