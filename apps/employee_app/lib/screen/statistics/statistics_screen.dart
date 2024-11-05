import 'package:employee_app/screen/feedback/feedback_screen.dart';
import 'package:employee_app/screen/product/add_product/add_product_screen.dart';
import 'package:employee_app/screen/statistics/cubit/statistics_cubit.dart';
import 'package:employee_app/widget/container/container_statistics.dart';
import 'package:employee_app/widget/textTitle/title_name.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatisticsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<StatisticsCubit>();
        cubit.getSales();
        cubit.getOrders();
        return BlocListener<StatisticsCubit, StatisticsState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showLoadingDialog(context: context);
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              showSnackBar(context: context, msg: state.msg, isError: true);
            }
            if (state is DoneState) {
              //Navigator.pop(context);
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
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        BoxIcons.bx_log_out,
                        color: Colors.white,
                        size: 3.5.h,
                      ))
                ],
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    EmpTitleName(
                      paddingTop: 0.6.h,
                      paddingRight: 2.h,
                      textSize: 18.sp,
                      schoolName:
                          '${cubit.appModel.empModel?.schoolModel.name}',
                    ),
                    const Divider(),
                    SizedBox(
                      height: 2.h,
                    ),
                    EmpTitleName(
                      paddingRight: 2.h,
                      schoolName: 'أرقام',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContainerStatistics(
                                statisticsName: 'المبيعات',
                                statisticsNumber: cubit.salesCount.length,
                                statisticsIcon: Icon(
                                  Icons.add_chart_outlined,
                                  color:
                                      const Color(0xff06374E).withOpacity(0.80),
                                ),
                                containerColor: const Color(0xffF6FAFD)),
                            ContainerStatistics(
                                statisticsName: 'الدخل',
                                statisticsNumber: cubit.price,
                                statisticsIcon: Icon(
                                  Icons.attach_money,
                                  color:
                                      const Color(0xff06374E).withOpacity(0.80),
                                ),
                                containerColor: const Color(0xffF6FAFD)),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContainerStatistics(
                                statisticsName: 'الطلبات',
                                statisticsNumber: cubit.orders.length,
                                statisticsIcon: Icon(
                                  Icons.area_chart_outlined,
                                  color:
                                      const Color(0xff06374E).withOpacity(0.80),
                                ),
                                containerColor: const Color(0xffF6FAFD)),
                            ContainerStatistics(
                                statisticsName: 'عدد المنتجات',
                                statisticsNumber:
                                    cubit.schoolModel.foodMenuModelList.length,
                                statisticsIcon: Icon(
                                  Icons.ssid_chart,
                                  color:
                                      const Color(0xff06374E).withOpacity(0.80),
                                ),
                                containerColor: const Color(0xffF6FAFD)),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.h),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('الاحصائيات',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return AspectRatio(
                            aspectRatio: 2.0,
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: true),
                                titlesData: const FlTitlesData(),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: const Color(0xff37434d), width: 1),
                                ),
                                minX: 0,
                                maxX: 4, // Adjusted for 5 points
                                minY: 0,
                                maxY: cubit.price +
                                    10, // Slightly above price to add padding
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(
                                          0,
                                          cubit.price *
                                              0.7), // Modify as needed
                                      FlSpot(1, cubit.price * 0.5),
                                      FlSpot(2, cubit.price * 0.9),
                                      FlSpot(3, cubit.price * 0.6),
                                      FlSpot(4, cubit.price.toDouble()),
                                    ],
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 4,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: const FlDotData(show: true),
                                  ),
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, cubit.salesCount.length * 0.7),
                                      FlSpot(1, cubit.salesCount.length * 0.5),
                                      FlSpot(2, cubit.salesCount.length * 0.9),
                                      FlSpot(3, cubit.salesCount.length * 0.6),
                                      FlSpot(4,
                                          cubit.salesCount.length.toDouble()),
                                    ],
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 4,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: const FlDotData(show: true),
                                  ),

                                  // Line for total orders
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, cubit.orders.length * 0.7),
                                      FlSpot(1, cubit.orders.length * 0.5),
                                      FlSpot(2, cubit.orders.length * 0.9),
                                      FlSpot(3, cubit.orders.length * 0.6),
                                      FlSpot(
                                          4, cubit.emp.totalOrder.toDouble()),
                                    ],
                                    isCurved: true,
                                    color: Colors
                                        .green, // Different color for distinction
                                    barWidth: 4,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: const FlDotData(show: true),
                                  ),
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(
                                          0,
                                          cubit.schoolModel.foodMenuModelList
                                                  .length *
                                              0.7),
                                      FlSpot(
                                          1,
                                          cubit.schoolModel.foodMenuModelList
                                                  .length *
                                              0.5),
                                      FlSpot(
                                          2,
                                          cubit.schoolModel.foodMenuModelList
                                                  .length *
                                              0.9),
                                      FlSpot(
                                          3,
                                          cubit.schoolModel.foodMenuModelList
                                                  .length *
                                              0.6),
                                      FlSpot(
                                          4,
                                          cubit.schoolModel.foodMenuModelList
                                              .length
                                              .toDouble()),
                                    ],
                                    isCurved: true,
                                    color: Colors.blue,
                                    barWidth: 4,
                                    belowBarData: BarAreaData(show: false),
                                    dotData: const FlDotData(show: true),
                                  ),
                                ],
                              ),
                            ));
                      },
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
