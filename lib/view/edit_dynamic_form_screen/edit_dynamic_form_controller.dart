import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:m2p_assessment/model/data/form_template_response.dart';
import 'package:m2p_assessment/model/data/post_form_data_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

class EditDynamicFormController extends GetxController {
  RxBool isLoading = false.obs;
  FormTemplateResponse? formTemplateResponse;
  Map<String, TextEditingController> textControllersMap = {};

  Future<FormTemplateResponse?> getFormDataTemplate() async {
    isLoading.value = true;
    update();
    try {
      formTemplateResponse = await ApiService.getFormTemplateResponse();
      formTemplateResponse?.parameters?.forEach((element) {
        textControllersMap[element.name!] = TextEditingController();
        if (element.defaultSelection != null) {
          textControllersMap[element.name!]?.text = element.defaultSelection!;
        }
      });
      isLoading.value = false;
      update();
      return formTemplateResponse;
    } catch (e) {
      isLoading.value = false;
      update();
      throw Exception('Failed to load json');
    }
  }

  Future<PostFormDataResponse?> postFormDataRespinse() async {
    try {
      PostFormDataResponse response = await ApiService.postFromDataResponse();
      return response;
    } catch (e) {
      throw Exception('Failed to load json');
    }
  }
}
