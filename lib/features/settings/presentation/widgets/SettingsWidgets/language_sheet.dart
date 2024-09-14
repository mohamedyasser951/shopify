import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingBloc = BlocProvider.of<SettingsBloc>(context);
    return SizedBox(
      height: 130,
      child: BottomSheet(
        onClosing: () => true,
        enableDrag: false,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Radio.adaptive(
                            value: "ar",
                            groupValue: settingBloc.appLang,
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
                            groupValue: settingBloc.appLang,
                            onChanged: (i) {
                              BlocProvider.of<SettingsBloc>(context)
                                  .add(ChangeLanguageEvent(lang: i.toString()));
                            }),
                        Text(S.of(context).english),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
