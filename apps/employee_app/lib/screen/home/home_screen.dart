import 'dart:developer';

import 'package:employee_app/screen/product/add_product/add_product_screen.dart';
import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/home/cubit/home_cubit.dart';
import 'package:employee_app/screen/product/edit/edit_screen.dart';
import 'package:employee_app/widget/appbar_emp_header.dart';
import 'package:employee_app/widget/container/card_home_product.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<HomeCubit>();
        return BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is SuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              showSnackBar(context: context, msg: state.msg, isError: false);
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              Navigator.pop(context);
              showSnackBar(context: context, msg: state.msg, isError: true);
            }
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: const Color(0xffC9E7E7),
                tooltip: 'add Saving',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (builder) {
                    return const AddProductScreen();
                  }));
                },
                child: const Icon(Icons.add, color: Colors.white, size: 28),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return const FeedBackScreen();
                      }));
                    },
                    icon: const Icon(
                      Bootstrap.chat_text_fill,
                      color: Colors.white,
                    )),
                title: Image.asset('assets/image/mainLogo.png'),
                centerTitle: true,
                flexibleSpace: Container(
                  decoration: const ShapeDecoration(
                    shape: SmoothRectangleBorder(
                        borderRadius: SmoothBorderRadius.only(
                      bottomLeft:
                          SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                      bottomRight:
                          SmoothRadius(cornerRadius: 50, cornerSmoothing: 0.1),
                    )),
                    color: Color(0xff6FBAE5),
                  ),
                ),
                toolbarHeight: 15.h,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EmpTitleName(
                    paddingTop: 0.6.h,
                    paddingRight: 2.h,
                    textSize: 18.sp,
                    schoolName: 'كافتيريا الثانوية السابعة للبنات',
                  ),
                  const Divider(),
                  EmpTitleName(
                    schoolName: 'البوكسات',
                    paddingRight: 1.3.h,
                  ),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                            cubit.menu
                                .where((item) => item.category == 'box')
                                .length,
                            (index) {
                              return HomeCard(
                                // onTap: () {},
                                onDelete: () => showConfirmDialog(
                                  context: context,
                                  onCancelBtnTap: () => Navigator.pop(context),
                                  onConfirmBtnTap: () => cubit.deleteProduct(
                                      productId: cubit.menu[index].id),
                                ),
                                onEdit: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                        productInfo: cubit.menu[index]),
                                  ),
                                ),
                                cal: cubit.menu[index].cal.toString(),
                                imagePath: cubit.menu[index].imageUrl
                                    .toString()
                                    .trim(),
                                productName: cubit.menu[index].foodName,
                                price: '${cubit.menu[index].price as double}',
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  EmpTitleName(
                    schoolName: 'منتجاتي',
                    paddingRight: 1.3.h,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  cubit.menu
                          .where((item) => item.category == 'product')
                          .isNotEmpty
                      ? BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return SizedBox(
                              height: 39.5.h,
                              width: 80.w,
                              child: GridView.builder(
                                itemCount: cubit.menu
                                    .where((item) => item.category == 'product')
                                    .length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 1.0.h,
                                  //mainAxisSpacing: 0.0.h,
                                  //childAspectRatio: 0.12.h,
                                ),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 4.w, vertical: 2.h),
                                itemBuilder: (context, index) {
                                  final filteredMenu = cubit.menu
                                      .where(
                                          (item) => item.category == 'product')
                                      .toList();
                                  return Center(
                                    child: HomeCard(
                                      productName: filteredMenu[index].foodName,
                                      price: '${filteredMenu[index].price}',
                                      cal: '${filteredMenu[index].cal}',
                                      imagePath: filteredMenu[index]
                                          .imageUrl
                                          .toString()
                                          .trim(),
                                      onTap:
                                          () {}, // Optional, add functionality if needed.
                                      onDelete: () => showConfirmDialog(
                                        context: context,
                                        onCancelBtnTap: () =>
                                            Navigator.pop(context),
                                        onConfirmBtnTap: () =>
                                            cubit.deleteProduct(
                                                productId:
                                                    filteredMenu[index].id),
                                      ),
                                      onEdit: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditScreen(
                                              productInfo: filteredMenu[index]),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : const Text('Empty')
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ImageHandler extends StatelessWidget {
  const ImageHandler({
    super.key,
    required this.imagePath,
    this.errorWidget,
  });

  final String imagePath;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      fit: BoxFit.contain,
      imagePath,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ??
          const Icon(
            Icons.fastfood_rounded,
            color: Colors.orange,
          ),
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              : const CircularProgressIndicator(
                  color: Colors.white,
                ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String productName, price, cal, imagePath;
  final Function()? onTap, onDelete, onEdit;
  const HomeCard({
    super.key,
    required this.productName,
    required this.price,
    required this.cal,
    this.onTap,
    this.onDelete,
    this.onEdit,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.w,
      width: 35.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              width: 35.w,
              height: 35.w,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: kElevationToShadow[8]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    productName,
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: 1.w,
                  ),
                  Text(
                    '$price رس',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        cal,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0x50000000)),
                      ),
                      const Icon(LineAwesome.fire_alt_solid,
                          color: Color(0xffEC8743))
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              left: 12.w,
              bottom: 28.w,
              child: CircleAvatar(
                backgroundColor: const Color(0x88C8E5F5),
                child: ImageHandler(imagePath: imagePath),
              )),
          Positioned(
              left: 27.w,
              bottom: 32.w,
              child: InkWell(
                onTap: onDelete,
                child: const Icon(Icons.disabled_by_default_rounded,
                    color: Colors.red),
              )),
          //cancel
          Positioned(
            left: 3.w,
            bottom: 32.w,
            child: InkWell(
              onTap: onEdit,
              child: const Icon(Icons.mode_edit_outlined, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
