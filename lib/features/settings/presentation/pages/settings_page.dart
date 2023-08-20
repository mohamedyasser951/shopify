import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Settings",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          ListTile(
            title: const Text("Personal information"),
            subtitle: Text(
              "Name,phone,Email",
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
            title: const Text("Password"),
            subtitle: Text(
              "Password Settings",
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
                  child: LanguageSheet(),
                ),
              );
            },
            title: const Text("Language"),
            subtitle: Text(
              "Arabic, English",
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
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text("Password Change"),
                ),
                CustomeTextField(
                    textEditingController: oldPasswordController,
                    hintText: "Old Password"),
                const SizedBox(
                  height: 6.0,
                ),
                CustomeTextField(
                    textEditingController: newPasswordController,
                    hintText: "New Password"),
                CustomeTextField(
                    textEditingController: repeatpasswordController,
                    hintText: "Repeat New Password"),
                const SizedBox(
                  height: 30.0,
                ),
                CustomButton(
                    widget: const Text(
                      "Save Password",
                      style: TextStyle(color: Colors.white),
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
    return Container(
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
                        value: true,
                        groupValue: [true, false],
                        onChanged: (i) {}),
                    const Text("Arabic"),
                  ],
                ),
                const Divider(
                  thickness: 0.1,
                ),
                Row(
                  children: [
                    Radio.adaptive(
                        value: false,
                        groupValue: [true, false],
                        onChanged: (i) {}),
                    const Text("English"),
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
