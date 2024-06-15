import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:m2p_assessment/utils/app_colors.dart';
import 'package:m2p_assessment/view/login_screen/login_controller.dart';
import 'package:m2p_assessment/view/otp_verification_screen/otp_verification_screen.dart';
import 'package:m2p_assessment/widgets/custom_text.dart';
import 'package:m2p_assessment/widgets/custom_textfield.dart';
import 'package:m2p_assessment/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileTextController = TextEditingController();
  bool _showError = false;

  late LoginController _loginController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginController = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.themeColor,
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200.0, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "Hi there",
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    CustomText(
                      "Login to start your work!",
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    )
                  ],
                ),
              ),
              // Positioned bottom sheet
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                          padding: const EdgeInsets.only(top: 30.0),
                          child: CustomTextField(
                            isValid: _showError
                                ? _validatePhoneNumber(
                                    _mobileTextController.text.trim())
                                : true,
                            controller: _mobileTextController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            hintText: 'Registered Mobile Number',
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            showError: _showError,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                          child: PrimaryButton(
                            onPress: () {
                              setState(() {
                                _showError = true;
                              });
                              if (_validatePhoneNumber(
                                  _mobileTextController.text.trim())) {
                                logic.getClientLoginResponse().then((value) {
                                  if (value != null) {
                                    Get.to(OtpVerificationScreen(
                                      mobileNumber:
                                          '+91 ${_mobileTextController.text.trim()}',
                                      clientLoginResponse: value,
                                    ));
                                  }
                                });
                              }
                            },
                            title: 'Login',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  bool _validatePhoneNumber(String? value) {
    // Regular expression for validating mobile numbers
    String pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
}
