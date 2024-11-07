import 'package:customer_app/widget/container/profile_small_container.dart';
import 'package:flutter/material.dart';

class InfoContainerRow extends StatelessWidget {
  final String titleOne, titleTow, titleThree;
  final String numOne, numTow, numThree;
  const InfoContainerRow({
    super.key,
    required this.titleOne,
    required this.titleTow,
    required this.titleThree,
    required this.numOne,
    required this.numTow,
    required this.numThree,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ProfileSmallContainer(
          title: titleOne,
          number: numOne,
        ),
        const SizedBox(
          width: 10,
        ),
        ProfileSmallContainer(
          title: titleTow,
          number: numTow,
        ),
        const SizedBox(
          width: 10,
        ),
        ProfileSmallContainer(
          title: titleThree,
          number: '$numThree رس',
        ),
      ],
    );
  }
}
