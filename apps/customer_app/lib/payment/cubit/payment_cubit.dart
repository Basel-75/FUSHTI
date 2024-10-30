// import 'package:bloc/bloc.dart';
// import 'package:get_all_pkg/get_all_pkg.dart';
// import 'package:meta/meta.dart';

// part 'payment_state.dart';

// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(PaymentInitial());
//   updateFunds({required double totalPrice}) async {
//     await dotenv.load(fileName: ".env");

//     try {
//       final paymentConfig = PaymentConfig(
//         publishableApiKey: dotenv.env['moyaser_key']!,
//         amount: (totalPrice * 100).toInt(), // SAR 257.58
//         description: 'عملية شحن المحفظة',

//         creditCard: CreditCardConfig(saveCard: true, manual: false),
//       );

//       emit(WalletConfirmState(paymentConfig: paymentConfig));
//     } catch (er) {
//       emit(ErrorState(msg: "تعذر شحن المحفظة يرجى المحاولة لاحقا"));
//     }
//   }

//   checkOut({required PaymentResponse paymentResponse}) async {
//     if (paymentResponse.status == PaymentStatus.paid) {
     

//       emit(SuccessState(msg: "تم الشحن بنجاح"));
//     } else if (paymentResponse.status == PaymentStatus.failed) {
//       emit(ErrorState(msg: "تعذر شحن المحفظة يرجى المحاولة لاحقا"));
//       return;
//     }
//   }
// }
