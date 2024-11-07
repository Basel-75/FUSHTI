import 'package:get_all_pkg/get_all_pkg.dart';

Future<PaymentConfig?> moyserPay({required double priceTotal}) async {
  try {
    await dotenv.load(fileName: "packages/database_meth/.env");
    final PaymentConfig paymentConfig = PaymentConfig(
      publishableApiKey: dotenv.env['moyaser_key']!,
      amount: (priceTotal * 100).toInt(), // SAR 257.58
      description: 'عملية شحن المحفظة',

      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );

    return paymentConfig;
  } catch (er) {
    return null;
  }
}
