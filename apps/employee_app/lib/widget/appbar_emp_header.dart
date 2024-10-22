import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class EmployeeHeader extends StatelessWidget {
  const EmployeeHeader({
    super.key,
    required this.isTitle,
    this.title,
  });

  final bool isTitle;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      //will changed
      height: 23.h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffFEFEFD), Color(0xffE0D1BB)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/image/logo.png',
            //will changed
            height: 11.h,
          ),
          //will changed
          SizedBox(height: 1.h),
          Padding(
            //will changed
            padding: EdgeInsets.symmetric(horizontal: 2.5.h),
            child: isTitle != true
                ? TextField(
                    decoration: InputDecoration(
                      hintText: 'البحث عن صنف معين .....',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          //will changed
                          EdgeInsets.symmetric(vertical: 1.0.h),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/image/emp_icon_title.png'),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                        child: Text(
                          title ?? '',
                          style: TextStyle(
                              fontSize: 23.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Image.asset('assets/image/emp_icon_title.png'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
