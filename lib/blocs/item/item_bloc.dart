// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_pos/models/item_form_model.dart';
import 'package:simple_pos/models/item_model.dart';
import 'package:simple_pos/models/item_search_model.dart';
import 'package:simple_pos/services/item_service.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<ItemEvent>((event, emit) async {
      if (event is ItemGet) {
        try {
          emit(ItemLoading());

          final items = await ItemService().getAllItem(event.data);

          emit(ItemSuccess(items));
        } catch (e) {
          emit(ItemFailed(e.toString()));
        }
      }
      if (event is ItemPost) {
        try {
          emit(ItemLoading());

          await ItemService().createItem(event.item);

          emit(ItemPostSuccess());
        } catch (e) {
          emit(ItemFailed(e.toString()));
        }
      }
    });
  }
}
