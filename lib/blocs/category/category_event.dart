part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class CategoryGet extends CategoryEvent {}

class CategoryGetAll extends CategoryEvent {}

class CategoryPost extends CategoryEvent {
  final CategoryFormModel category;

  const CategoryPost(this.category);

  @override
  List<Object> get props => [category];
}
