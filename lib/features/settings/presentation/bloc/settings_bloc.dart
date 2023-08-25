import 'package:bloc/bloc.dart';
import 'package:commerceapp/features/settings/data/models/addresses_data.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:commerceapp/features/home/data/repositories/home_repo.dart';
import 'package:commerceapp/features/settings/data/repositories/settings_repo.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  HomeRepo homeRepo;
  SettingsRepo settingsRepo;
  String appLang = "en";
  bool isDarkMode = false;
  List langages = ["ar", "en"];
  UserData? userProfileData;
  AddressesModel? userAddresess;
  SettingsBloc({
    required this.homeRepo,
    required this.settingsRepo,
  }) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
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

      if (event is GetProfileEvent) {
        emit(GetProfileLoadingState());
        var data = await homeRepo.getUserProfile();
        data.fold((failure) {
          emit(GetProfileErrorState(error: mapFailureToMessage(failure)));
        }, (model) {
          userProfileData = model;
          emit(GetProfileSucessState());
        });
      }
      if (event is ChangePasswordEvent) {
        emit(ChangePasswordLoadingState());
        var data = await homeRepo.changePassword(
            currentPassword: event.currentPassword,
            newPassword: event.newPassword);
        data.fold((failure) {
          emit(ChangePasswordErrorState(error: mapFailureToMessage(failure)));
        }, (model) {
          emit(ChangePasswordSucessState(model: model));
        });
      }
      if (event is UpdateProfileEvent) {
        emit(UpdatePasswordLoadingState());
        var data = await homeRepo.updateProfile(
            name: event.name,
            email: event.email,
            phone: event.phone,
            image: event.image);
        data.fold((failure) {
          emit(UpdatePasswordErrorState(error: mapFailureToMessage(failure)));
        }, (model) {
          print(model);
          emit(UpdatePasswordSucessState(model: model));
        });
      }
      if (event is GetAddresessEvent) {
        emit(GetAdresessLoadingState());
        var failureOrAddresses = await settingsRepo.getAdresses();
        failureOrAddresses.fold(
            (failure) => emit(
                GetAdresessErrorState(error: mapFailureToMessage(failure))),
            (addresses) {
          userAddresess = addresses;
          emit(GetAdresessSucessState());
        });
      }
    });
  }
}
