part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryFailed extends CategoryState {
  final String e;

  const CategoryFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  const CategorySuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

final class CategoryPostSuccess extends CategoryState {}
