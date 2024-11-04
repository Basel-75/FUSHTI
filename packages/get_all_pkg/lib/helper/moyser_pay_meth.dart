import 'dart:developer';

import 'package:get_all_pkg/get_all_pkg.dart';

Future< PaymentConfig?> moyserPay({required double priceTotal}) async {

  try {
  await dotenv.load(fileName: ".env");
    final PaymentConfig paymentConfig = PaymentConfig(
      publishableApiKey: dotenv.env['moyster_key']!,
      amount: (priceTotal * 100).toInt(), // SAR 257.58
      description: 'order #1324',

      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );

    // emit(OrderConformState(paymentConfig: paymentConfig));

    return paymentConfig;
  } catch (er) {
    log(" ::: moyserPay     $er");

    return null;
  }
}
