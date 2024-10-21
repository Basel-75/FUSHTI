import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class DatePickerButton extends StatelessWidget {
  final String title;
  final Color? backgroundColor;
  final Function(DateTime)? onDateChange;
  const DatePickerButton({
    super.key,
    required this.title,
    this.backgroundColor,
    this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              width: 80.w,
              height: 40.h,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  EasyDateTimeLine(
                    initialDate: DateTime.now(),
                    onDateChange: onDateChange,
                    activeColor: const Color(0xffB04759),
                    locale: "ar",
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(40.w, 5.h),
                      backgroundColor: const Color.fromARGB(255, 94, 218, 119),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تأكيد',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? const Color(0xffB5C18E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
