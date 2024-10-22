import 'package:customer_app/screen/bottomnavigator/bloc/bottomnavigator_bloc.dart';
import 'package:customer_app/screen/followers/followers_screen.dart';
import 'package:customer_app/screen/home/home_screen.dart';
import 'package:customer_app/screen/plan/plan_screen.dart';
import 'package:customer_app/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

class BottomNavigatorScreen extends StatelessWidget {
  const BottomNavigatorScreen({super.key});
  final List<Widget> screens = const [
    HomeScreen(),
    PlanScreen(),
    FollowersScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomnavigatorBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<BottomnavigatorBloc>();
        int selectedIndex = 0;
        return Scaffold(
          bottomNavigationBar: Directionality(
            textDirection: TextDirection.rtl,
            child: BlocBuilder<BottomnavigatorBloc, BottomnavigatorState>(
              builder: (context, state) {
                if (state is IndexChangeState) {
                  selectedIndex = state.index;
                }
                return FlashyTabBar(
                  onItemSelected: (index) {
                    bloc.add(NavigatorBetweenScreenEvent(selectedIndex: index));
                  },
                  selectedIndex: selectedIndex,
                  items: [
                    FlashyTabBarItem(
                      icon: const Icon(
                        Iconsax.home_bold,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('الرئيسية'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        LineAwesome.utensils_solid,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('الخطط'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        LineAwesome.child_solid,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('التابعين'),
                    ),
                    FlashyTabBarItem(
                      icon: const Icon(
                        Iconsax.profile_2user_bold,
                        color: Color(0xFFFDCB6A),
                        size: 30,
                      ),
                      title: const Text('صفحتي'),
                    ),
                  ],
                );
              },
            ),
          ),
          body: BlocBuilder<BottomnavigatorBloc, BottomnavigatorState>(
            builder: (context, state) {
              return screens[bloc.currentScreenIndex];
            },
          ),
        );
      }),
    );
  }
}
