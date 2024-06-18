import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m2p_assessment/model/data/form_template_response.dart';
import 'package:m2p_assessment/model/data/post_form_data_response.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

final editDynamicFormProvider =
    StateNotifierProvider<EditDynamicFormNotifier, AsyncValue<void>>((ref) {
  return EditDynamicFormNotifier();
});

class EditDynamicFormNotifier extends StateNotifier<AsyncValue<void>> {
  EditDynamicFormNotifier() : super(const AsyncValue.data(null));

  FormTemplateResponse? formTemplateResponse;
  Map<String, TextEditingController> textControllersMap = {};

  Future<void> getFormDataTemplate() async {
    state = const AsyncValue.loading();
    try {
      formTemplateResponse = await ApiService.getFormTemplateResponse();
      formTemplateResponse?.parameters?.forEach((element) {
        textControllersMap[element.name!] = TextEditingController();
        if (element.defaultSelection != null) {
          textControllersMap[element.name!]?.text = element.defaultSelection!;
        }
      });
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }

  Future<void> postFormDataResponse() async {
    state = const AsyncValue.loading();
    try {
      PostFormDataResponse response = await ApiService.postFromDataResponse();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }
}
