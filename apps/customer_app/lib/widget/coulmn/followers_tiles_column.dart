import 'package:customer_app/widget/container/profile_tile.dart';
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
          forLogout: false,
        ),
        ProfileTile(
          title: 'اضافة يوم مفتوح',
          onTap: onAddOpenDays,
          forLogout: false,
        ),
        ProfileTile(
          title: 'الطلبات و الخطط',
          onTap: onPressPlanAndOrder,
          forLogout: false,
        ),
      ],
    );
  }
}
