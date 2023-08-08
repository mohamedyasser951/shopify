part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {
  final UserModel userModel;

  const AuthSuccessState({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
