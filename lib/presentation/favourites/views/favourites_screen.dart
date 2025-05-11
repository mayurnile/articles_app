import 'package:articles_app/di/locator.dart';
import 'package:articles_app/network/repositories/favourites_repository.dart';
import 'package:articles_app/presentation/favourites/bloc/favourites_bloc.dart';
import 'package:articles_app/presentation/home/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => FavouritesBloc(
            favouritesRepository: locator.get<FavouritesRepository>(),
          )..add(const FetchFavouritesEvent()),
      child: const _FavouritesView(),
    );
  }
}

class _FavouritesView extends StatelessWidget {
  const _FavouritesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'First Post.',
          style: TextStyle(fontFamily: 'DMSerif Text', fontSize: 42),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<FavouritesBloc>().add(const FetchFavouritesEvent());
        },
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
            if (state is FavouritesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FavouritesError) {
              return Center(child: Text(state.message));
            }

            if (state is FavouritesLoaded) {
              final favourites = state.favourites;
              if (favourites.isEmpty) {
                return const Center(child: Text('No favourites yet'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: favourites.length,
                itemBuilder:
                    (context, index) => ArticlesListItem(
                      article: state.favourites[index],
                      isFavourite: true,
                    ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
