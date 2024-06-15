import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:m2p_assessment/utils/app_colors.dart';
import 'package:m2p_assessment/view/edit_dynamic_form_screen/edit_dynamic_form_screen.dart';
import 'package:m2p_assessment/widgets/primary_button.dart';

import '../../widgets/custom_text.dart';
import 'dynamic_form_controller.dart';

class DynamicFormScreen extends StatefulWidget {
  const DynamicFormScreen({super.key});

  @override
  State<DynamicFormScreen> createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  late DynamicFormController _dynamicFormController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dynamicFormController = Get.put(DynamicFormController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dynamicFormController.getFormData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DynamicFormController>(builder: (logic) {
      return Scaffold(
        backgroundColor: AppColors.themeColor,
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
            //bottom sheet
            if (logic.isLoading.value)
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            if (logic.getFormDataResponse != null)
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
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: _buildAgencyTile(), //your widget here
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                          child: PrimaryButton(
                            isEnabled: true,
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditDynamicFormScreen(),
                                  ));
                            },
                            title: 'Edit',
                          ),
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

  _buildAgencyTile() {
    return ExpansionTile(
      title: CustomText("Agency Detail"),
      iconColor: AppColors.themeColor,
      collapsedIconColor: AppColors.themeColor,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffEBF5FD),
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      _dynamicFormController
                              .getFormDataResponse?.payload?[index].name ??
                          '',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomText(
                        _dynamicFormController
                                .getFormDataResponse?.payload?[index].value ??
                            '',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => Container(
                    height: 1,
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
              itemCount:
                  _dynamicFormController.getFormDataResponse?.payload?.length ??
                      0),
        ),
      ],
    );
  }
}
