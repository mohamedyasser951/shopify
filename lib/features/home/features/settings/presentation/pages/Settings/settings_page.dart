import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/features/home/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/features/home/features/settings/presentation/widgets/SettingsWidgets/language_sheet.dart';
import 'package:commerceapp/features/home/features/settings/presentation/widgets/SettingsWidgets/password_change_sheet.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldkey,
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    settingsBloc.add(const ChangeAppModeEvent());
                  },
                  icon: settingsBloc.isDarkMode
                      ? const Icon(Icons.wb_sunny_outlined)
                      : const Icon(Icons.dark_mode_outlined))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  S.of(context).settings,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/updateProfile");
                },
                title: Text(S.of(context).personal_information),
                subtitle: Text(
                  S.of(context).Name_phone_Email,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordChangeSheet(),
                      ));
                },
                title: Text(S.of(context).password),
                subtitle: Text(
                  S.of(context).password_settings,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
              ),
              const Divider(
                thickness: 0.1,
              ),
              ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const LanguageSheet(),
                    ),
                  );
                },
                title: Text(S.of(context).language),
                subtitle: Text(
                  S.of(context).arabic_english,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.grayColor),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
