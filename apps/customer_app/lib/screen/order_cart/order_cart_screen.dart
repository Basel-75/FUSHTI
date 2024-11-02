import 'package:customer_app/screen/bottomnavigator/bottom_navigator_screen.dart';
import 'package:customer_app/screen/order_cart/cubit/order_cart_cubit.dart';
import 'package:customer_app/widget/container/add_plan_card.dart';
import 'package:customer_app/widget/container/pay_plan_bottom.dart';
import 'package:customer_app/widget/devider/custom_dot_line.dart';
import 'package:customer_app/widget/row/cal_row.dart';
import 'package:customer_app/widget/row/item_details.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class OrderCartScreen extends StatelessWidget {
  final ChildModel? childModel;
  const OrderCartScreen({super.key, required this.childModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCartCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          final cubit = context.read<OrderCartCubit>();

          cubit.childModel = childModel!;
          return BlocListener<OrderCartCubit, OrderCartState>(
            listener: (context, state) {
              if (state is ErorrState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.msg),
                  backgroundColor: Colors.red,
                ));
              }


              if(state is LodingState){
                showLoadingDialog(context: context);
              }

              if(state is DoneState){

                 Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("تم الدفع"),
                  backgroundColor: Colors.green,
                ));


                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) {
                    return const BottomNavigatorScreen();
                  },
                ));
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                title: Text(
                  'السلة',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                centerTitle: true,
                flexibleSpace: Container(
                  //height: 15.h,
                  decoration: const BoxDecoration(
                    color: Color(0xff6FBAE5),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                ),
                toolbarHeight: 11.h,
              ),
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'محتوى السلة للطالب : ${cubit.childModel.name}',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 37.h,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: BlocBuilder<OrderCartCubit, OrderCartState>(
                          builder: (context, state) {
                            return Column(
                              children: List.generate(
                                cubit.childModel.cartList.length,
                                (index) {
                                  return AddPlanCard(
                                    productName: cubit.childModel
                                        .cartList[index].foodMenuModel.foodName,
                                    cal: cubit.childModel.cartList[index]
                                        .foodMenuModel.cal
                                        .toString(),
                                    price: cubit.childModel.cartList[index]
                                        .foodMenuModel.price
                                        .toString(),
                                    quantity: cubit
                                        .childModel.cartList[index].que
                                        .toString(),
                                    imagePath: 'assets/image/boxImage.png',
                                    onAdd: () {
                                      cubit.onAdd(
                                          cartItem:
                                              cubit.childModel.cartList[index]);
                                    },
                                    onMinus: () {
                                      cubit.onMinus(
                                          cartItem:
                                              cubit.childModel.cartList[index]);
                                    },
                                    withoutDelete: false,
                                    onDelete: () {
                                      cubit.delItem(cartIndex: index);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const CustomDotLine(),
                    SizedBox(
                      height: 1.h,
                    ),
                    SizedBox(
                      height: 17.h,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: [
                              const Text('الطلبات'),
                              SizedBox(
                                height: 1.h,
                              ),
                              //coulmn for order
                              BlocBuilder<OrderCartCubit, OrderCartState>(
                                builder: (context, state) {
                                  return Column(
                                      children: cubit.childModel.cartList.map(
                                    (e) {
                                      return ItemDetails(
                                        productName: e.foodMenuModel.foodName,
                                        price: (e.foodMenuModel.price * e.que)
                                            .toString(),
                                        quantity: e.que.toString(),
                                      );
                                    },
                                  ).toList());
                                },
                              ),
                              SizedBox(
                                height: 2.h,
                              ),

                              SizedBox(
                                height: 2.h,
                              ),

                              BlocBuilder<OrderCartCubit, OrderCartState>(
                                builder: (context, state) {
                                  return CalRow(
                                    totalCal: cubit.calculateCal(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<OrderCartCubit, OrderCartState>(
                      builder: (context, state) {
                        return PayPlanBottom(
                          totalPrice: cubit.calculateTotal(),
                          onPressed: () {
                            cubit.payPlan();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
