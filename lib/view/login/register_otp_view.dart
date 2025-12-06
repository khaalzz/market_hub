import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:food_delivery/view/login/login_view.dart';
import 'package:http/http.dart' as http;

class RegisterOTPView extends StatefulWidget {
  final String name;
  final String email;
  final String password;
  final String jurusan;
  final String mobile;

  const RegisterOTPView({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.jurusan,
    required this.mobile,
  });

  @override
  State<RegisterOTPView> createState() => _RegisterOTPViewState();
}

class _RegisterOTPViewState extends State<RegisterOTPView> {
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                "We have sent an OTP to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Please check your email ${widget.email}\nthen enter the OTP to complete registration.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 60),

              SizedBox(
                height: 60,
                child: OtpPinField(
                  key: _otpPinFieldController,
                  autoFillEnable: true,
                  textInputAction: TextInputAction.done,
                  onSubmit: (newCode) {
                    code = newCode;
                    btnSubmit();
                  },
                  onChange: (newCode) {
                    code = newCode;
                  },
                  onCodeChanged: (newCode) {
                    code = newCode;
                  },
                  fieldWidth: 40,
                  otpPinFieldStyle: OtpPinFieldStyle(
                    defaultFieldBorderColor: Colors.transparent,
                    activeFieldBorderColor: Colors.transparent,
                    defaultFieldBackgroundColor: TColor.textfield,
                    activeFieldBackgroundColor: TColor.textfield,
                  ),
                  maxLength: 6,
                  showCursor: true,
                  cursorColor: TColor.placeholder,
                  upperChild: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.flutter_dash_outlined, size: 150),
                      SizedBox(height: 20),
                    ],
                  ),
                  showCustomKeyboard: false,
                  cursorWidth: 3,
                  mainAxisAlignment: MainAxisAlignment.center,
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ),

              const SizedBox(height: 30),
              RoundButton(
                title: "Next",
                onPressed: () {
                  btnSubmit();
                },
              ),
              TextButton(
                onPressed: () {
                  _resendOtp();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn't Received? ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Click Here",
                      style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ACTION
  void btnSubmit() {
    if (code.length != 6) {
      mdShowAlert(Globs.appName, MSG.enterCode, () {});
      return;
    }

    endEditing();
    _serviceVerifyOtp();
  }

  // SERVICE: Verify OTP register
  Future<void> _serviceVerifyOtp() async {
    Globs.showHUD();

    try {
      final uri =
          Uri.parse('http://127.0.0.1:8000/api/register/verify-otp');

      final res = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': widget.name,
          'email': widget.email,
          'password': widget.password,
          'jurusan': widget.jurusan,
          'mobile': widget.mobile,
          'otp_code': code,
        },
      );

      Globs.hideHUD();

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['success'] == true) {
        mdShowAlert(Globs.appName, "Registrasi berhasil!", () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (route) => false,
          );
        });
      } else {
        mdShowAlert(
          Globs.appName,
          data['message']?.toString() ?? MSG.fail,
          () {},
        );
      }
    } catch (e) {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, e.toString(), () {});
    }
  }

  // SERVICE: resend OTP register
  Future<void> _resendOtp() async {
    Globs.showHUD();

    try {
      final uri =
          Uri.parse('http://127.0.0.1:8000/api/register/request-otp');

      final res = await http.post(
        uri,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': widget.name,
          'email': widget.email,
          'password': widget.password,
          'jurusan': widget.jurusan,
          'mobile': widget.mobile,
        },
      );

      Globs.hideHUD();

      final data = jsonDecode(res.body);

      if (res.statusCode == 200 && data['success'] == true) {
        mdShowAlert(
          Globs.appName,
          "Kode OTP baru berhasil dikirim ke email kamu.",
          () {},
        );
      } else {
        mdShowAlert(
          Globs.appName,
          data['message']?.toString() ?? MSG.fail,
          () {},
        );
      }
    } catch (e) {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, e.toString(), () {});
    }
  }
}
