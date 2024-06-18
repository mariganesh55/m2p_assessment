import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m2p_assessment/model/data/access_token_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

final otpVerificationProvider =
    StateNotifierProvider<OtpVerificationNotifier, AsyncValue<void>>((ref) {
  return OtpVerificationNotifier();
});

class OtpVerificationNotifier extends StateNotifier<AsyncValue<void>> {
  OtpVerificationNotifier() : super(const AsyncValue.data(null));

  AccessTokenResponse? accessTokenResponse;

  Future<void> getAccessToken({required String otp}) async {
    state = const AsyncValue.loading();
    try {
      accessTokenResponse = await ApiService.getAccessToken(otp: otp);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }
}
