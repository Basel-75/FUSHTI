import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class AppBarRowButton extends StatelessWidget {
  final String walletAmount;
  const AppBarRowButton({
    super.key,
    required this.walletAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            width: 43,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffE0D2BC),
            ),
            child: const Icon(Iconsax.shopping_cart_outline),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            width: 43,
            height: 47,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xffE0D2BC),
            ),
            child: Column(
              children: [
                const Icon(
                  Iconsax.wallet_2_outline,
                ),
                Text(walletAmount)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
