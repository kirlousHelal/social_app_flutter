import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/SocialApp/layout/social_layout.dart';
import 'package:continuelearning/SocialApp/modules/login/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/modules/login/cubit/states.dart';
import 'package:continuelearning/SocialApp/modules/register/register_screen.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:continuelearning/SocialApp/shared/constants/constants.dart';
import 'package:continuelearning/SocialApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController userController = TextEditingController();

  TextEditingController passController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode userFocusNode = FocusNode();

  FocusNode passFocusNode = FocusNode();

  bool isPassword = true;

  bool emailError = false;
  bool userError = false;
  bool passError = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleKeyPress(RawKeyEvent event, context) {
    // Check if the pressed key is the "Tab" key
    if (event.logicalKey == LogicalKeyboardKey.tab) {
      print("Tab key pressed!");
      LoginCubit.get(context).changeFocus();
      // You can perform actions here if Tab is pressed
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginPostSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId.toString());
            print(uId);
            uId = state.uId.toString();
            navigateTo(
                context: context,
                widget: const SocialLayout(),
                removeAllPrevious: true);
          } else if (state is LoginPostErrorState) {
            showToast(
                message: state.error as String,
                backgroundColor: ToastColors.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: const Text(
                "Login Screen",
              ),
            ),
            body: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (value) => handleKeyPress(value, context),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "login now to browse our hot offers",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              emailTextForm(context),
                              const SizedBox(height: 20),
                              passwordTextForm(context),
                              const SizedBox(height: 20),
                              // loginButton(context),
                              ConditionalBuilder(
                                  condition: state is! LoginPostLoadingState,
                                  builder: (context) => loginButton(context),
                                  fallback: (context) => Center(
                                        child: CircularProgressIndicator(
                                            color: defaultColor),
                                      )),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text("Don't have an account?",
                                      style: TextStyle(color: Colors.black)),
                                  defaultTextButton(
                                      onPress: () {
                                        navigateTo(
                                            context: context,
                                            widget: RegisterScreen(),
                                            removeAllPrevious: false);
                                      },
                                      text: "register",
                                      foregroundColor: defaultColor,
                                      isUppercase: true,
                                      fontSize: 16),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userTextForm(context) => defaultTextForm(
        focusColor: userError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: userError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: userFocusNode,
        onTap: () {
          // setState(() {});
          LoginCubit.get(context).changeFocus();
        },
        onSubmit: (value) {
          // setState(() {});
          LoginCubit.get(context).changeFocus();
        },
        controller: userController,
        validator: (value) {
          if (value!.isEmpty) {
            userError = true;
            return "must enter the User Name";
          }
          userError = false;
          return null;
        },
        label: "User",
        prefixIcon: Icons.person,
      );

  Widget passwordTextForm(context) => defaultTextForm(
        focusColor: passError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: passError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: passFocusNode,
        onTap: () {
          LoginCubit.get(context).changeFocus();
        },
        onSubmit: (value) {
          LoginCubit.get(context).changeFocus();
          FocusScope.of(context).unfocus(); // dismiss to keyboard
          if (formKey.currentState!.validate()) {
            LoginCubit.get(context).postData(
                email: emailController.text, password: passController.text);
          }
        },
        controller: passController,
        validator: (value) {
          if (value!.isEmpty) {
            passError = true;
            return "must enter the Password";
          }
          passError = false;
          return null;
        },
        label: "Password",
        prefixIcon: Icons.lock_outline_sharp,
        keyboardType: TextInputType.visiblePassword,
        suffixIcon: isPassword ? Icons.visibility : Icons.visibility_off,
        suffixPressed: () {
          // setState(() {});
          LoginCubit.get(context).changeFocus();

          if (isPassword) {
            isPassword = false;
          } else {
            isPassword = true;
          }
        },
        isPassword: isPassword,
      );

  Widget emailTextForm(context) => defaultTextForm(
        focusColor: emailError ? const Color(0xFFB00020) : defaultColor,
        unFocusColor: emailError ? const Color(0xFFB00020) : Colors.black54,
        focusNode: emailFocusNode,
        onTap: () {
          LoginCubit.get(context).changeFocus();

          // setState(() {});
        },
        onSubmit: (value) {
          LoginCubit.get(context).changeFocus();

          // setState(() {});
        },
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            emailError = true;
            return "must enter the Email";
          }
          emailError = false;
          return null;
        },
        label: "Email",
        prefixIcon: Icons.email_outlined,
      );

  Widget loginButton(context) => ElevatedButton(
        onPressed: () {
          LoginCubit.get(context).changeFocus();
          FocusScope.of(context).unfocus(); // dismiss to keyboard

          if (formKey.currentState!.validate()) {
            LoginCubit.get(context).postData(
                email: emailController.text, password: passController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: defaultColor,
          foregroundColor: Colors.white,
        ),
        child: const Text("Login"),
      );
}
