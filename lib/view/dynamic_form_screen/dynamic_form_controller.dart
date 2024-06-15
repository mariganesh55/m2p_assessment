import 'package:get/get.dart';
import 'package:m2p_assessment/model/data/GetFormDataResponse.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

class DynamicFormController extends GetxController {
  RxBool isLoading = false.obs;
  GetFormDataResponse? getFormDataResponse;

  Future<GetFormDataResponse?> getFormData() async {
    isLoading.value = true;
    update();
    try {
      getFormDataResponse = await ApiService.getFormDataResponse();
      isLoading.value = false;
      update();
      return getFormDataResponse;
    } catch (e) {
      isLoading.value = false;
      update();
      throw Exception('Failed to load json');
    }
  }
}
