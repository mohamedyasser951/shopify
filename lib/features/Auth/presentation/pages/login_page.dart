import 'package:commerceapp/Config/constants/strings.dart';
import 'package:commerceapp/Config/widgets/customized_button.dart';
import 'package:commerceapp/Config/widgets/customized_text_field.dart';
import 'package:commerceapp/Config/components/dialogs.dart';
import 'package:commerceapp/Config/constants/image_paths.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:commerceapp/features/Auth/presentation/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthErrorState) {
        CustomDialog.animatedDialog(
            title: state.error, description: "", context: context);
      } else if (state is AuthSuccessState) {
        if (state.userModel.status == true) {
          var box = Hive.box(AppStrings.settingsBox);
          box.put("Token", state.userModel.data!.token).then((value) {
            CustomDialog.animatedDialog(
                isError: false,
                title: state.userModel.message!,
                description: "",
                context: context);

            Future.delayed(const Duration(seconds: 5))
                .then((value) => Navigator.of(context)
                    .pushNamedAndRemoveUntil("/home", (route) => false))
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
            child: LoginForm(),
          ),
        ),
      ));
    });
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
            height: 80,
          ),
          Text(
            "Login",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(
            height: 50.0,
          ),
          CustomeTextField(
            textEditingController: emailController,
            hintText: "Email",
            validator: (val) {
              if (val!.isEmpty) {
                return "Email required";
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
              } else if (val.length < 6) {
                return "password should be more 6 digit";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/register");
                },
                child: Text(
                  "Create an account?",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14),
                ),
              )),
          const SizedBox(
            height: 10.0,
          ),
          BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return CustomButton(
                widget: state is! AuthLoadingState
                    ? const Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(LoginEvent(
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
            height: 50.0,
          ),
          Center(
            child: Text(
              "Or login with social account",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(
            height: 40.0,
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
