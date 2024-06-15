import 'package:get/get.dart';
import 'package:m2p_assessment/model/data/access_token_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

class OtpVerificationController extends GetxController {
  Future<AccessTokenResponse?> getAccessToken({required String otp}) async {
    AccessTokenResponse? accessTokenResponse;
    try {
      accessTokenResponse = await ApiService.getAccessToken(otp: otp);
      return accessTokenResponse;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }
}
