import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m2p_assessment/model/data/GetFormDataResponse.dart';
import 'package:m2p_assessment/model/service/api_service.dart';

final dynamicFormProvider =
    StateNotifierProvider<DynamicFormNotifier, AsyncValue<void>>((ref) {
  return DynamicFormNotifier();
});

class DynamicFormNotifier extends StateNotifier<AsyncValue<void>> {
  DynamicFormNotifier() : super(const AsyncValue.data(null));

  GetFormDataResponse? getFormDataResponse;

  Future<void> getFormData() async {
    state = const AsyncValue.loading();
    try {
      getFormDataResponse = await ApiService.getFormDataResponse();
      state = const AsyncValue.data(null);
    } catch (e) {
      state = AsyncValue.error('Login failed', StackTrace.current);
    }
  }
}
