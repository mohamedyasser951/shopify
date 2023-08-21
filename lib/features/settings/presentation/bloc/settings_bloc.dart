import 'package:bloc/bloc.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  String appLang = "en";
  bool isDarkMode = false;
  List langages = ["ar","en"];

  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {
      if (event is ChangeLanguageEvent) {
        appLang = event.lang;
        emit(ChangeAppLangState());
      }

      if (event is ChangeAppModeEvent) {
        if (event.modeFromCashe != null) {
          isDarkMode = event.modeFromCashe!;
          emit(ChangeAppModeState());
        } else {
          isDarkMode = !isDarkMode;
          var box = Hive.box(AppStrings.settingsBox);
          box.put("darkMode", isDarkMode);
          emit(ChangeAppModeState());
        }
      }
    });
  
  }
}
