// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:answers_ai/main.dart';
import 'package:answers_ai/model/prams/signup/create_user_params.dart';
import 'package:answers_ai/presentation/blocs/onboarding/create%20user/create_user_bloc.dart';
import 'package:answers_ai/presentation/login/login_page.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:answers_ai/presentation/otp/otp_verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/theme_text.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    emailTextEditingController = TextEditingController(text: '');
    passwordTextEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CreateUserBloc, CreateUserState>(
        listener: (context, state) {
          if (state is CreateUserVerficationSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPVerificationPage(
                          userInfo: UserInfo(
                              email: emailTextEditingController.text,
                              token: passwordTextEditingController.text),
                        )));
          } else if (state is CreateUserVerficationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 500),
                content: Text(
                  state.error,
                  style: ThemeText.s12w500White,
                ),
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: _emailFieldKey,
                      controller: emailTextEditingController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      validator: ValidationBuilder()
                          .regExp(
                            RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ),
                            'Invalid e-mail',
                          )
                          .build(),
                      scrollPadding: EdgeInsets.zero,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'abc@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              40.r,
                            ),
                          )),
                    ),
                    const Gap(32),
                    TextFormField(
                      key: _passwordFieldKey,
                      controller: passwordTextEditingController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: ValidationBuilder().minLength(5).build(),
                      onChanged: (value) {
                        _passwordFieldKey.currentState?.validate();
                      },
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          label: const Text('Password'),
                          // hintText: 'abc@gmail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              40.r,
                            ),
                          )),
                    ),
                    Gap(32.h),
                    SizedBox(
                      width: 150.w,
                      height: 48.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<CreateUserBloc>(context).add(
                                CreateButtonPressedEvent(
                                    params: CreateUserParams(
                                        userInfo: UserInfo(
                                            email:
                                                emailTextEditingController.text,
                                            token: passwordTextEditingController
                                                .text))));
                          }
                        },
                        child: Text('SIGN UP', style: ThemeText.s12w600White),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'or Sign Up with',
                        style: ThemeText.s12w300Black,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //For google Button
                        Expanded(
                          child: SizedBox(
                            child: FlutterSocialButton(
                              mini: true,
                              buttonType: ButtonType.google,
                              onTap: () async {
                                try {
                                  await _googleSignIn.signIn();
                                  if (_googleSignIn.currentUser != null) {
                                    dprint(_googleSignIn.currentUser!);

                                    final _user = UserInfo(
                                        email: _googleSignIn.currentUser!.email,
                                        token: _googleSignIn.currentUser!.id);

                                    await _googleSignIn.signOut();

                                    BlocProvider.of<CreateUserBloc>(context)
                                        .add(CreateButtonPressedEvent(
                                            params: CreateUserParams(
                                                userInfo: _user)));
                                  }
                                } catch (e) {
                                  dprint(e.toString());
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(32.h),
                    TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: Text(
                        "I am existing user!!",
                        style: ThemeText.s12w600White,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
