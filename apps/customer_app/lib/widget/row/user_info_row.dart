import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class UserInfoRow extends StatelessWidget {
  final String name, schoolNameOrParentPhone;
  final void Function() onEdit, onDelete, onAddImage;
  final bool isParent;
  const UserInfoRow({
    super.key,
    required this.name,
    required this.schoolNameOrParentPhone,
    required this.onEdit,
    required this.onDelete,
    required this.isParent,
    required this.onAddImage,
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
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff546F66)),
            ),
            Text(
              schoolNameOrParentPhone,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
          ],
        ),
        Spacer(),
        isParent
            ? Text('')
            : InkWell(
                onTap: onAddImage,
                child: const Icon(
                  Icons.add_a_photo,
                  color: Color(0xff6FBAE5),
                )),
        SizedBox(
          width: 2.w,
        ),
        InkWell(
            onTap: onEdit,
            child: Icon(
              Icons.edit_outlined,
              color: Color(0xffA3E9BF),
            )),
        SizedBox(
          width: 2.w,
        ),
        isParent
            ? Text('')
            : InkWell(
                onTap: onDelete,
                child: Icon(
                  Icons.delete,
                  color: const Color.fromARGB(255, 244, 67, 54),
                )),
        SizedBox(
          width: 2.w,
        )
      ],
    );
  }
}
