part of 'order_method_bloc.dart';

sealed class OrderMethodEvent extends Equatable {
  const OrderMethodEvent();

  @override
  List<Object> get props => [];
}

class OrderMethodGet extends OrderMethodEvent {}

class OrderMethodPost extends OrderMethodEvent {
  final OrderMethodFormModel orderMethod;

  const OrderMethodPost(this.orderMethod);

  @override
  List<Object> get props => [orderMethod];
}
