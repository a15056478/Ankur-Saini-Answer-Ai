// ignore_for_file: use_build_context_synchronously

import 'package:answers_ai/common/theme_text.dart';
import 'package:answers_ai/presentation/home/home_page.dart';
import 'package:answers_ai/model/user/user_model.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends StatefulWidget {
  final UserInfo userInfo;
  const OTPVerificationPage({super.key, required this.userInfo});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  EmailOTP myauth = EmailOTP();

  sendOtp() async {
    myauth.setConfig(
        appEmail: "ankur.saini34@gmail.com",
        appName: "OTP verification",
        userEmail: widget.userInfo.email,
        otpLength: 6,
        otpType: OTPType.digitsOnly);
    if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: const Duration(milliseconds: 500),
        content: Text("OTP has been sent to ${widget.userInfo.email}"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 200),
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

  @override
  void initState() {
    email.text = widget.userInfo.email;
    sendOtp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  PinCodeTextField(
                    pinTheme: PinTheme.defaults(
                      shape: PinCodeFieldShape.circle,
                      borderRadius: BorderRadius.circular(16.r),
                      fieldHeight: 40.h,
                      borderWidth: 40.w,
                    ),
                    controller: otp,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    animationDuration: const Duration(milliseconds: 300),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue),
                            onPressed: () => sendOtp(),
                            child: Text(
                              "Resend OTP",
                              style: ThemeText.s12w500White,
                            )),
                      ),
                      const Gap(32),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            onPressed: () async {
                              if (await myauth.verifyOTP(otp: otp.text) ==
                                  true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.green,
                                  duration: const Duration(milliseconds: 300),
                                  content: Text(
                                    "OTP is verified",
                                    style: ThemeText.s12w500White,
                                  ),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage(
                                            userInfo: widget.userInfo,
                                          )),
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  duration: const Duration(milliseconds: 300),
                                  content: Text(
                                    "Invalid OTP",
                                    style: ThemeText.s12w500White,
                                  ),
                                ));
                              }
                            },
                            child: Text(
                              "Verify",
                              style: ThemeText.s12w500White,
                            )),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
