import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:m2p_assessment/model/data/client_login_response.dart';
import 'package:m2p_assessment/utils/app_colors.dart';
import 'package:m2p_assessment/utils/preference_helper.dart';
import 'package:m2p_assessment/view/dynamic_form_screen/dynamic_form_screen.dart';
import 'package:m2p_assessment/view/otp_verification_screen/otp_verification_controller.dart';
import 'package:m2p_assessment/widgets/custom_textfield.dart';
import 'package:m2p_assessment/widgets/primary_button.dart';
import 'package:m2p_assessment/widgets/secondary_button.dart';

import '../../widgets/custom_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreen(
      {required this.mobileNumber,
      required this.clientLoginResponse,
      super.key});

  String mobileNumber;
  ClientLoginResponse clientLoginResponse;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late Timer _timer;
  int _start = 30;
  bool _isResendButtonEnabled = false;
  final TextEditingController _otpTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(OtpVerificationController());
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpVerificationController>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.themeColor,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.4)),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: CustomText(
                        "Verification",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              // Positioned bottom sheet
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: CustomText("Enter the 4 digit OTP sent to"),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            widget.mobileNumber,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              "Edit",
                              color: Colors.blue,
                              isUnderLine: true,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 10),
                        child: SizedBox(
                          width: 150,
                          child: CustomTextField(
                            isValid: true,
                            controller: _otpTextController,
                            keyboardType: TextInputType.phone,
                            maxLength: 4,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            hintText: '4 Digit OTP',
                            onChanged: (value) {
                              setState(() {
                                _validateOtp(value.trim());
                              });
                            },
                          ),
                        ),
                      ),
                      if (_start != 0)
                        CustomText(
                          timerText,
                          color: AppColors.themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 50.0,
                        ),
                        child: SecondaryButton(
                          isEnabled: _isResendButtonEnabled,
                          onPress: () {
                            _timer.cancel();
                            startTimer();
                          },
                          title: 'Resend OTP',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                        child: PrimaryButton(
                          isEnabled:
                              _validateOtp(_otpTextController.text.trim()),
                          onPress: () {
                            logic
                                .getAccessToken(
                                    otp: _otpTextController.text.trim())
                                .then((value) async {
                              await PreferenceHelper.setAccessToken(
                                  accessToken: value?.accessToken ?? '');
                              if (value != null) {
                                Get.to(const DynamicFormScreen());
                              }
                            });
                          },
                          title: 'Verify Mobile Number',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void startTimer() {
    _isResendButtonEnabled = false;
    _start = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isResendButtonEnabled = true;
        });
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool _validateOtp(String? value) {
    // Regular expression for validating mobile numbers
    String pattern = r'^(?:[+0]9)?[0-9]{4}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
