import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_text.dart';

class CustomDropdownTextField extends StatefulWidget {
  CustomDropdownTextField(
      {super.key,
      required this.isValid,
      required this.controller,
      required this.onSelected,
      this.enable = true,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.inputFormatters,
      this.hintText,
      this.onChanged,
      this.dropDownValues,
      this.currentSelectedValue,
      this.showError = false});

  final bool isValid;
  final TextEditingController controller;
  final bool? enable;
  final bool? showError;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final void Function(String)? onChanged;
  final List<String>? dropDownValues;
  String? currentSelectedValue;
  void Function(String?)? onSelected;

  @override
  State<CustomDropdownTextField> createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
              counter: Container(),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: widget.isValid
                      ? BorderSide(
                          color: Colors.blue.withOpacity(0.3),
                        )
                      : const BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: widget.isValid
                      ? BorderSide(color: Colors.blue.withOpacity(0.3))
                      : const BorderSide(color: Colors.red)),
              contentPadding: const EdgeInsets.only(left: 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: widget.isValid
                      ? BorderSide(color: Colors.blue.withOpacity(0.3))
                      : const BorderSide(color: Colors.red)),
              errorStyle: const TextStyle(height: 0, fontSize: 0),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.grey.withOpacity(0.5))),
          isEmpty: widget.currentSelectedValue == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.currentSelectedValue == ""
                  ? null
                  : widget.currentSelectedValue,
              isDense: true,
              onChanged: (String? newValue) {
                setState(() {
                  widget.currentSelectedValue = newValue;

                  state.didChange(newValue);
                });
                widget.onSelected!(newValue);
              },
              items: widget.dropDownValues?.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: CustomText(
                      value,
                      isSingleLine: false,
                      fontSize: 12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
