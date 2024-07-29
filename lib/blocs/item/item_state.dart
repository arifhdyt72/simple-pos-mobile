part of 'item_bloc.dart';

sealed class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemFailed extends ItemState {
  final String e;

  const ItemFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class ItemSuccess extends ItemState {
  final List<ItemModel> items;

  const ItemSuccess(this.items);

  @override
  List<Object> get props => [items];
}

final class ItemPostSuccess extends ItemState {}
