part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemPost extends ItemEvent {
  final ItemFormModel item;

  const ItemPost(this.item);

  @override
  List<Object> get props => [item];
}

class ItemGet extends ItemEvent {
  final ItemSearchModel data;

  const ItemGet(this.data);

  @override
  List<Object> get props => [data];
}
