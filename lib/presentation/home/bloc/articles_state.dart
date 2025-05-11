part of 'articles_bloc.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();
}

final class ArticlesInitial extends ArticlesState {
  @override
  List<Object> get props => [];
}

final class ArticlesLoading extends ArticlesState {
  @override
  List<Object> get props => [];
}

final class ArticlesLoaded extends ArticlesState {
  const ArticlesLoaded(this.articles);

  final List<ArticleModel> articles;

  @override
  List<Object> get props => [articles];
}

final class ArticlesError extends ArticlesState {
  const ArticlesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
