import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:m2p_assessment/utils/app_colors.dart';
import 'package:m2p_assessment/widgets/custom_text.dart';
import 'package:m2p_assessment/widgets/custom_textfield.dart';
import 'package:m2p_assessment/widgets/primary_button.dart';

import '../otp_verification_screen/otp_verification_screen.dart';
import 'login_view_model.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _mobileTextController = TextEditingController();
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
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
                      loginState.when(
                        data: (_) => Padding(
                          padding: const EdgeInsets.only(top: 50.0, bottom: 20),
                          child: PrimaryButton(
                            onPress: () async {
                              setState(() {
                                _showError = true;
                              });
                              if (_validatePhoneNumber(
                                  _mobileTextController.text.trim())) {
                                await ref.read(loginProvider.notifier).login(
                                    mobileNumber:
                                        _mobileTextController.text.trim());

                                final loginSuccess =
                                    ref.read(loginProvider).maybeWhen(
                                          data: (_) => true,
                                          orElse: () => false,
                                        );
                                if (loginSuccess) {
                                  Get.to(OtpVerificationScreen(
                                    mobileNumber:
                                        '+91 ${_mobileTextController.text.trim()}',
                                    clientLoginResponse: ref
                                        .read(loginProvider.notifier)
                                        .clientLoginResponse!,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Login failed')),
                                  );
                                }
                              }
                            },
                            title: 'Login',
                          ),
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (err, stack) => Text('Error: $err'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
