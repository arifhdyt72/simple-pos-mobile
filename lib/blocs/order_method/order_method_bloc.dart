// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_pos/models/order_method_form_model.dart';
import 'package:simple_pos/models/order_method_model.dart';
import 'package:simple_pos/services/order_method_service.dart';

part 'order_method_event.dart';
part 'order_method_state.dart';

class OrderMethodBloc extends Bloc<OrderMethodEvent, OrderMethodState> {
  OrderMethodBloc() : super(OrderMethodInitial()) {
    on<OrderMethodEvent>((event, emit) async {
      if (event is OrderMethodGet) {
        try {
          emit(OrderMethodLoading());

          final orderMethods = await OrderMethodService().getOrderMethod();

          emit(OrderMethodSuccess(orderMethods));
        } catch (e) {
          emit(OrderMethodFailed(e.toString()));
        }
      }
      if (event is OrderMethodPost) {
        try {
          emit(OrderMethodLoading());

          await OrderMethodService().createOrderMethod(event.orderMethod);

          emit(OrderMethodPostSuccess());
        } catch (e) {
          emit(OrderMethodFailed(e.toString()));
        }
      }
    });
  }
}
