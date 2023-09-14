import 'package:commerceapp/features/settings/data/models/addresses_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:commerceapp/Config/Network/error_strings.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/user_model.dart';
import 'package:commerceapp/features/settings/data/repositories/settings_repo.dart';
import 'package:image_picker/image_picker.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  // HomeRepo homeRepo;
  SettingsRepo settingsRepo;
  String appLang = "en";
  bool isDarkMode = false;
  List langages = ["ar", "en"];
  UserData? userProfileData;
  AddressesModel? userAddresess;
  var box = Hive.box(AppStrings.settingsBox);
  XFile? profileImage;
  SettingsBloc({
    required this.settingsRepo,
  }) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is ChangeLanguageEvent) {
        await box.put("lang", event.lang).then((value) {
          appLang = event.lang;
          emit(ChangeAppLangState());
        });
      }

      if (event is ChangeAppModeEvent) {
        if (event.modeFromCashe != null) {
          isDarkMode = event.modeFromCashe!;
          emit(ChangeAppModeState());
        } else {
          isDarkMode = !isDarkMode;
          box.put("darkMode", isDarkMode);
          emit(ChangeAppModeState());
        }
      }

      if (event is GetProfileEvent) {
        emit(GetProfileLoadingState());
        var data = await settingsRepo.getUserProfile();
        data.fold((failure) {
          emit(GetProfileErrorState(error: mapFailureToMessage(failure)));
        }, (model) {
          userProfileData = model;
          emit(GetProfileSucessState());
        });
      }
      if (event is ChangePasswordEvent) {
        emit(ChangePasswordLoadingState());
        var data = await settingsRepo.changePassword(
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
        var data = await settingsRepo.updateProfile(
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
      if (event is AddAddresessEvent) {
        emit(AddAdresessLoadingState());
        var failureOrAddresses =
            await settingsRepo.addAdresses(addressData: event.addressData);
        failureOrAddresses.fold(
            (failure) => emit(
                AddAdresessErrorState(error: mapFailureToMessage(failure))),
            (addresses) {
          if (addresses.status == true) {
            add(GetAddresessEvent());
          }
          emit(AddAdresessSucessState(addressesModel: addresses));
        });
      }
    });
  }
  void pickProfileImage() async {
    var picker = ImagePicker();
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = XFile(pickedImage.path);
    } else {
      print("ERROR When Picked Image");
    }
  }
}
