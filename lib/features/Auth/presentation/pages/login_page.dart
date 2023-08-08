import 'package:commerceapp/Config/components/customized_button.dart';
import 'package:commerceapp/Config/components/customized_text_field.dart';
import 'package:commerceapp/Config/components/snack_bar.dart';
import 'package:commerceapp/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state is AuthErrorState) {
        snackBarWidget(context, state.error, Colors.red);
      } else if (state is AuthSuccessState) {
        if (state.userModel.status == true) {
          snackBarWidget(context, state.userModel.message!, Colors.green);
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/home", (route) => false);
        } else {
          snackBarWidget(context, state.userModel.message!, Colors.red);
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
            "Sign up",
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
          const SizedBox(
            height: 10.0,
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
            child: Text(
              "Already have an account?",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
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
              "Or sign up with social account",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
