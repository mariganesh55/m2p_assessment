import 'package:get/get.dart';
import 'package:m2p_assessment/model/data/client_login_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

class LoginController extends GetxController {
  Future<ClientLoginResponse?> getClientLoginResponse() async {
    ClientLoginResponse? clientLoginResponse;
    try {
      clientLoginResponse = await ApiService.getClientLoginResponse();
      return clientLoginResponse;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }
}
