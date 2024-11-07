import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.inkDrop(
      color: Colors.white,
      size: 50,
    ));
  }
}
