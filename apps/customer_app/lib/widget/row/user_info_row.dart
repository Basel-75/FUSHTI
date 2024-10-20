import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class UserInfoRow extends StatelessWidget {
  final String name, schoolName;
  final void Function() onEdit, onDelete;
  final bool isParent;
  const UserInfoRow({
    super.key,
    required this.name,
    required this.schoolName,
    required this.onEdit,
    required this.onDelete, required this.isParent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 35.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              schoolName,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        IconButton(
            onPressed: onEdit,
            icon: Icon(
              Icons.edit_outlined,
              color: Colors.blueGrey,
            )),
            isParent ?Text(''):
        IconButton(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    );
  }
}
