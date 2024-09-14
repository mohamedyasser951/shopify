import 'package:commerceapp/Config/Extensions/validator_extenstion.dart';
import 'package:commerceapp/Config/components/cachedNetworkImage.dart';
import 'package:commerceapp/Config/components/custom_toast.dart';
import 'package:commerceapp/Config/constants/colors.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/features/Auth/data/models/user_model/data.dart';
import 'package:commerceapp/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    UserData userData = BlocProvider.of<SettingsBloc>(context).userProfileData!;
    emailController.text = userData.email!;
    nameController.text = userData.name!;
    phoneController.text = userData.phone!;

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsBloc blocSettings = BlocProvider.of<SettingsBloc>(context);
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is UpdatePasswordSucessState) {
          if (state.model.status!) {
            customToast(mesg: state.model.message!);
            BlocProvider.of<SettingsBloc>(context).add(GetProfileEvent());
            Navigator.pop(context);
          } else {
            customToast(mesg: state.model.message!, color: Colors.red);
          }
        } else if (state is UpdatePasswordErrorState) {
          customToast(mesg: state.error, color: Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        blocSettings.pickProfileImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: CashedNetworkImage(
                                width: 50,
                                height: 50,
                                imgUrl: blocSettings.userProfileData!.image!),
                          ),
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: AppColors.grayColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomeTextField(
                      textEditingController: nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r"[a-zA-Z]+|\s"))
                      ],
                      hintText: "Name",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Name required";
                        } else if (!val.isValidName) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),
                    CustomeTextField(
                      textEditingController: emailController,
                      hintText: "Email",
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Email required";
                        } else if (!val.isValidEmail) {
                          return "Enter valid Email";
                        }
                        return null;
                      },
                    ),
                    CustomeTextField(
                      textEditingController: phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))
                      ],
                      hintText: "Phone",
                      validator: (val) {
                        // if (val!.isEmpty) {
                        //   return "Phone required";
                        // }
                        if (!val!.isValidPhone) {
                          return "Enter valid phone";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    BlocBuilder<SettingsBloc, SettingsState>(
                        builder: (context, state) {
                      return CustomButton(
                          widget: state is! UpdatePasswordLoadingState
                              ? const Text(
                                  "Save changes",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<SettingsBloc>(context)
                                  .add(UpdateProfileEvent(
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                image: BlocProvider.of<SettingsBloc>(context)
                                        .profileImage
                                        ?.path ??
                                    "",
                              ));
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          });
                    }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
