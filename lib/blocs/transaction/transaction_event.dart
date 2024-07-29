part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionPost extends TransactionEvent {
  final TransactionFormModel transaction;

  const TransactionPost(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class TransactionGet extends TransactionEvent {}
