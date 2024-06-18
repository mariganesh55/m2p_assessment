import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m2p_assessment/model/data/client_login_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

final loginProvider =
    StateNotifierProvider<LoginNotifier, AsyncValue<void>>((ref) {
  return LoginNotifier();
});

class LoginNotifier extends StateNotifier<AsyncValue<void>> {
  LoginNotifier() : super(const AsyncValue.data(null));

  ClientLoginResponse? clientLoginResponse;

  Future<void> login({required String mobileNumber}) async {
    state = const AsyncValue.loading();
    try {
      clientLoginResponse =
          await ApiService.getClientLoginResponse(mobileNumber: mobileNumber);
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }
}
