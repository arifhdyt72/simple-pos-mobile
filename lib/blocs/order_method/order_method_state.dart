part of 'order_method_bloc.dart';

sealed class OrderMethodState extends Equatable {
  const OrderMethodState();

  @override
  List<Object> get props => [];
}

final class OrderMethodInitial extends OrderMethodState {}

final class OrderMethodLoading extends OrderMethodState {}

final class OrderMethodFailed extends OrderMethodState {
  final String e;

  const OrderMethodFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class OrderMethodSuccess extends OrderMethodState {
  final List<OrderMethodModel> orderMethods;

  const OrderMethodSuccess(this.orderMethods);

  @override
  List<Object> get props => [orderMethods];
}

final class OrderMethodPostSuccess extends OrderMethodState {}
