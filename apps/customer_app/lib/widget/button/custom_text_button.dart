import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function() onPressed;
  final String question, buttonTitle;
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.question,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$question؟',
          style: const TextStyle(
            color: Color(0xff9A9FA5),
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonTitle,
            style: const TextStyle(
              color: Color(0xff103C37),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
