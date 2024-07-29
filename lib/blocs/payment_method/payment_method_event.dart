part of 'payment_method_bloc.dart';

sealed class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();

  @override
  List<Object> get props => [];
}

class PaymentMethodGet extends PaymentMethodEvent {}

class PaymentMethodPost extends PaymentMethodEvent {
  final PaymentMethodFormModel paymentMethod;

  const PaymentMethodPost(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];
}
