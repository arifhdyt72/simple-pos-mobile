// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_pos/models/transaction_form_model.dart';
import 'package:simple_pos/models/transaction_model.dart';
import 'package:simple_pos/services/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<TransactionEvent>((event, emit) async {
      if (event is TransactionGet) {
        try {
          emit(TransactionLoading());

          final transactions = await TransactionService().getTransactions();

          emit(TransactionSuccess(transactions));
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
      if (event is TransactionPost) {
        try {
          emit(TransactionLoading());

          await TransactionService().createTransaction(event.transaction);

          emit(TransactionPostSuccess());
        } catch (e) {
          emit(TransactionFailed(e.toString()));
        }
      }
    });
  }
}
