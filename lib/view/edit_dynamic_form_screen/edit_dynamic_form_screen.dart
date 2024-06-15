import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:m2p_assessment/model/data/form_template_response.dart';
import 'package:m2p_assessment/utils/app_colors.dart';
import 'package:m2p_assessment/widgets/custom_textfield.dart';
import 'package:m2p_assessment/widgets/dropdown_textfield.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/primary_button.dart';
import 'edit_dynamic_form_controller.dart';

class EditDynamicFormScreen extends StatefulWidget {
  const EditDynamicFormScreen({super.key});

  @override
  State<EditDynamicFormScreen> createState() => _EditDynamicFormScreenState();
}

class _EditDynamicFormScreenState extends State<EditDynamicFormScreen> {
  late EditDynamicFormController _editDynamicFormController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editDynamicFormController = Get.put(EditDynamicFormController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _editDynamicFormController.getFormDataTemplate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditDynamicFormController>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.themeColor,
        bottomSheet: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 10.0, bottom: 20, left: 16, right: 16),
          child: PrimaryButton(
            isEnabled: true,
            onPress: () {
              Map<String, String> data = {};
              _editDynamicFormController.textControllersMap
                  .forEach((key, value) {
                data[key] = value.text;
              });

              _editDynamicFormController.postFormDataRespinse().then((value) {
                if (value != null) {
                  Get.back();
                }
              });
            },
            title: 'Save',
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 16, right: 16),
              child: CustomText(
                "Dynamic Form",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            // const Spacer(),
            if (logic.isLoading.value)
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            //bottom sheet
            if (_editDynamicFormController.formTemplateResponse != null)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText("Agency Details",
                            fontWeight: FontWeight.bold),
                        Expanded(
                          child: ListView.builder(
                              itemCount: _editDynamicFormController
                                      .formTemplateResponse
                                      ?.parameters
                                      ?.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                Parameters? parameter =
                                    _editDynamicFormController
                                        .formTemplateResponse
                                        ?.parameters?[index];

                                if (parameter?.dataType == "String") {
                                  return _buildTextFieldWidget(
                                      parameter: parameter!, index: index);
                                } else if (parameter?.dataType ==
                                    "ConditionalSelection") {
                                  return _buildConditionalDropDownWidget(
                                      parameter: parameter!, index: index);
                                } else if (parameter?.dataType == "Date") {
                                  return _buildDateTextFieldWidget(
                                      parameter: parameter!, index: index);
                                } else {
                                  return _buildDropDownWidget(
                                      parameter: parameter!, index: index);
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildDropDownWidget(
      {required Parameters parameter, required int index}) {
    return CustomDropdownTextField(
      isValid: true,
      controller:
          _editDynamicFormController.textControllersMap[parameter.name] ??
              TextEditingController(),
      dropDownValues: parameter.possibleValues,
      hintText: parameter.displayName,
      currentSelectedValue:
          _editDynamicFormController.textControllersMap[parameter.name]?.text,
      onSelected: (String? value) {
        setState(() {
          _editDynamicFormController.textControllersMap[parameter.name]?.text =
              value ?? '';
        });
      },
    );
  }

  Widget _buildConditionalDropDownWidget(
      {required Parameters parameter, required int index}) {
    return CustomDropdownTextField(
      isValid: true,
      controller:
          _editDynamicFormController.textControllersMap[parameter.name] ??
              TextEditingController(),
      dropDownValues: getConditionalSelectionValues(parameter: parameter),
      hintText: parameter.displayName,
      currentSelectedValue:
          _getConditionalDropdownSelectedValue(parameter: parameter),
      onSelected: (String? value) {
        setState(() {
          _editDynamicFormController.textControllersMap[parameter.name]?.text =
              value ?? '';
        });
      },
    );
  }

  String? _getConditionalDropdownSelectedValue(
      {required Parameters parameter}) {
    List<String> values = getConditionalSelectionValues(parameter: parameter);
    if (values.contains(
        _editDynamicFormController.textControllersMap[parameter.name]?.text)) {
      return _editDynamicFormController
          .textControllersMap[parameter.name]?.text;
    } else {
      return null;
    }
  }

  List<String> getConditionalSelectionValues({required Parameters parameter}) {
    List<String> values = [];

    if (parameter.possibleValuesMap != null) {
      String? valueKey = _editDynamicFormController
          .textControllersMap[
              parameter.possibleValuesMap?["dependantFieldName"]]
          ?.text;
      if (valueKey != null) {
        values = parameter.possibleValuesMap?["value"][valueKey].cast<String>();
      }
    }

    return values.toSet().toList();
  }

  Widget _buildTextFieldWidget(
      {required Parameters parameter, required int index}) {
    return CustomTextField(
      isValid: true,
      hintText: parameter.displayName,
      controller:
          _editDynamicFormController.textControllersMap[parameter.name] ??
              TextEditingController(),
    );
  }

  Widget _buildDateTextFieldWidget(
      {required Parameters parameter, required int index}) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025, 12),
            builder: (context, picker) {
              return picker!;
            }).then((selectedDate) {
          //TODO: handle selected date
          if (selectedDate != null) {
            _editDynamicFormController.textControllersMap[parameter.name]
                ?.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          }
        });
      },
      child: AbsorbPointer(
        absorbing: true,
        child: CustomTextField(
          isValid: true,
          hintText: parameter.displayName,
          controller:
              _editDynamicFormController.textControllersMap[parameter.name] ??
                  TextEditingController(),
        ),
      ),
    );
  }
}
