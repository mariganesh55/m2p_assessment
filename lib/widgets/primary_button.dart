import 'package:flutter/material.dart';
import 'package:m2p_assessment/widgets/custom_text.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback onPress;
  final String title;
  final double fontSize;
  final bool? isEnabled;

  const PrimaryButton(
      {super.key,
      required this.onPress,
      required this.title,
      this.fontSize = 14,
      this.isEnabled = true});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          clipBehavior: Clip.hardEdge,
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: widget.isEnabled == true
                ? Colors.blue
                : const Color(0xffCAD4DC),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              widget.title,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            if (widget.isEnabled == true) {
              widget.onPress();
            }
          }),
    );
  }
}
