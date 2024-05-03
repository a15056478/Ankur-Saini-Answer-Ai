// ignore_for_file: prefer_final_fields, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:answers_ai/common/theme_text.dart';
import 'package:answers_ai/main.dart';
import 'package:answers_ai/model/prams/login/login_user_params.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:answers_ai/presentation/blocs/onboarding/login%20user/login_user_bloc.dart';
import 'package:answers_ai/presentation/otp/otp_verification_page.dart';
import 'package:answers_ai/presentation/signup/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:form_validator/form_validator.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  final _formKey = GlobalKey<FormState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    emailTextEditingController = TextEditingController(text: '');
    passwordTextEditingController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginUserBloc, LoginUserState>(
        listener: (context, state) {
          if (state is LoginVerficationFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                duration: const Duration(milliseconds: 500),
                content: Text(
                  "Invalid Credentials",
                  style: ThemeText.s12w500White,
                ),
              ),
            );
          } else if (state is LoginVerficationSuccess) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPVerificationPage(
                          userInfo: UserInfo(
                              email: emailTextEditingController.text,
                              token: passwordTextEditingController.text),
                        )));
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
                              40,
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
                          dprint(emailTextEditingController.text);
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginUserBloc>(context).add(
                              LoginButtonPressedEvent(
                                params: LoginUserParams(
                                  userInfo: UserInfo(
                                    email: emailTextEditingController.text,
                                    token: passwordTextEditingController.text,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text('LOGIN', style: ThemeText.s12w600White),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'or Login with',
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
                                    BlocProvider.of<LoginUserBloc>(context).add(
                                        LoginButtonPressedEvent(
                                            params: LoginUserParams(
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
                                builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        "I am new user",
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
