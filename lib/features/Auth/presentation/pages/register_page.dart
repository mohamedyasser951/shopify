import 'package:commerceapp/Config/Extensions/validator_extenstion.dart';
import 'package:commerceapp/Config/components/dialogs.dart';
import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/Auth/presentation/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthErrorState) {
        snackBarWidget(context, state.error, Colors.red);
      } else if (state is AuthSuccessState) {
        if (state.userModel.status == true) {
          var box = Hive.box(AppStrings.settingsBox);
          box.put("Token", state.userModel.data!.token).then((value) {
            CustomDialog.animatedDialog(
                isError: false,
                title: state.userModel.message!,
                description: "",
                context: context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/home", (route) => false)
                .then((value) async {});
          });
        } else {
          CustomDialog.animatedDialog(
              title: state.userModel.message!,
              description: "",
              context: context);
        }
      }
    }, builder: (context, state) {
      return const SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: RegisterForm(),
          ),
        ),
      ));
    });
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 70,
          ),
          Text(
            "Sign up",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 40
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          CustomeTextField(
            textEditingController: nameController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
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
              if (val!.isEmpty) {
                return "Phone required";
              }
              if (!val.isValidPhone) {
                return "Enter valid phone";
              }
              return null;
            },
          ),
          CustomeTextField(
            textEditingController: passwordController,
            hintText: "Password",
            validator: (val) {
              if (val!.isEmpty) {
                return "password required";
              } else if (!val.isValidPassword) {
                return "Enter valid Password";
              }
              return null;
            },
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/login", (route) => false);
                },
                child: Text(
                  "Already have an account?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14),
                ),
              )),
          const SizedBox(
            height: 4.0,
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return CustomButton(
                widget: state is! AuthLoadingState
                    ? const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                        name: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim()));
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                });
          }),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              "Or sign up with social account",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              const Spacer(),
              SocialButton(imgPath: ImagesPath.google),
              const SizedBox(
                width: 50,
              ),
              SocialButton(imgPath: ImagesPath.faceBook),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
