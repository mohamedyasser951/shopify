import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<SettingsBloc>(context)
                    .add(const ChangeAppModeEvent());
              },
              icon: const Icon(Icons.dark_mode))
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
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                enableDrag: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: PasswordChangeSheet(),
                ),
              );
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
  }
}

class PasswordChangeSheet extends StatelessWidget {
  PasswordChangeSheet({super.key});
  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController repeatpasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      enableDrag: false,
      builder: (context) {
        return Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(S.of(context).password_change),
                ),
                CustomeTextField(
                    textEditingController: oldPasswordController,
                    hintText: S.of(context).old_password),
                const SizedBox(
                  height: 6.0,
                ),
                CustomeTextField(
                    textEditingController: newPasswordController,
                    hintText: S.of(context).new_password),
                CustomeTextField(
                    textEditingController: repeatpasswordController,
                    hintText: S.of(context).repeat_new_password),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                    widget: Text(
                      S.of(context).save_password,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        );
      },
      onClosing: () => true,
    );
  }
}

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var settingBloc = BlocProvider.of<SettingsBloc>(context);
    return SizedBox(
      height: 130,
      child: BottomSheet(
        onClosing: () => true,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio.adaptive(
                        value: "ar",
                        groupValue: settingBloc.langages,
                        onChanged: (i) {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(ChangeLanguageEvent(lang: i.toString()));
                        }),
                    Text(S.of(context).arabic),
                  ],
                ),
                const Divider(
                  thickness: 0.1,
                ),
                Row(
                  children: [
                    Radio.adaptive(
                        value: "en",
                        groupValue: settingBloc.langages,
                        onChanged: (i) {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(ChangeLanguageEvent(lang: i.toString()));
                        }),
                    Text(S.of(context).english),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
