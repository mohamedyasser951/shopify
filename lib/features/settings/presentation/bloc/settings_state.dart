part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class ChangeAppLangState extends SettingsState {}

class ChangeAppModeState extends SettingsState {}


class GetProfileLoadingState extends SettingsState {}

class GetProfileSucessState extends SettingsState {
}


class GetProfileErrorState extends SettingsState {
  final String error;

  const GetProfileErrorState({required this.error});
}

class ChangePasswordLoadingState extends SettingsState {}

class ChangePasswordSucessState extends SettingsState {
  final UserModel model;
  const ChangePasswordSucessState({
    required this.model,
  });
}

class ChangePasswordErrorState extends SettingsState {
  final String error;
  const ChangePasswordErrorState({
    required this.error,
  });
}

class UpdatePasswordLoadingState extends SettingsState {}

class UpdatePasswordSucessState extends SettingsState {
  final UserModel model;
  const UpdatePasswordSucessState({
    required this.model,
  });
}

class UpdatePasswordErrorState extends SettingsState {
  final String error;
  const UpdatePasswordErrorState({
    required this.error,
  });
}
