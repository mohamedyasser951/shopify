import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:equatable/equatable.dart';

import 'package:commerceapp/features/Auth/data/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepo authRepo;

  AuthBloc(
    this.authRepo,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLoadingState());
        var failureOrSuccess = await authRepo.userLogin(
            email: event.email, password: event.password);

        failureOrSuccess.fold((failure) {
          emit(const AuthErrorState(error: "SomeThing went wrong"));
        }, (user) {
          emit(AuthSuccessState(userModel: user));
        });
      }

      if (event is RegisterEvent) {
        emit(AuthLoadingState());
        var failureOrSuccess = await authRepo.userRegister(
            name: event.name,
            email: event.email,
            phone: event.phone,
            password: event.password);
        failureOrSuccess.fold((failure) {
          emit(const AuthErrorState(error: "SomeThing went wrong"));
        }, (user) {
          emit(AuthSuccessState(userModel: user));
        });
      }
    });
  }
}
