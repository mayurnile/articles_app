part of 'articles_bloc.dart';

sealed class ArticlesEvent extends Equatable {
  const ArticlesEvent();
}

class FetchArticlesEvent extends ArticlesEvent {
  const FetchArticlesEvent();

  @override
  List<Object?> get props => [];
}
