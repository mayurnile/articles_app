import 'dart:async';

import 'package:articles_app/di/locator.dart';
import 'package:articles_app/presentation/home/widgets/widgets.dart';
import 'package:articles_app/presentation/search/bloc/search_bloc.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(articlesRepository: locator()),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for articles...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchBloc>().add(const ClearSearchEvent());
                  },
                ),
              ),
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (query) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                if (query.length >= 3) {
                  context.read<SearchBloc>().add(
                    SearchArticlesEvent(query: query),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SearchError) {
                  return Center(child: Text(state.message));
                }

                if (state is SearchLoaded && state.articles.isEmpty) {
                  return const Center(child: Text('No articles found'));
                }

                if (state is SearchLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: state.articles.length,
                    itemBuilder:
                        (context, index) => ArticlesListItem(
                          article: state.articles[index],
                          isFavourite: false,
                        ),
                  );
                }

                // Initial state or cleared state
                return const Center(
                  child: Text('Enter a search term to find articles'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// Member Functions
  ///
  ///
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.length >= 3) {
        context.read<SearchBloc>().add(SearchArticlesEvent(query: query));
      } else if (query.isEmpty) {
        context.read<SearchBloc>().add(const ClearSearchEvent());
      }
    });
  }
}
