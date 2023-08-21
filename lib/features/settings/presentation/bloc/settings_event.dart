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