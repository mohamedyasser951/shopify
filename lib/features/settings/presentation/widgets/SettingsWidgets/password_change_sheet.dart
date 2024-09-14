import 'package:commerceapp/Config/Extensions/validator_extenstion.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/Config/widgets/loading_widget.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:commerceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordChangeSheet extends StatefulWidget {
  const PasswordChangeSheet({super.key});
  @override
  State<PasswordChangeSheet> createState() => _PasswordChangeSheetState();
}

class _PasswordChangeSheetState extends State<PasswordChangeSheet> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatpasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingBloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, sate) {
        return Scaffold(
          appBar: AppBar(
            title: Text(S.of(context).password_change),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      CustomeTextField(
                          textEditingController: oldPasswordController,
                          validator: (val) {
                            if (val!.isValidPassword) {
                              return "please enter Valid Password";
                            }
                            return null;
                          },
                          hintText: S.of(context).old_password),
                      const SizedBox(
                        height: 6.0,
                      ),
                      CustomeTextField(
                          textEditingController: newPasswordController,
                          validator: (val) {
                            if (val!.isValidPassword) {
                              return "please enter Valid Password";
                            }
                            return null;
                          },
                          hintText: S.of(context).new_password),
                      CustomeTextField(
                          textEditingController: repeatpasswordController,
                          validator: (val) {
                            if (val!.isValidPassword) {
                              return "please enter Valid Password";
                            } else if (repeatpasswordController.text !=
                                newPasswordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          hintText: S.of(context).repeat_new_password),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CustomButton(
                          widget: sate is ChangePasswordLoadingState
                              ? const LoadingWidget()
                              : Text(
                                  S.of(context).save_password,
                                  style: const TextStyle(color: Colors.white),
                                ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              settingBloc.add(ChangePasswordEvent(
                                  currentPassword:
                                      oldPasswordController.text.trim(),
                                  newPassword:
                                      newPasswordController.text.trim()));
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
