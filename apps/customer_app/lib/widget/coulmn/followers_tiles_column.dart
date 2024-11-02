import 'package:customer_app/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class FollowersTilesColumn extends StatelessWidget {
  const FollowersTilesColumn({
    super.key,
    required this.onAddFunds,
    required this.onAddOpenDays,
    required this.onPressPlanAndOrder,
  });

  final Function() onAddFunds;
  final Function() onAddOpenDays;
  final Function() onPressPlanAndOrder;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTile(
          title: 'اضافة مصروف',
          onTap: onAddFunds,
        ),
        ProfileTile(
          title: 'اضافة يوم مفتوح',
          onTap: onAddOpenDays,
        ),
        ProfileTile(
          title: 'الطلبات و الخطط',
          onTap: onPressPlanAndOrder,
        ),
      ],
    );
  }
}
