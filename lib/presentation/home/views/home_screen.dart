import 'package:articles_app/di/locator.dart';
import 'package:articles_app/presentation/home/bloc/articles_bloc.dart';
import 'package:articles_app/presentation/home/widgets/widgets.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ArticlesBloc(articlesRepository: locator())
                ..add(const FetchArticlesEvent()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

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
          context.read<ArticlesBloc>().add(const FetchArticlesEvent());
        },
        child: BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (context, state) {
            if (state is ArticlesError) {
              return Center(child: Text(state.message));
            }

            if (state is ArticlesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ArticlesLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: state.articles.length,
                itemBuilder:
                    (context, index) => ArticlesListItem(
                      article: state.articles[index],
                      isFavourite: false,
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
