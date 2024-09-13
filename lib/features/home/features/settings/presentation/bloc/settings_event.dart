part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends SettingsEvent {
  final String lang;
  const ChangeLanguageEvent({
    required this.lang,
  });
}

class ChangeAppModeEvent extends SettingsEvent {
  final bool? modeFromCashe;
  const ChangeAppModeEvent({
    this.modeFromCashe,
  });
}

class GetProfileEvent extends SettingsEvent {}

class UpdateProfileEvent extends SettingsEvent {
  final String name;
  final String email;
  final String phone;
  final String image;
  const UpdateProfileEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });
}

class ChangePasswordEvent extends SettingsEvent {
  final String currentPassword;
  final String newPassword;
  const ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}

class GetAddresessEvent extends SettingsEvent {}

class AddAddresessEvent extends SettingsEvent {
  final AddressData addressData;
  const AddAddresessEvent({
    required this.addressData,
  });
}
