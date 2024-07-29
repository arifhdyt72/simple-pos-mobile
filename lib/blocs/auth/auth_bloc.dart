// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simple_pos/models/login_form_model.dart';
import 'package:simple_pos/models/user_model.dart';
import 'package:simple_pos/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());

          final user = await AuthService().login(event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final LoginFormModel data =
              await AuthService().getCredentialFromLocal();
          final UserModel user = await AuthService().login(data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
      if (event is AuthLogout) {
        try {
          emit(AuthLoading());

          await AuthService().logout();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }
    });
  }
}
