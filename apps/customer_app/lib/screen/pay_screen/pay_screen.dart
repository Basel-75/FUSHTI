import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';


class PayScreen extends StatelessWidget {
  const PayScreen({super.key, required this.paymentConfig});

  final PaymentConfig paymentConfig;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CreditCard(
            config: paymentConfig,
            onPaymentResult: (PaymentResponse paymentResponse) {
              log("here is pay page");
              Navigator.of(context).pop(paymentResponse);
            }),
      ),
    );
  }
}
