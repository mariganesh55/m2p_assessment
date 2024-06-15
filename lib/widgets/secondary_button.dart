import 'package:flutter/material.dart';
import 'package:m2p_assessment/widgets/custom_text.dart';

class SecondaryButton extends StatefulWidget {
  final VoidCallback onPress;
  final String title;
  final double fontSize;
  final bool? isEnabled;

  const SecondaryButton(
      {super.key,
      required this.onPress,
      required this.title,
      this.fontSize = 14,
      this.isEnabled = true});

  @override
  _SecondaryButtonState createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
          clipBehavior: Clip.hardEdge,
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              widget.title,
              color: widget.isEnabled == true ? Colors.blue : Colors.grey,
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
