// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_pos/models/category_form_model.dart';
import 'package:simple_pos/models/category_model.dart';
import 'package:simple_pos/services/category_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) async {
      if (event is CategoryGet) {
        try {
          emit(CategoryLoading());

          final categories = await CategoryService().getLimitCategory();

          emit(CategorySuccess(categories));
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
      if (event is CategoryGetAll) {
        try {
          emit(CategoryLoading());

          final categories = await CategoryService().getAllCategory();

          emit(CategorySuccess(categories));
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
      if (event is CategoryPost) {
        try {
          emit(CategoryLoading());

          await CategoryService().createCategory(event.category);

          emit(CategoryPostSuccess());
        } catch (e) {
          emit(CategoryFailed(e.toString()));
        }
      }
    });
  }
}
