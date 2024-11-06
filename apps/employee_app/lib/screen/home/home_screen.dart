import 'package:employee_app/screen/product/add_product/add_product_screen.dart';
import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/home/cubit/home_cubit.dart';
import 'package:employee_app/screen/product/edit/edit_screen.dart';
import 'package:employee_app/widget/container/home_card.dart';
import 'package:employee_app/widget/coulmn/empty_space_column.dart';
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
              if (state.shouldRefresh) {
        // Call a method to refresh the product list
        context.read<HomeCubit>().refreshProducts();
      }
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
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        BoxIcons.bx_log_out,
                        color: Colors.white,
                        size: 3.5.h,
                      ))
                ],
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
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmpTitleName(
                      paddingTop: 0.6.h,
                      paddingRight: 2.h,
                      textSize: 18.sp,
                      schoolName:
                          '${cubit.appModel.empModel?.schoolModel.name}',
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
                                  .where((item) =>
                                      item.category == 'box' ||
                                      item.category == 'بوكس')
                                  .length,
                              (index) {
                                return HomeCard(
                                  // onTap: () {},
                                  onDelete: () => showConfirmDialog(
                                    context: context,
                                    onCancelBtnTap: () =>
                                        Navigator.pop(context),
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
                            .where((item) =>
                                item.category == 'product' ||
                                item.category == 'منتج')
                            .isNotEmpty
                        ? BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              return SizedBox(
                                height: 38.h,
                                width: 80.w,
                                child: GridView.builder(
                                  itemCount: cubit.menu
                                      .where((item) =>
                                          item.category == 'product' ||
                                          item.category == 'منتج')
                                      .length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1.0.h,
                                  ),
                                  itemBuilder: (context, index) {
                                    final filteredMenu = cubit.menu
                                        .where((item) =>
                                            item.category == 'product' ||
                                            item.category == 'منتج')
                                        .toList();
                                    return Center(
                                      child: HomeCard(
                                        productName:
                                            filteredMenu[index].foodName,
                                        price: '${filteredMenu[index].price}',
                                        cal: '${filteredMenu[index].cal}',
                                        imagePath: filteredMenu[index]
                                            .imageUrl
                                            .toString()
                                            .trim(),
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
                                                productInfo:
                                                    filteredMenu[index]),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: EmptySpaceColumn(msg: 'لا يوجد منتجات'),
                          )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
