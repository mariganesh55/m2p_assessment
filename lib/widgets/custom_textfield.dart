import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool isValid;
  final TextEditingController controller;
  final bool? enable;
  final bool? showError;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final void Function(String)? onChanged;

  const CustomTextField(
      {super.key,
      required this.isValid,
      required this.controller,
      this.enable = true,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.inputFormatters,
      this.hintText,
      this.onChanged,
      this.showError = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          enabled: widget.enable,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
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
        ),
        if (widget.showError == true && widget.isValid == false)
          Container(
            padding:
                const EdgeInsets.only(bottom: 5, left: 20, right: 5, top: 10),
            child: const Text(
              "Please enter a valid input",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
